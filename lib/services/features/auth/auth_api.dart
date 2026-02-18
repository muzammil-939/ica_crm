import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ica_crm/services/core/session_manager.dart';
import 'package:ica_crm/services/features/auth/user_api.dart';

class AuthApi {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    try {
      print("LOGIN STARTED");

      final response = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        await _storage.write(key: 'access', value: data['access']);
        await _storage.write(key: 'refresh', value: data['refresh']);

        // Fetch user details
        final userApi = UserApi();
        final user = await userApi.getCurrentUser();

        if (user != null) {
          await _storage.write(key: 'user_email', value: user['email']);
          await _storage.write(key: 'user_username', value: user['username']);
        }

        return true;
      }

      return false;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }

  Future<void> logout() async {
    SessionManager().stopSessionMonitoring();
    final refresh = await _storage.read(key: 'refresh');

    await http.post(
      Uri.parse('$baseUrl/logout/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"refresh": refresh}),
    );

    await _storage.deleteAll();
  }
}
