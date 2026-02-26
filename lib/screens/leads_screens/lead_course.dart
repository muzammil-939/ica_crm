import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class LeadCourseScreen extends StatefulWidget {
  const LeadCourseScreen({super.key});

  @override
  State<LeadCourseScreen> createState() => _LeadCourseScreenState();
}

class _LeadCourseScreenState extends State<LeadCourseScreen> {
  final TextEditingController _searchController = TextEditingController();
  final LeadsApi _api = LeadsApi();

  bool isLoading = true;

  List<Map<String, dynamic>> allCourses = [];
  List<Map<String, dynamic>> filteredCourses = [];

  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchCourses();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchCourses() async {
    try {
      setState(() => isLoading = true);

      final data = await _api.getLeadCourses();

      setState(() {
        allCourses = data;
        filteredCourses = data;
        _totalCount = data.length;

        _totalPages = (filteredCourses.length / 10).ceil();
        if (_totalPages == 0) _totalPages = 1;

        _currentPage = 1;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load courses: $e")),
      );
    }
  }

  List<Map<String, dynamic>> get _paginatedCourses {
    const pageSize = 10;

    final start = (_currentPage - 1) * pageSize;
    final end = start + pageSize;

    if (start >= filteredCourses.length) return [];

    return filteredCourses.sublist(
      start,
      end > filteredCourses.length ? filteredCourses.length : end,
    );
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      filteredCourses = allCourses.where((course) {
        final name = course['name']?.toString().toLowerCase() ?? '';
        return name.contains(query);
      }).toList();

      _totalPages = (filteredCourses.length / 10).ceil();
      if (_totalPages == 0) _totalPages = 1;

      _currentPage = 1;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
      title: 'Lead Course',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Header section
              Text(
                'Lead Course',
                style: TextStyle(
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage the academic curriculum and professional certifications available for enrollment.',
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
                  // Add Course button
                  ElevatedButton.icon(
                    onPressed: _showCreateCourseDialog,
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
                      'ADD COURSE',
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
                        hintText: 'Search courses...',
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

              // Courses count
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${filteredCourses.length} COURSES',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10.0 : 11.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF999999),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Table
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
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
                            child: Text(
                              'COURSE NAME',
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
                      )
                    ),

                    // Table rows
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _paginatedCourses.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: const Color(0xFFF0F0F0),
                      ),
                      itemBuilder: (context, index) {
                        final item = _paginatedCourses[index];
                        return _buildTableRow(
                          item: item,
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
                    'PAGE $_currentPage OF $_totalPages',
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

  Widget _buildTableRow({
    required Map<String, dynamic> item,
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
          // Serial Number
          SizedBox(
            width: isSmallScreen ? 35 : 50,
            child: Text(
              '${item['id']}',
              style: TextStyle(
                fontSize: tableFontSize,
                color: const Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Course Name
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    size: isSmallScreen ? 16 : 18,
                    color: const Color(0xFF00897B),
                  ),
                ),
                const SizedBox(width: 8),
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

          // Actions
          IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showEditCourseDialog(item),
                  icon: const Icon(Icons.edit_outlined),
                  color: const Color(0xFFFF9800),
                  iconSize: isSmallScreen ? 18 : 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 4),
                IconButton(
                  onPressed: () => _confirmDelete(item),
                  icon: const Icon(Icons.delete_outline),
                  color: const Color(0xFFE53935),
                  iconSize: isSmallScreen ? 18 : 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditCourseDialog(Map<String, dynamic> course) {
    final TextEditingController nameController =
    TextEditingController(text: course['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Lead Course',
          style: TextStyle(
            color: Color(0xFFFFA726),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Course name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA726),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final updatedName = nameController.text.trim();
              if (updatedName.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => isLoading = true);

                final updated = await _api.updateLeadCourses(
                  course['id'],
                  {"name": updatedName},
                );

                if (!mounted) return;

                setState(() {
                  final index =
                  allCourses.indexWhere((c) => c['id'] == course['id']);

                  if (index != -1) {
                    allCourses[index] = updated;
                  }

                  filteredCourses = allCourses;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course updated successfully')),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Course',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${course['name']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
                setState(() => isLoading = true);

                await _api.deleteLeadCourses(course['id']);

                if (!mounted) return;

                setState(() {
                  allCourses.removeWhere((c) => c['id'] == course['id']);
                  filteredCourses.removeWhere((c) => c['id'] == course['id']);

                  _totalPages = (filteredCourses.length / 10).ceil();
                  if (_totalPages == 0) _totalPages = 1;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course deleted successfully')),
                );
              } catch (e) {
                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCreateCourseDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Create Lead Course',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Course name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => isLoading = true);

                final newCourse = await _api.createLeadCourses({
                  "name": name,
                });

                setState(() {
                  allCourses.insert(0, newCourse);
                  filteredCourses = allCourses;
                  _totalPages = (filteredCourses.length / 10).ceil();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Course created successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}