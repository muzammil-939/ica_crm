import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ica_crm/services/core/api_client.dart';
import 'package:ica_crm/services/core/jwt_helper.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ApiClient _client = ApiClient();

  Timer? _timer;

  Future<void> startSessionMonitoring() async {
    await _scheduleNextRefresh();
  }

  void stopSessionMonitoring() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _scheduleNextRefresh() async {
    final access = await _storage.read(key: 'access');
    if (access == null) return;

    final expiry = JwtHelper.getExpiry(access);
    if (expiry == null) return;

    final now = DateTime.now();
    final refreshTime = expiry.subtract(const Duration(seconds: 30));

    final duration = refreshTime.difference(now);

    if (duration.isNegative) {
      await _refreshNow();
      return;
    }

    _timer?.cancel();
    _timer = Timer(duration, () async {
      await _refreshNow();
    });
  }

  Future<void> _refreshNow() async {
    try {
      await _client.refreshForMonitoring();
      await _scheduleNextRefresh(); // schedule again after success
    } catch (_) {
      stopSessionMonitoring();
    }
  }
}
