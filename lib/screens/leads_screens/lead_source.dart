import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class LeadSourceScreen extends StatefulWidget {
  const LeadSourceScreen({super.key});

  @override
  State<LeadSourceScreen> createState() => _LeadSourceScreenState();
}

class _LeadSourceScreenState extends State<LeadSourceScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final LeadsApi _api = LeadsApi();
  List<Map<String, dynamic>> _leadSources = [];
  bool _isLoading = true;

  int _itemsPerPage = 10;

  int get _totalPages {
    if (_leadSources.isEmpty) return 1;
    return (_leadSources.length / _itemsPerPage).ceil();
  }

  List<Map<String, dynamic>> get _paginatedSources {
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;

    return _leadSources.sublist(
      start,
      end > _leadSources.length ? _leadSources.length : end,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isSmallScreen = size.width < 360;
    final startPage = (_currentPage - 1).clamp(1, _totalPages);
    final endPage = (_currentPage + 1).clamp(1, _totalPages);
    return MainLayout(
      title: 'Lead Source',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Lead Source',
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : (24),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                'Track and manage the origins of your leads from various marketing channels.',
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: isMobile ? 14 : 15,
                  height: 1.5,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 24),

              // Add Source Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showAddSourceDialog,
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: const Text(
                    'ADD SOURCE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00695C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or ID...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF999999),
                    size: 22,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xFF00695C),
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Table Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                ),
                child: Column(
                  children: [
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              'ID',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Expanded(
                            child: Text(
                              'SOURCE',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          // Hide CHANNEL ID on mobile
                          if (!isMobile)
                            const SizedBox(
                              width: 100,
                              child: Text(
                                'CHANNEL ID',
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),

                          SizedBox(
                            width: isMobile ? 60 : 70,
                            child: const Text(
                              'ACTIONS',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Table Rows
                    _isLoading
                        ? const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paginatedSources.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE0E0E0),
                      ),
                      itemBuilder: (context, index) {
                        return _buildLeadSourceRow(_paginatedSources[index], index);
                      },
                    ),

                    // Pagination
                    // Pagination (Mobile Optimized)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Page Info
                          Text(
                            'PAGE $_currentPage OF $_totalPages',
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Arrows + Numbers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: _currentPage > 1
                                    ? () => setState(() => _currentPage--)
                                    : null,
                                child: Icon(
                                  Icons.chevron_left,
                                  color: _currentPage > 1
                                      ? const Color(0xFF666666)
                                      : const Color(0xFFCCCCCC),
                                ),
                              ),

                              const SizedBox(width: 6),

                              ...List.generate(
                                _totalPages,
                                    (index) => index + 1,
                              )
                                  .where((page) =>
                              page >= _currentPage - 1 &&
                                  page <= _currentPage + 1)
                                  .map(
                                    (i) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () => setState(() => _currentPage = i),
                                    child: Container(
                                      width: 34,
                                      height: 34,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _currentPage == i
                                            ? const Color(0xFF00695C)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '$i',
                                        style: TextStyle(
                                          color: _currentPage == i
                                              ? Colors.white
                                              : const Color(0xFF666666),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),

                              const SizedBox(width: 6),

                              InkWell(
                                onTap: _currentPage < _totalPages
                                    ? () => setState(() => _currentPage++)
                                    : null,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: _currentPage < _totalPages
                                      ? const Color(0xFF666666)
                                      : const Color(0xFFCCCCCC),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLeadSources();
  }

  Future<void> _fetchLeadSources() async {
    try {
      final data = await _api.getLeadSources();

      final results = data['results'] ?? [];

      setState(() {
        _leadSources = List<Map<String, dynamic>>.from(results);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load sources: $e")),
      );
    }
  }

  void _showEditSourceDialog(Map<String, dynamic> source) {
    final TextEditingController controller =
    TextEditingController(text: source['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Lead Source',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Source name',
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
              final updatedName = controller.text.trim();
              if (updatedName.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                final updated = await _api.updateLeadSource(
                  source['id'],
                  {'name': updatedName},
                );

                setState(() {
                  final index = _leadSources.indexWhere(
                          (s) => s['id'] == source['id']);

                  if (index != -1) {
                    _leadSources[index] = updated;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Lead source updated successfully')),
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

  void _confirmDeleteSource(Map<String, dynamic> source) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Lead Source',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${source['name']}"?',
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
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                await _api.deleteLeadSource(source['id']);

                setState(() {
                  _leadSources.removeWhere(
                          (s) => s['id'] == source['id']);

                  if (_currentPage > _totalPages) {
                    _currentPage = _totalPages;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Lead source deleted successfully')),
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

  void _showAddSourceDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Lead Source',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Source name',
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
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => _isLoading = true);

                final created =
                await _api.createLeadSource({'name': name});

                setState(() {
                  _leadSources.insert(0, created);
                  _currentPage = 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Lead source added successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              } finally {
                setState(() => _isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadSourceRow(Map<String, dynamic> source, int index) {
    final String name = source['name']?.toString() ?? '';
    final int serialNumber =
        ((_currentPage - 1) * _itemsPerPage) + index + 1;

    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // ID
          SizedBox(
            width: 30,
            child: Text(
              '$serialNumber',
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // SOURCE (Flexible instead of fixed)
          Expanded(
            child: Row(
              children: [
                _buildSourceIcon(name),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Hide Channel ID on mobile
          if (!isMobile)
            const SizedBox(
              width: 100,
            ),

          // ACTIONS (shrink on mobile)
          SizedBox(
            width: isMobile ? 60 : 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => _showEditSourceDialog(source),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFFF9800),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _confirmDeleteSource(source),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFFE53935),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceIcon(String name) {
    IconData icon;
    Color bgColor;

    final lower = name.toLowerCase();

    if (lower.contains('facebook') || lower == 'fb') {
      icon = Icons.facebook;
      bgColor = const Color(0xFF1877F2);
    } else if (lower.contains('whatsapp')) {
      icon = Icons.message;
      bgColor = const Color(0xFF25D366);
    } else if (lower.contains('instagram') || lower == 'ig') {
      icon = Icons.camera_alt;
      bgColor = const Color(0xFFE1306C);
    } else if (lower.contains('web')) {
      icon = Icons.language;
      bgColor = const Color(0xFF00BFA5);
    } else {
      icon = Icons.navigation;
      bgColor = const Color(0xFF00BFA5);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: bgColor, size: 20),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
