import 'dart:convert';
import 'package:ica_crm/services/core/api_client.dart';

class UserApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final response = await _client.get('/users/me/');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}
