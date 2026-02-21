import 'dart:convert';
import 'package:ica_crm/services/core/api_client.dart';

class LeadsApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> getLeads({String? url}) async {
    final endpoint = url != null && url.startsWith('http')
        ? url
        : (url ?? '/leads/');

    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception('Failed to load leads');
  }
}