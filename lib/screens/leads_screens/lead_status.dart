import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class LeadStatusScreen extends StatefulWidget {
  const LeadStatusScreen({super.key});

  @override
  State<LeadStatusScreen> createState() => _LeadStatusScreenState();
}

class _LeadStatusScreenState extends State<LeadStatusScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _totalPages = 2;

  final List<LeadStatus> _statuses = [
    LeadStatus(id: 1, name: 'Admission done', color: const Color(0xFF00897B)),
    LeadStatus(
      id: 2,
      name: 'will enroll later',
      color: const Color(0xFF00897B),
    ),
    LeadStatus(id: 3, name: 'Junk', color: const Color(0xFF00897B)),
    LeadStatus(id: 4, name: 'Fresh Lead', color: const Color(0xFF00897B)),
    LeadStatus(id: 5, name: 'Followup', color: const Color(0xFF00897B)),
  ];

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
            color: Colors.white,
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      onPressed: () {},
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
                          color: const Color(0xFFF5F5F5),
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
                    '18 STATUSES',
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

          const SizedBox(height: 8),

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
                      letterSpacing: 0.5,
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
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.28,
                    minWidth: isSmallScreen ? 80 : 100,
                  ),
                  child: Text(
                    'PREVIEW',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF00897B),
                      fontSize: isSmallScreen ? 10 : 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),
                SizedBox(
                  width: isSmallScreen ? 60 : 68,
                  child: Text(
                    'ACTIONS',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(0xFF00897B),
                      fontSize: isSmallScreen ? 10 : 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table rows
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _statuses.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: const Color(0xFFF0F0F0),
                ),
                itemBuilder: (context, index) {
                  final status = _statuses[index];
                  return _buildStatusRow(status, isSmallScreen, size.width);
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
                // Page navigation buttons
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
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: isSmallScreen ? 32 : 36,
                      height: isSmallScreen ? 32 : 36,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _currentPage < _totalPages
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.chevron_right),
                      color: const Color(0xFF666666),
                      iconSize: isSmallScreen ? 20 : 24,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),

                // Page indicator
                Text(
                  'PAGE 1 OF 2',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
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
          // Serial number
          SizedBox(
            width: isSmallScreen ? 25 : 40,
            child: Text(
              '${status.id}',
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

          SizedBox(width: isSmallScreen ? 8 : 12),

          // Preview chip
          Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.28,
              minWidth: isSmallScreen ? 80 : 100,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8 : 12,
              vertical: isSmallScreen ? 5 : 6,
            ),
            decoration: BoxDecoration(
              color: status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              status.name.toUpperCase(),
              style: TextStyle(
                color: status.color,
                fontSize: isSmallScreen ? 9 : 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: isSmallScreen ? 8 : 12),

          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                color: const Color(0xFFFFA726),
                iconSize: isSmallScreen ? 18 : 20,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              ),
              SizedBox(width: isSmallScreen ? 4 : 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline),
                color: const Color(0xFFE53935),
                iconSize: isSmallScreen ? 18 : 20,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
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
  final Color color;

  LeadStatus({required this.id, required this.name, required this.color});
}
