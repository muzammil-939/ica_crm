import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

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

  // Sample leads data - in production this would come from an API
  final List<Lead> allLeads = [
    Lead(
      id: '#lead-1',
      initials: 'PR',
      initialsColor: const Color(0xFF10B981),
      name: 'Priya Sharma',
      email: 'priya.s@example.com',
      phone: '9988776655',
      country: 'India',
      source: LeadSource.website,
      assignedTo: 'Sarah',
      status: LeadStatus.fresh,
      createdAt: DateTime(2026, 2, 5, 22, 55),
    ),
    Lead(
      id: '#lead-2',
      initials: 'RA',
      initialsColor: const Color(0xFF3B82F6),
      name: 'Rahul Patel',
      email: 'rahul.p@example.com',
      phone: '9988776644',
      country: 'India',
      source: LeadSource.instagramAds,
      assignedTo: 'Emily',
      status: LeadStatus.hot,
      createdAt: DateTime(2026, 2, 3, 22, 55),
    ),
    Lead(
      id: '#lead-3',
      initials: 'DR',
      initialsColor: const Color(0xFF10B981),
      name: 'Dr. Anjali Gupta',
      email: 'anjali.g@example.com',
      phone: '9988776633',
      country: 'India',
      source: LeadSource.linkedin,
      assignedTo: 'Sarah',
      status: LeadStatus.warm,
      createdAt: DateTime(2026, 2, 5, 22, 55),
    ),
    Lead(
      id: '#lead-4',
      initials: 'DR',
      initialsColor: const Color(0xFF10B981),
      name: 'Dr. Rajesh Kumar',
      email: 'rajesh.k@example.com',
      phone: '9988776622',
      country: 'UAE',
      source: LeadSource.directReferral,
      assignedTo: 'Michael',
      status: LeadStatus.enrolled,
      createdAt: DateTime(2026, 1, 31, 4, 2),
    ),
    Lead(
      id: '#lead-5',
      initials: 'DR',
      initialsColor: const Color(0xFF10B981),
      name: 'Dr. Sneha Reddy',
      email: 'sneha.r@example.com',
      phone: '9988776611',
      country: 'India',
      source: LeadSource.website,
      assignedTo: 'Emily',
      status: LeadStatus.enrolled,
      createdAt: DateTime(2026, 1, 30, 0, 15),
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredLeads = allLeads;
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
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
                        onPressed: () {},
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
                        searchController.text.isNotEmpty)
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
            child: filteredLeads.isEmpty
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
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredLeads.length,
                    itemBuilder: (context, index) {
                      return _buildLeadCard(filteredLeads[index]);
                    },
                  ),
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
        return AlertDialog(
          title: const Text('Advanced Filters'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Status'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: LeadStatus.values.map((status) {
                    return FilterChip(
                      label: Text(status.displayName),
                      onSelected: (selected) {},
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('Source'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: LeadSource.values.map((source) {
                    return FilterChip(
                      label: Text(source.displayName),
                      onSelected: (selected) {},
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
                setState(() {
                  activeFilterCount = 1;
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
  final String initials;
  final Color initialsColor;
  final String name;
  final String email;
  final String phone;
  final String country;
  final LeadSource source;
  final String assignedTo;
  final LeadStatus status;
  final DateTime createdAt;

  Lead({
    required this.id,
    required this.initials,
    required this.initialsColor,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.source,
    required this.assignedTo,
    required this.status,
    required this.createdAt,
  });
}
