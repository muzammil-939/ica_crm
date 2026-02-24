import 'package:flutter/material.dart';

class LeadHistory {
  final String id;
  final String userName;
  final String action;
  final DateTime createdAt;
  final String leadId;
  final String source;

  LeadHistory({
    required this.id,
    required this.userName,
    required this.action,
    required this.createdAt,
    required this.leadId,
    required this.source,
  });

  factory LeadHistory.fromJson(Map<String, dynamic> json) {
    return LeadHistory(
      id: json['id'].toString(),
      userName: json['user_name'] ?? 'System',
      action: json['action_type'] ?? 'UPDATED',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      leadId: json['lead']?.toString() ?? '',
      source: json['source']?.toString() ?? 'N/A',
    );
  }

  String get initials {
    if (userName.isEmpty) return '';
    final parts = userName.split(' ');
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Color get actionColor {
    final lower = action.toLowerCase();
    if (lower.contains('create')) return const Color(0xFF10B981);
    if (lower.contains('edit') || lower.contains('update')) {
      return const Color(0xFF3B82F6);
    }
    if (lower.contains('delete')) return const Color(0xFFEF4444);
    return const Color(0xFF8B5CF6);
  }
}