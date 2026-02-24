import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';
import 'package:ica_crm/services/models/lead_history.dart';

class LeadHistoryScreen extends StatefulWidget {
  const LeadHistoryScreen({super.key});

  @override
  State<LeadHistoryScreen> createState() => _LeadHistoryScreenState();
}

class _LeadHistoryScreenState extends State<LeadHistoryScreen> {
  bool showFilters = false;
  final TextEditingController searchController = TextEditingController();
  final LeadsApi _api = LeadsApi();
  final TextEditingController _leadIdController = TextEditingController();
  List<LeadHistory> historyLogs = [];
  bool isLoading = true;
  String? nextPageUrl;
  bool hasMore = true;
  bool isFetchingMore = false;
  Set<String> selectedUsers = {};
  Set<String> selectedSources = {};
  Set<String> selectedActions = {};

  List<LeadHistory> allLogs = []; // keep original data

  final ScrollController _scrollController = ScrollController();

  String _formatDate(DateTime utc) {
    final ist = utc.toLocal(); // automatically converts using device timezone

    final hour = ist.hour > 12
        ? ist.hour - 12
        : ist.hour == 0
        ? 12
        : ist.hour;

    final amPm = ist.hour >= 12 ? "PM" : "AM";

    return "${ist.day}-${ist.month}-${ist.year} "
        "$hour:${ist.minute.toString().padLeft(2, '0')} $amPm";
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Lead History',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
        ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
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
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 8,
                  spacing: 8,
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
                        backgroundColor:
                        showFilters ? const Color(0xFF059669) : Colors.white,
                        foregroundColor:
                        showFilters ? Colors.white : Colors.black87,
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

                    if (selectedUsers.isNotEmpty ||
                        selectedSources.isNotEmpty ||
                        selectedActions.isNotEmpty ||
                        _leadIdController.text.isNotEmpty)
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedUsers.clear();
                            selectedSources.clear();
                            selectedActions.clear();
                            _leadIdController.clear();
                            historyLogs = List.from(allLogs);
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text(
                          'CLEAR FILTERS',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

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
                Text(
                  '${historyLogs.length} LOGS',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          ...historyLogs.map((log) => _buildHistoryCard(log)).toList(),

          if (hasMore)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),

          const SizedBox(height: 16),
        ],
      ),
          // Filters Panel
        if (showFilters)
    Positioned(
      top: 220,
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        elevation: 12,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                          /// DATE RANGE
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
                                        hintText: 'From (dd-mm-yyyy)',
                                        suffixIcon: const Icon(Icons.calendar_today, size: 16),
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
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'To (dd-mm-yyyy)',
                                      suffixIcon: const Icon(Icons.calendar_today, size: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// USERS
                          _buildFilterSection(
                            'USERS',
                            Icons.person_outline,
                            allLogs
                                .map((e) => e.userName)
                                .where((name) => name.isNotEmpty)
                                .toSet()
                                .toList(),
                            selectedUsers,
                          ),

                          const SizedBox(height: 20),

                          /// SOURCES
                          _buildFilterSection(
                            'SOURCES',
                            Icons.source_outlined,
                            [
                              'User Based Log',
                              'Website',
                              'System Based Log',
                            ],
                            selectedSources,
                          ),

                          const SizedBox(height: 20),

                          /// ACTIONS
                          _buildFilterSection(
                            'ACTIONS',
                            Icons.flash_on_outlined,
                            [
                              'Created',
                              'Opened',
                              'Updated',
                            ],
                            selectedActions,
                          ),

                          const SizedBox(height: 20),

                          /// LEAD ID
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
                            controller: _leadIdController,
                            decoration: InputDecoration(
                              hintText: 'Enter Lead ID...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// ACTION BUTTONS
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _applyFilters();

                                    setState(() {
                                      showFilters = false; // 👈 this closes the filter panel
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF059669),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'APPLY',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              TextButton(
                                onPressed: () {
                                  _leadIdController.clear();
                                },
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
          ),
        ),
      ),
    ),
      ], // <-- THIS closes Stack children
    ),
    );
  }
  @override
  void initState() {
    super.initState();
    _loadLogs();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isFetchingMore &&
          hasMore) {
        _loadMoreLogs();
      }
    });
  }

  Future<void> _loadLogs() async {
    try {
      final data = await _api.getLeadLogs();

      final results = data['results'] ?? [];

      setState(() {
        allLogs =
            results.map<LeadHistory>((j) => LeadHistory.fromJson(j)).toList();

        historyLogs = List.from(allLogs);
        print("USER NAMES:");
        for (var log in allLogs) {
          print(log.userName);
        }
        nextPageUrl = data['next'];
        hasMore = nextPageUrl != null;
        isLoading = false;
      });
    } catch (e) {
      print("LOAD LOGS ERROR: $e");

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading logs: $e")),
      );
    }
  }

  Future<void> _loadMoreLogs() async {
    if (nextPageUrl == null) return;

    setState(() => isFetchingMore = true);

    final data = await _api.getLeadLogs(url: nextPageUrl);
    final results = data['results'] ?? [];

    setState(() {
      historyLogs.addAll(
          results.map<LeadHistory>((j) => LeadHistory.fromJson(j)).toList());
      nextPageUrl = data['next'];
      hasMore = nextPageUrl != null;
      isFetchingMore = false;
    });
  }

  Widget _buildFilterSection(
      String title,
      IconData icon,
      List<String> options,
      Set<String> selectedSet,
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
                title: Text(options[index], style: const TextStyle(fontSize: 13)),
                value: selectedSet.contains(options[index]),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedSet.add(options[index]);
                    } else {
                      selectedSet.remove(options[index]);
                    }
                    _applyFilters();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ),
      ],
    );
  }

  void _applyFilters() {
    List<LeadHistory> filtered = List.from(allLogs);

    if (selectedUsers.isNotEmpty) {
      filtered = filtered
          .where((log) => selectedUsers.contains(log.userName))
          .toList();
    }

    if (selectedSources.isNotEmpty) {
      filtered = filtered
          .where((log) => selectedSources.contains(log.source))
          .toList();
    }

    if (selectedActions.isNotEmpty) {
      filtered = filtered
          .where((log) => selectedActions.contains(log.action))
          .toList();
    }

    if (_leadIdController.text.isNotEmpty) {
      filtered = filtered
          .where((log) =>
          log.leadId.contains(_leadIdController.text.trim()))
          .toList();
    }

    setState(() {
      historyLogs = filtered;
    });
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
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
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: history.actionColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          history.initials,
                          style: TextStyle(
                            color: history.actionColor,
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
                _buildDetailRow('Lead', history.leadId),
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
                        history.action.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          color: history.actionColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDetailRow('Source', history.source),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Created At',
                  _formatDate(history.createdAt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon,
      String label,
      Color color,
      ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: color),
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
        ),
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