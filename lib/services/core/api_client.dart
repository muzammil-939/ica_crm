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
    // 1. Clear tokens so the app knows we are logged out
    await _storage.deleteAll();

    // 2. Check if the navigator is actually ready
    final context = navigatorKey.currentContext;
    if (context == null) {
      // If we are here during app startup/hot restart and context isn't ready,
      // the main.dart logic should handle showing the login page naturally.
      return;
    }

    // 3. Only show the dialog if the user is already inside the app
    // and an active session expires.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Session Expired"),
        content: const Text("Your session has expired. Please sign in again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Use a post-frame callback to ensure navigation happens after dialog closes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
              });
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

    final uri = endpoint.startsWith('http')
        ? Uri.parse(endpoint)
        : Uri.parse('$baseUrl$endpoint');

    var response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        throw Exception("Session expired");
      }

      access = await _getAccessToken();

      response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
          'Content-Type': 'application/json',
        },
      );
    }

    return response;
  }

  Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    String? access = await _getAccessToken();

    var response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        throw Exception("Session expired");
      }

      access = await _getAccessToken();

      response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Authorization': 'Bearer $access',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
    }

    return response;
  }
  Future<http.Response> put(String endpoint, Map<String, dynamic> payload) async {
    String? access = await _getAccessToken();

    final url = endpoint.startsWith('http') ? Uri.parse(endpoint) : Uri.parse('$baseUrl$endpoint');

    var response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        throw Exception("Session expired");
      }

      access = await _getAccessToken();

      response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $access',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
    }

    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    String? access = await _getAccessToken();

    final url = endpoint.startsWith('http') ? Uri.parse(endpoint) : Uri.parse('$baseUrl$endpoint');

    var response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        throw Exception("Session expired");
      }

      access = await _getAccessToken();

      response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $access',
          'Content-Type': 'application/json',
        },
      );
    }

    return response;
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> payload) async {
    String? access = await _getAccessToken();

    final url = endpoint.startsWith('http')
        ? Uri.parse(endpoint)
        : Uri.parse('$baseUrl$endpoint');

    var response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer $access',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();

      if (!refreshed) {
        throw Exception("Session expired");
      }

      access = await _getAccessToken();

      response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $access',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );
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