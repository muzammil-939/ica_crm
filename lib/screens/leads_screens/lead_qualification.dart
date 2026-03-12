import 'package:flutter/material.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

import '../../layouts/main_layout.dart';

class LeadQualificationScreen extends StatefulWidget {
  const LeadQualificationScreen({super.key});

  @override
  State<LeadQualificationScreen> createState() =>
      _LeadQualificationScreenState();
}

class _LeadQualificationScreenState extends State<LeadQualificationScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _itemsPerPage = 10;

  int get _totalPages {
    if (_qualifications.isEmpty) return 1;
    return (_qualifications.length / _itemsPerPage).ceil();
  }

  List<Map<String, dynamic>> get _paginatedQualifications {
    final start = (_currentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;

    return _qualifications.sublist(
      start,
      end > _qualifications.length ? _qualifications.length : end,
    );
  }

  final LeadsApi _api = LeadsApi();

  List<Map<String, dynamic>> _qualifications = [];
  bool _loading = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadQualifications();
  }

  Future<void> _loadQualifications() async {
    try {
      final response = await _api.getLeadQualifications();

      setState(() {
        _qualifications = List<Map<String, dynamic>>.from(response["results"]);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      debugPrint(e.toString());
    }
  }

  void _addQualificationDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Qualification',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Qualification name',
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
              final name = controller.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => _loading = true);

                final created =
                await _api.createLeadQualification({'name': name});

                setState(() {
                  _qualifications.insert(0, created);
                  _currentPage = 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Qualification added successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              } finally {
                setState(() => _loading = false);
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width > 600;

    // Responsive sizing
    final headerFontSize = isSmallScreen ? 22.0 : (isTablet ? 28.0 : 24.0);
    final subtitleFontSize = isSmallScreen ? 13.0 : (isTablet ? 16.0 : 14.0);
    final buttonFontSize = isSmallScreen ? 12.0 : (isTablet ? 15.0 : 13.0);
    final tableFontSize = isSmallScreen ? 11.0 : (isTablet ? 14.0 : 12.0);
    final horizontalPadding = isSmallScreen ? 12.0 : (isTablet ? 32.0 : 16.0);

    return MainLayout(
      title: 'Lead Qualification',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Header section
              Text(
                'Lead Qualification',
                style: TextStyle(
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage educational backgrounds and professional degrees for lead segmentation.',
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 24),

              // Action bar with button and search
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // Add Qualification button
                  ElevatedButton.icon(
                    onPressed: _addQualificationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 20,
                        vertical: isSmallScreen ? 12 : 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add_circle_outline, size: 20),
                    label: Text(
                      'ADD QUALIFICATION',
                      style: TextStyle(
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // Search bar
                  Container(
                    width: isTablet
                        ? 300
                        : (isSmallScreen
                              ? size.width - (horizontalPadding * 2)
                              : 250),
                    height: isSmallScreen ? 44 : 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search qualifications...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: tableFontSize,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF999999),
                          size: isSmallScreen ? 20 : 22,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: isSmallScreen ? 12 : 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Qualifications count
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_qualifications.length} QUALIFICATIONS',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10.0 : 11.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF999999),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else
                // Table
                Container(
                  child: Column(
                    children: [
                      // Table header
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 14 : 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: isSmallScreen ? 35 : 50,
                              child: Text(
                                'S.NO',
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00897B),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'QUALIFICATION',
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00897B),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'CATEGORY',
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00897B),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: isSmallScreen ? 70 : 74,
                              child: Text(
                                'ACTIONS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: tableFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00897B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Table rows
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _paginatedQualifications.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          thickness: 1,
                          color: const Color(0xFFF0F0F0),
                        ),
                        itemBuilder: (context, index) {
                          final item = _paginatedQualifications[index];
                          return _buildTableRow(
                            item: item,
                            index: index,
                            isSmallScreen: isSmallScreen,
                            tableFontSize: tableFontSize,
                          );
                        },
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Pagination
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left pagination controls
                  Row(
                    children: [
                      IconButton(
                        onPressed: _currentPage > 1
                            ? () => setState(() => _currentPage--)
                            : null,
                        icon: const Icon(Icons.chevron_left),
                        color: const Color(0xFF666666),
                        iconSize: isSmallScreen ? 20 : 24,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: isSmallScreen ? 32 : 36,
                        height: isSmallScreen ? 32 : 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00695C),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: tableFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: isSmallScreen ? 32 : 36,
                        height: isSmallScreen ? 32 : 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: const Color(0xFF666666),
                            fontSize: tableFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _currentPage < _totalPages
                            ? () => setState(() => _currentPage++)
                            : null,
                        icon: const Icon(Icons.chevron_right),
                        color: const Color(0xFF666666),
                        iconSize: isSmallScreen ? 20 : 24,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  // Right page info
                  Text(
                    'PAGE 1 OF 2',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 10.0 : 11.0,
                      color: const Color(0xFF999999),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _editQualificationDialog(Map<String, dynamic> item) {
    final TextEditingController controller =
    TextEditingController(text: item['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Qualification',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Qualification name',
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
                setState(() => _loading = true);

                final updated = await _api.updateLeadQualification(
                  item['id'],
                  {"name": updatedName},
                );

                setState(() {
                  final index = _qualifications
                      .indexWhere((q) => q['id'] == item['id']);

                  if (index != -1) {
                    _qualifications[index] = updated;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Qualification updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: $e')),
                );
              } finally {
                setState(() => _loading = false);
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

  void _confirmDeleteQualification(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Qualification',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${item['name']}"?',
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
                setState(() => _loading = true);

                await _api.deleteLeadQualification(item['id']);

                setState(() {
                  _qualifications
                      .removeWhere((q) => q['id'] == item['id']);

                  if (_currentPage > _totalPages) {
                    _currentPage = _totalPages;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Qualification deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              } finally {
                setState(() => _loading = false);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required Map<String, dynamic> item,
    required int index,
    required bool isSmallScreen,
    required double tableFontSize,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 14 : 18,
      ),
      child: Row(
        children: [
          // Serial number
          SizedBox(
            width: isSmallScreen ? 35 : 50,
            child: Text(
              '${((_currentPage - 1) * _itemsPerPage) + index + 1}',
              style: TextStyle(
                fontSize: tableFontSize,
                color: const Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Qualification name with icon
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    size: isSmallScreen ? 16 : 18,
                    color: const Color(0xFF00897B),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 4 : 6),
                Expanded(
                  child: Text(
                    item['name'] ?? '',
                    style: TextStyle(
                      fontSize: tableFontSize,
                      color: const Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00897B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "QUALIFICATION",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 9.5 : 10.5,
                      color: const Color(0xFF00897B),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Action buttons
          SizedBox(
            width: isSmallScreen ? 60 : 74,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: isSmallScreen ? 60 : 74,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _editQualificationDialog(item);
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          color: const Color(0xFFFF9800),
                          size: isSmallScreen ? 18 : 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          _confirmDeleteQualification(item);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: const Color(0xFFE53935),
                          size: isSmallScreen ? 18 : 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QualificationItem {
  final int sNo;
  final String name;
  final String category;
  final Color categoryColor;

  QualificationItem({
    required this.sNo,
    required this.name,
    required this.category,
    required this.categoryColor,
  });
}
