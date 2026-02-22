import 'dart:convert';
import 'package:ica_crm/services/core/api_client.dart';

class LeadsApi {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> _extractList(String endpoint) async {
    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) return data;
      if (data is Map && data.containsKey('results')) {
        return data['results'] ?? [];
      }

      return [];
    }

    throw Exception("Failed to load $endpoint");
  }

  /// =========================
  /// GET LEADS (Paginated)
  /// =========================
  Future<Map<String, dynamic>> getLeads({String? url}) async {
    final endpoint =
    url != null && url.startsWith('http') ? url : (url ?? '/leads/');

    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // If backend returns paginated map
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }

      // If backend accidentally returns raw list
      if (decoded is List) {
        return {
          "results": decoded,
          "next": null,
        };
      }
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception('Failed to load leads');
  }

  /// =========================
  /// CREATE LEAD
  /// =========================
  Future<Map<String, dynamic>> createLead(
      Map<String, dynamic> payload) async {
    final response = await _client.post('/leads/', payload);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      throw Exception(error.toString());
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception("Create failed: ${response.statusCode}");
  }

  /// =========================
  /// DROPDOWN APIs
  /// =========================

  Future<List<dynamic>> getStatuses() =>
      _extractList('/lead-status/');

  Future<List<dynamic>> getSources() =>
      _extractList('/lead-source/');

  Future<List<dynamic>> getCourses() =>
      _extractList('/lead-courses/');

  Future<List<dynamic>> getCountries() =>
      _extractList('/lead-countries/');

  Future<List<dynamic>> getQualifications() =>
      _extractList('/lead-qualifications/');

  Future<List<dynamic>> getUsers() =>
      _extractList('/users/');
}