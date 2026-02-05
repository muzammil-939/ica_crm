import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class LeadHistoryScreen extends StatefulWidget {
  const LeadHistoryScreen({super.key});

  @override
  State<LeadHistoryScreen> createState() => _LeadHistoryScreenState();
}

class _LeadHistoryScreenState extends State<LeadHistoryScreen> {
  bool showFilters = false;
  final TextEditingController searchController = TextEditingController();

  final List<LeadHistory> historyLogs = [
    LeadHistory(
      id: '#hist-101',
      userInitials: 'SW',
      userInitialsColor: const Color(0xFF059669),
      userName: 'Sarah Williams',
      leadId: 'lead-1',
      source: 'User Based Log',
      action: 'CREATED',
      actionColor: const Color(0xFF10B981),
      time: 'Feb 5 2026, 10:55 PM',
    ),
    LeadHistory(
      id: '#hist-102',
      userInitials: 'S',
      userInitialsColor: const Color(0xFF059669),
      userName: 'System',
      leadId: 'lead-1',
      source: 'Website',
      action: 'OPENED',
      actionColor: const Color(0xFF3B82F6),
      time: 'Feb 5 2026, 10:55 PM',
    ),
    LeadHistory(
      id: '#hist-103',
      userInitials: 'ED',
      userInitialsColor: const Color(0xFF059669),
      userName: 'Emily Davis',
      leadId: 'lead-2',
      source: 'Instagram',
      action: 'STATUS\nCHANGED',
      actionColor: const Color(0xFF8B5CF6),
      time: 'Feb 5 2026, 10:55 PM',
    ),
    LeadHistory(
      id: '#hist-104',
      userInitials: 'MC',
      userInitialsColor: const Color(0xFF059669),
      userName: 'Michael Chen',
      leadId: 'lead-4',
      source: 'Finance',
      action: 'PAYMENT\nRECEIVED',
      actionColor: const Color(0xFF059669),
      time: 'Feb 5 2026, 10:55 PM',
    ),
    LeadHistory(
      id: '#hist-105',
      userInitials: 'AJ',
      userInitialsColor: const Color(0xFF059669),
      userName: 'Alex Johnson',
      leadId: 'lead-5',
      source: 'System',
      action: 'ENROLLMENT\nCONFIRMED',
      actionColor: const Color(0xFF059669),
      time: 'Feb 5 2026, 10:55 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Lead History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Audit trail and chronological log of all interactions and status changes for leads.',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 16),
                // Filter and Search Row
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          showFilters = !showFilters;
                        });
                      },
                      icon: Icon(
                        Icons.filter_list,
                        size: 18,
                        color: showFilters ? Colors.white : Colors.black87,
                      ),
                      label: Text(
                        showFilters ? 'HIDE FILTERS' : 'SHOW FILTERS',
                        style: TextStyle(
                          color: showFilters ? Colors.white : Colors.black87,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showFilters
                            ? const Color(0xFF059669)
                            : Colors.white,
                        foregroundColor: showFilters
                            ? Colors.white
                            : Colors.black87,
                        elevation: 0,
                        side: BorderSide(
                          color: showFilters
                              ? const Color(0xFF059669)
                              : Colors.black26,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('EXPORT'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Log Details...',
                          hintStyle: const TextStyle(color: Colors.black38),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black38,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F7FA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh, color: Colors.black54),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F7FA),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Log count
                const Text(
                  '5 LOGS',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Filters Panel
          if (showFilters)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Color(0xFF059669),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'DATE RANGE',
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'dd-mm-yyyy',
                                hintStyle: const TextStyle(fontSize: 13),
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 18),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'dd-mm-yyyy',
                                hintStyle: const TextStyle(fontSize: 13),
                                suffixIcon: const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection('USERS', Icons.person_outline, [
                    'Sarah Williams',
                    'Michael Chen',
                    'Emily Davis',
                  ]),
                  const SizedBox(height: 16),
                  _buildFilterSection('SOURCES', Icons.source_outlined, [
                    'User Based Log',
                    'Website',
                    'System Based Log',
                  ]),
                  const SizedBox(height: 16),
                  _buildFilterSection('ACTIONS', Icons.flash_on_outlined, [
                    'Created',
                    'Opened',
                    'Updated',
                  ]),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.label_outline,
                            size: 14,
                            color: Color(0xFF059669),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'LEAD ID',
                            style: TextStyle(
                              color: Color(0xFF059669),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Lead ID...',
                          hintStyle: const TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF059669),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('APPLY'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Clear',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          // History List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyLogs.length,
              itemBuilder: (context, index) {
                return _buildHistoryCard(historyLogs[index]);
              },
            ),
          ),

          // Pagination
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF059669),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const Text(
                  'PAGE 1/1 • 5 LOGS',
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    IconData icon,
    List<String> options,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF059669)),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF059669),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(maxHeight: 120),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(
                  options[index],
                  style: const TextStyle(fontSize: 13),
                ),
                value: false,
                onChanged: (value) {},
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(LeadHistory history) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  history.id,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                _buildActionButton(
                  Icons.info_outline,
                  'INFO',
                  const Color(0xFF6B7280),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  Icons.open_in_new,
                  'LEAD',
                  const Color(0xFF059669),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  Icons.person_outline,
                  '',
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  Icons.description_outlined,
                  '',
                  const Color(0xFF3B82F6),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // User Info
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: history.userInitialsColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          history.userInitials,
                          style: TextStyle(
                            color: history.userInitialsColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        history.userName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Details Grid
                _buildDetailRow('Lead', history.leadId),
                const SizedBox(height: 12),
                _buildDetailRow('Source', history.source),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Action',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: history.actionColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        history.action,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: history.actionColor,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          history.time,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: label.isEmpty ? 8 : 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class LeadHistory {
  final String id;
  final String userInitials;
  final Color userInitialsColor;
  final String userName;
  final String leadId;
  final String source;
  final String action;
  final Color actionColor;
  final String time;

  LeadHistory({
    required this.id,
    required this.userInitials,
    required this.userInitialsColor,
    required this.userName,
    required this.leadId,
    required this.source,
    required this.action,
    required this.actionColor,
    required this.time,
  });
}
