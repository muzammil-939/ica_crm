import 'package:flutter/material.dart';

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
  final int _totalPages = 2;

  final List<QualificationItem> _qualifications = [
    QualificationItem(
      sNo: 1,
      name: 'MBBS',
      category: 'MEDICAL',
      categoryColor: const Color(0xFF00897B),
    ),
    QualificationItem(
      sNo: 2,
      name: 'MD/MS/DNB',
      category: 'POST-GRADUATE',
      categoryColor: const Color(0xFF00897B),
    ),
    QualificationItem(
      sNo: 3,
      name: 'AYUSH',
      category: 'ALTERNATIVE',
      categoryColor: const Color(0xFF00897B),
    ),
    QualificationItem(
      sNo: 4,
      name: 'BDS/MDS',
      category: 'DENTAL',
      categoryColor: const Color(0xFF00897B),
    ),
    QualificationItem(
      sNo: 5,
      name: 'OTHER',
      category: 'MISC',
      categoryColor: const Color(0xFF00897B),
    ),
    QualificationItem(
      sNo: 6,
      name: 'PHARM D',
      category: 'PHARMACY',
      categoryColor: const Color(0xFF00897B),
    ),
  ];

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
                    onPressed: () {},
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
                  '15 QUALIFICATIONS',
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
                      itemCount: _qualifications.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: const Color(0xFFF0F0F0),
                      ),
                      itemBuilder: (context, index) {
                        final item = _qualifications[index];
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

  Widget _buildTableRow({
    required QualificationItem item,
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
              '${item.sNo}',
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
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.name,
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

          // Category badge
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              decoration: BoxDecoration(
                color: item.categoryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.category,
                style: TextStyle(
                  fontSize: isSmallScreen ? 9.5 : 10.5,
                  color: item.categoryColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          // Action buttons
          SizedBox(
            width: isSmallScreen ? 70 : 74,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined),
                  color: const Color(0xFFFF9800),
                  iconSize: isSmallScreen ? 18 : 20,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                  color: const Color(0xFFE53935),
                  iconSize: isSmallScreen ? 18 : 20,
                  padding: const EdgeInsets.all(4),
                  constraints: const BoxConstraints(),
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
