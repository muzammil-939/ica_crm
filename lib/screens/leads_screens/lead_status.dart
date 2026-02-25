import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class LeadStatusScreen extends StatefulWidget {
  const LeadStatusScreen({super.key});

  @override
  State<LeadStatusScreen> createState() => _LeadStatusScreenState();
}

class _LeadStatusScreenState extends State<LeadStatusScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _itemsPerPage = 10;
  int get _totalPages {
    if (_statuses.isEmpty) return 1;
    return (_statuses.length / _itemsPerPage).ceil();
  }

  List<LeadStatus> get _paginatedStatuses {
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    return _statuses.sublist(
      start,
      end > _statuses.length ? _statuses.length : end,
    );
  }
  final LeadsApi _api = LeadsApi();
  List<LeadStatus> _statuses = [];
  bool _isLoading = true;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return MainLayout(
      title: 'Lead Status',
      child: Column(
        children: [
          // Header section with description
          Container(
            width: double.infinity,

            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lead Status',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 22 : (24),
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                Text(
                  'Configure and manage stages of your lead journey to track conversion progress.',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: isSmallScreen ? 13 : 14,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),

                // Add Status button and Search bar
                Row(
                  children: [
                    // Add Status button
                    ElevatedButton.icon(
                      onPressed: _showAddStatusDialog,
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(
                        'ADD STATUS',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00695C),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 10 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),

                    // Search field
                    Expanded(
                      child: Container(
                        height: isSmallScreen ? 40 : 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search statuses...',
                            hintStyle: TextStyle(
                              color: const Color(0xFF999999),
                              fontSize: isSmallScreen ? 13 : 14,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color(0xFF999999),
                              size: isSmallScreen ? 20 : 22,
                            ),
                            border: InputBorder.none,
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

                SizedBox(height: isSmallScreen ? 12 : 16),

                // Total count
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${_statuses.length} STATUSES',
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20,
              ),
              child: Column(
                children: [
                  // Table header
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 16,
                      vertical: isSmallScreen ? 10 : 12,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: isSmallScreen ? 25 : 40,
                          child: Text(
                            'S.NO',
                            style: TextStyle(
                              color: const Color(0xFF00897B),
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),

                        Expanded(
                          child: Text(
                            'STATUS NAME',
                            style: TextStyle(
                              color: const Color(0xFF00897B),
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: isSmallScreen ? 60 : 68,
                          child: Text(
                            'ACTIONS',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color(0xFF00897B),
                              fontSize: isSmallScreen ? 10 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),

                  // Table rows
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: _paginatedStatuses.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF0F0F0),
                        ),
                        itemBuilder: (context, index) {
                          final status = _paginatedStatuses[index];
                          return _buildStatusRow(
                            status,
                            isSmallScreen,
                            size.width,
                          );
                        },
                      ),
                    ),
                  ),

                  // Pagination
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 12 : 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: _currentPage > 1
                                  ? () {
                                setState(() {
                                  _currentPage--;
                                });
                              }
                                  : null,
                              icon: const Icon(Icons.chevron_left),
                            ),

                            Text(
                              '$_currentPage',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: _currentPage < _totalPages
                                  ? () {
                                setState(() {
                                  _currentPage++;
                                });
                              }
                                  : null,
                              icon: const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),

                        Text(
                          'PAGE $_currentPage OF $_totalPages',
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLeadStatuses();
  }

  Future<void> _fetchLeadStatuses({String? url}) async {
    setState(() => _isLoading = true);

    try {
      final response = await _api.getLeadStatuses(url: url);

      final List results = response['results'] ?? [];

      setState(() {
        _statuses =
            results.map((json) => LeadStatus.fromJson(json)).toList();
        _currentPage = 1; // important
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load statuses: $e")),
      );
    }
  }
  void _showEditStatusDialog(LeadStatus status) {
    final TextEditingController nameController =
    TextEditingController(text: status.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Lead Status',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Status name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedName = nameController.text.trim();
              if (updatedName.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                await _api.updateLeadStatus(
                  status.id,
                  {'name': updatedName},
                );

                setState(() {
                  final index =
                  _statuses.indexWhere((s) => s.id == status.id);

                  if (index != -1) {
                    _statuses[index] =
                        LeadStatus(id: status.id, name: updatedName);
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: $e')),
                );
              } finally {
                setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(LeadStatus status) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Status',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${status.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white
            ),
            onPressed: () async {
              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                await _api.deleteLeadStatus(status.id);

                setState(() {
                  _statuses.removeWhere((s) => s.id == status.id);

                  // Fix page if last item removed
                  if (_currentPage > _totalPages) {
                    _currentPage = _totalPages;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              } finally {
                setState(() => _isLoading = false);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddStatusDialog() {
    final TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF5F5F5), // subtle light gray background for dialog
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Add Lead Status',
          style: TextStyle(
            color: Color(0xFF00695C), // your teal-green main color
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Status name',
            hintStyle: const TextStyle(color: Color(0xFF999999)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF00695C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF004D40), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          style: const TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF00695C), // teal text color
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                final created = await _api.createLeadStatus({'name': name});

                final newStatus = LeadStatus.fromJson(created);

                setState(() {
                  _statuses.insert(0, newStatus); // Add on top
                  _currentPage = 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Status added successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add status: $e')),
                );
              } finally {
                setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C), // teal button bg
              foregroundColor: Colors.white, // white text
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(
      LeadStatus status,
      bool isSmallScreen,
      double screenWidth,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8 : 16,
        vertical: isSmallScreen ? 14 : 16,
      ),
      child: Row(
        children: [
          // Serial number (corrected for pagination)
          SizedBox(
            width: isSmallScreen ? 25 : 40,
            child: Text(
              '${((_currentPage - 1) * _itemsPerPage) + _paginatedStatuses.indexOf(status) + 1}',
              style: TextStyle(
                color: const Color(0xFF666666),
                fontSize: isSmallScreen ? 13 : 14,
              ),
            ),
          ),

          SizedBox(width: isSmallScreen ? 8 : 12),

          // Status name
          Expanded(
            child: Text(
              status.name,
              style: TextStyle(
                color: const Color(0xFF1A1A1A),
                fontSize: isSmallScreen ? 13 : 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _showEditStatusDialog(status),
                icon: const Icon(Icons.edit_outlined),
                color: const Color(0xFFFFA726),
                iconSize: isSmallScreen ? 18 : 20,
              ),
              IconButton(
                onPressed: () => _confirmDelete(status),
                icon: const Icon(Icons.delete_outline),
                color: const Color(0xFFE53935),
                iconSize: isSmallScreen ? 18 : 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class LeadStatus {
  final int id;
  final String name;

  LeadStatus({
    required this.id,
    required this.name,
  });

  factory LeadStatus.fromJson(Map<String, dynamic> json) {
    return LeadStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}