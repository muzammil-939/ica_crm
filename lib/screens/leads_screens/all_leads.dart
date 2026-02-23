import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';
import 'package:ica_crm/services/modals/leads/create_lead_dialog.dart';

class AllLeadsScreen extends StatefulWidget {
  const AllLeadsScreen({super.key});

  @override
  State<AllLeadsScreen> createState() => _AllLeadsScreenState();
}

class _AllLeadsScreenState extends State<AllLeadsScreen> {

  String selectedFilter = 'FRESH LEADS';
  final TextEditingController searchController = TextEditingController();
  int activeFilterCount = 0;
  List<Lead> filteredLeads = [];
  final LeadsApi _leadsApi = LeadsApi();
  bool isLoading = true;
  String? nextPageUrl;
  bool isFetchingMore = false;
  bool hasMore = true;
  Set<LeadStatus> selectedStatuses = {};
  Set<LeadSource> selectedSources = {};
  bool isAdvancedFilterActive = false;

  final ScrollController _scrollController = ScrollController();

  // leads data - in production this would come from an API
  List<Lead> allLeads = [];

  @override
  void initState() {
    super.initState();
    _loadLeads();
    searchController.addListener(_onSearchChanged);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isFetchingMore &&
          hasMore) {
        _loadMoreLeads();
      }
    });
  }

  Future<void> _loadMoreLeads() async {
    if (nextPageUrl == null) return;

    setState(() {
      isFetchingMore = true;
    });

    try {
      final data = await _leadsApi.getLeads(url: nextPageUrl);

      final List results = data['results'] ?? [];

      final newLeads =
      results.map((json) => Lead.fromJson(json)).toList();

      setState(() {
        allLeads.addAll(newLeads);
        filteredLeads = allLeads;
        nextPageUrl = data['next'];
        hasMore = nextPageUrl != null;
        isFetchingMore = false;
      });
    } catch (e) {
      print("ERROR LOADING MORE: $e");
      setState(() {
        isFetchingMore = false;
      });
    }
  }

  Future<void> _loadLeads() async {
    try {
      final data = await _leadsApi.getLeads();

      final List results = data['results'] ?? [];

      setState(() {
        allLeads = results
            .map((json) => Lead.fromJson(json))
            .toList();

        filteredLeads = allLeads;
        nextPageUrl = data['next'];
        hasMore = nextPageUrl != null;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR LOADING LEADS: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredLeads = allLeads.where((lead) {
        final searchTerm = searchController.text.toLowerCase();
        return lead.name.toLowerCase().contains(searchTerm) ||
            lead.email.toLowerCase().contains(searchTerm) ||
            lead.phone.contains(searchTerm);
      }).toList();
    });
  }

  void _applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      switch (filter) {
        case 'FRESH LEADS':
          filteredLeads = allLeads
              .where((lead) => lead.status == LeadStatus.fresh)
              .toList();
          break;
        case 'FOLLOW UP LEADS':
          filteredLeads = allLeads
              .where(
                (lead) =>
                    lead.status == LeadStatus.warm ||
                    lead.status == LeadStatus.hot,
              )
              .toList();
          break;
        case 'FOLLOW UPS TODAY':
          final today = DateTime.now();
          filteredLeads = allLeads
              .where(
                (lead) =>
                    lead.createdAt.day == today.day &&
                    lead.createdAt.month == today.month &&
                    lead.createdAt.year == today.year,
              )
              .toList();
          break;
        default:
          filteredLeads = allLeads;
      }
    });
  }

  void _clearFilters() {
    setState(() {
      selectedFilter = '';
      searchController.clear();
      filteredLeads = allLeads;
      activeFilterCount = 0;
      selectedStatuses.clear();
      selectedSources.clear();
      isAdvancedFilterActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'All Leads',
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
                  'Manage and track your entire lead pipeline with advanced filtering and bulk actions.',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 16),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                  context: context,
                  builder: (_) => CreateLeadDialog(
                    onSuccess: () {
                      _loadLeads(); // refresh after create
                      },
                      ),
                  );
                  },
                        icon: const Icon(Icons.person_add, size: 18),
                        label: const Text(
                          'REGISTER NEW LEAD',
                          style: TextStyle(fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF059669),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Open filter modal/dialog
                          _showFiltersDialog();
                        },
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.filter_list, size: 18),
                            if (activeFilterCount > 0)
                              Positioned(
                                right: -8,
                                top: -8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEF4444),
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$activeFilterCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        label: const Text(
                          'FILTERS',
                          style: TextStyle(fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          minimumSize: const Size(0, 48),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Clear Filters Button
                    if (selectedFilter.isNotEmpty ||
                        searchController.text.isNotEmpty ||
                        isAdvancedFilterActive)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _clearFilters,
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text(
                            'CLEAR FILTERS',
                            style: TextStyle(fontSize: 11),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFEF4444),
                            side: const BorderSide(color: Color(0xFFEF4444)),
                            minimumSize: const Size(0, 48),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name, email, phone...',
                    hintStyle: const TextStyle(color: Colors.black38),
                    prefixIcon: const Icon(Icons.search, color: Colors.black38),
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
              ],
            ),
          ),
          // Quick Filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text(
                    'QUICK FILTERS:',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildFilterChip(
                    'FRESH LEADS',
                    Icons.autorenew,
                    const Color(0xFF10B981),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'FOLLOW UP LEADS',
                    Icons.calendar_today,
                    const Color(0xFFF59E0B),
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'FOLLOW UPS TODAY',
                    Icons.bolt,
                    const Color(0xFFEF4444),
                  ),
                  const SizedBox(width: 8),
                  // Clear Filter X button
                  if (selectedFilter.isNotEmpty)
                    GestureDetector(
                      onTap: _clearFilters,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Row(
                          children: [
                            Icon(Icons.close, size: 16, color: Colors.black45),
                            SizedBox(width: 4),
                            Text(
                              'Clear Filter',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Leads List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredLeads.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.black26,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No leads found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters or search',
                          style: TextStyle(fontSize: 14, color: Colors.black38),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: filteredLeads.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < filteredLeads.length) {
                  return _buildLeadCard(filteredLeads[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            )
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, Color color) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => _applyFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? color : Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isSelected ? color : Colors.black54),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.black54,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadCard(Lead lead) {
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
          // Header with checkbox and actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  lead.id,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.black38, fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.black38, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Lead Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Name and initials
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: lead.initialsColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          lead.initials,
                          style: TextStyle(
                            color: lead.initialsColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lead.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lead.email,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Details Grid
                _buildDetailRow('Phone', lead.phone),
                const SizedBox(height: 12),
                _buildDetailRow('Country', lead.country),
                const SizedBox(height: 12),
                _buildDetailRow('Source', lead.source.displayName),
                const SizedBox(height: 12),
                _buildDetailRow('Assigned To', lead.assignedTo),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Status',
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
                        color: lead.status.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        lead.status.displayName,
                        style: TextStyle(
                          fontSize: 11,
                          color: lead.status.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDetailRow('Created At', _formatDateTime(lead.createdAt)),
              ],
            ),
          ),
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

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[dateTime.month - 1];
    final day = dateTime.day;
    final year = dateTime.year;
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$month $day, $year, $hour:$minute $period';
  }

  void _showFiltersDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Create TEMP copies of selections
        Set<LeadStatus> tempStatuses = Set.from(selectedStatuses);
        Set<LeadSource> tempSources = Set.from(selectedSources);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Advanced Filters'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text('Status'),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: LeadStatus.values.map((status) {
                        final isSelected = tempStatuses.contains(status);

                        return FilterChip(
                          label: Text(status.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              if (isSelected) {
                                tempStatuses.remove(status);
                              } else {
                                tempStatuses.add(status);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                    const Text('Source'),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: LeadSource.values.map((source) {
                        final isSelected = tempSources.contains(source);

                        return FilterChip(
                          label: Text(source.displayName),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              if (isSelected) {
                                tempSources.remove(source);
                              } else {
                                tempSources.add(source);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              actions: [

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    // Now commit selections to parent state
                    setState(() {
                      selectedStatuses = tempStatuses;
                      selectedSources = tempSources;

                      isAdvancedFilterActive =
                          selectedStatuses.isNotEmpty ||
                              selectedSources.isNotEmpty;

                      activeFilterCount =
                          selectedStatuses.length +
                              selectedSources.length;

                      filteredLeads = allLeads.where((lead) {
                        final statusMatch =
                            selectedStatuses.isEmpty ||
                                selectedStatuses.contains(lead.status);

                        final sourceMatch =
                            selectedSources.isEmpty ||
                                selectedSources.contains(lead.source);

                        return statusMatch && sourceMatch;
                      }).toList();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                  ),
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Enums for Lead Status
enum LeadStatus {
  fresh,
  hot,
  warm,
  cold,
  enrolled,
  lost;

  String get displayName {
    switch (this) {
      case LeadStatus.fresh:
        return 'FRESH LEAD';
      case LeadStatus.hot:
        return 'HOT LEAD';
      case LeadStatus.warm:
        return 'WARM LEAD';
      case LeadStatus.cold:
        return 'COLD LEAD';
      case LeadStatus.enrolled:
        return 'ENROLLED';
      case LeadStatus.lost:
        return 'LOST';
    }
  }

  Color get color {
    switch (this) {
      case LeadStatus.fresh:
        return const Color(0xFF10B981);
      case LeadStatus.hot:
        return const Color(0xFFEF4444);
      case LeadStatus.warm:
        return const Color(0xFFF59E0B);
      case LeadStatus.cold:
        return const Color(0xFF6B7280);
      case LeadStatus.enrolled:
        return const Color(0xFF6B7280);
      case LeadStatus.lost:
        return const Color(0xFF6B7280);
    }
  }
}

// Enums for Lead Source
enum LeadSource {
  website,
  instagramAds,
  facebookAds,
  linkedin,
  directReferral,
  coldCall,
  email,
  other;

  String get displayName {
    switch (this) {
      case LeadSource.website:
        return 'Website';
      case LeadSource.instagramAds:
        return 'Instagram Ads';
      case LeadSource.facebookAds:
        return 'Facebook Ads';
      case LeadSource.linkedin:
        return 'LinkedIn';
      case LeadSource.directReferral:
        return 'Direct Referral';
      case LeadSource.coldCall:
        return 'Cold Call';
      case LeadSource.email:
        return 'Email';
      case LeadSource.other:
        return 'Other';
    }
  }
}

// Lead Model
class Lead {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final String assignedTo;
  final LeadStatus status;
  final LeadSource source;
  final DateTime createdAt;

  Lead({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.assignedTo,
    required this.status,
    required this.source,
    required this.createdAt,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'].toString(),
      name: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country']?.toString() ?? '',
      assignedTo: json['assigned_to_name'] ?? '',
      status: _parseStatus(json['status_name']),
      source: _parseSource(json['source_name']),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  static LeadStatus _parseStatus(String? status) {
    if (status == null) return LeadStatus.fresh;

    final s = status.toLowerCase();

    if (s.contains('hot')) return LeadStatus.hot;
    if (s.contains('warm')) return LeadStatus.warm;
    if (s.contains('cold')) return LeadStatus.cold;
    if (s.contains('enroll')) return LeadStatus.enrolled;
    if (s.contains('lost')) return LeadStatus.lost;
    if (s.contains('follow')) return LeadStatus.warm;

    return LeadStatus.fresh;
  }

  static LeadSource _parseSource(String? source) {
    if (source == null) return LeadSource.other;

    final s = source.toLowerCase();

    if (s.contains('web')) return LeadSource.website;
    if (s.contains('instagram')) return LeadSource.instagramAds;
    if (s.contains('facebook')) return LeadSource.facebookAds;
    if (s.contains('linkedin')) return LeadSource.linkedin;
    if (s.contains('reference')) return LeadSource.directReferral;
    if (s.contains('call')) return LeadSource.coldCall;
    if (s.contains('email')) return LeadSource.email;

    return LeadSource.other;
  }

  /// Computed property for UI
  String get initials {
    if (name.isEmpty) return '';
    final parts = name.split(' ');
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  /// Computed color based on status
  Color get initialsColor => status.color;
}
