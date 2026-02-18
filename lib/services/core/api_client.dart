import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ica_crm/main.dart';

class ApiClient {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> _getAccessToken() async {
    return await _storage.read(key: 'access');
  }

  Future<void> _forceLogout() async {
    await _storage.deleteAll();

    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Session Expired"),
        content: const Text(
            "Your session has expired. Please sign in again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              navigatorKey.currentState!
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<bool> _refreshToken() async {
    final refresh = await _storage.read(key: 'refresh');

    if (refresh == null) {
      await _forceLogout();
      return false;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"refresh": refresh}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      await _storage.write(key: 'access', value: data['access']);

      // VERY IMPORTANT
      if (data.containsKey('refresh')) {
        await _storage.write(key: 'refresh', value: data['refresh']);
      }

      return true;
    }

    await _forceLogout();
    return false;
  }

  Future<http.Response> get(String endpoint) async {
    String? access = await _getAccessToken();

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        access = await _getAccessToken();

        return await http.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Authorization': 'Bearer $access',
            'Content-Type': 'application/json',
          },
        );
      } else {
        throw Exception("Session expired");
      }
    }

    return response;
  }

  Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    String? access = await _getAccessToken();

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (refreshed) {
        access = await _getAccessToken();

        return await http.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {
            'Authorization': 'Bearer $access',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );
      } else {
        throw Exception("Session expired");
      }
    }

    return response;
  }

  Future<void> refreshForMonitoring() async {
    final success = await _refreshToken();

    if (!success) {
      await _forceLogout();
      throw Exception("Session expired");
    }
  }

}
