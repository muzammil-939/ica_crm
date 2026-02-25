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
  /// Lead History API
  /// =========================
  Future<Map<String, dynamic>> getLeadLogs({String? url}) async {
    final endpoint =
    url != null && url.startsWith('http') ? url : (url ?? '/lead-logs/');

    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Case 1: Paginated response
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      // Case 2: Non-paginated list
      if (decoded is List) {
        return {
          "results": decoded,
          "next": null,
        };
      }
    }

    throw Exception("Failed to load lead logs");
  }

  Future<Map<String, dynamic>> getLeadStatuses({String? url}) async {
    final endpoint =
    url != null && url.startsWith('http')
        ? url
        : (url ?? '/lead-status/');

    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Case 1: Paginated response (Map)
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      // Case 2: Non-paginated list
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

    throw Exception("Failed to load lead statuses");
  }

  Future<Map<String, dynamic>> createLeadStatus(Map<String, dynamic> payload) async {
    final response = await _client.post('/lead-status/', payload);

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

    throw Exception("Create lead status failed: ${response.statusCode}");
  }
  /// =========================
  /// UPDATE LEAD STATUS
  /// =========================
  Future<Map<String, dynamic>> updateLeadStatus(int id, Map<String, dynamic> payload) async {
    final response = await _client.put('/lead-status/$id/', payload);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      throw Exception(error.toString());
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception("Update failed: ${response.statusCode}");
  }

  /// =========================
  /// DELETE LEAD STATUS
  /// =========================
  Future<void> deleteLeadStatus(int id) async {
    final response = await _client.delete('/lead-status/$id/');

    if (response.statusCode == 204) {
      return;
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception("Delete failed: ${response.statusCode}");
  }

  /// =========================
  /// LEAD SOURCE APIs
  /// =========================

  Future<Map<String, dynamic>> getLeadSources({String? url}) async {
    final endpoint =
    url != null && url.startsWith('http')
        ? url
        : (url ?? '/lead-source/');

    final response = await _client.get(endpoint);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Paginated
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      // Non-paginated
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

    throw Exception("Failed to load lead sources");
  }

  Future<Map<String, dynamic>> createLeadSource(
      Map<String, dynamic> payload) async {
    final response = await _client.post('/lead-source/', payload);

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

    throw Exception("Create lead source failed: ${response.statusCode}");
  }

  Future<Map<String, dynamic>> updateLeadSource(
      int id, Map<String, dynamic> payload) async {
    final response = await _client.put('/lead-source/$id/', payload);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      throw Exception(error.toString());
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception("Update failed: ${response.statusCode}");
  }

  Future<void> deleteLeadSource(int id) async {
    final response = await _client.delete('/lead-source/$id/');

    if (response.statusCode == 204) {
      return;
    }

    if (response.statusCode == 401) {
      throw Exception("Unauthorized. Please login again.");
    }

    throw Exception("Delete failed: ${response.statusCode}");
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