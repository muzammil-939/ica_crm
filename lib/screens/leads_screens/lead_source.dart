import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class LeadSourceScreen extends StatefulWidget {
  const LeadSourceScreen({super.key});

  @override
  State<LeadSourceScreen> createState() => _LeadSourceScreenState();
}

class _LeadSourceScreenState extends State<LeadSourceScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _totalPages = 2;

  final List<Map<String, String>> _leadSources = [
    {
      'id': '#1',
      'source': 'Website',
      'type': 'DIRECT',
      'channelId': 'web_main_01',
      'icon': 'direct',
    },
    {
      'id': '#2',
      'source': 'WhatsApp Campaign',
      'type': 'MESSAGING',
      'channelId': 'wa_mkt_2024',
      'icon': 'direct',
    },
    {
      'id': '#3',
      'source': 'Instagram Ads',
      'type': 'SOCIAL',
      'channelId': 'ig_ads_leadgen',
      'icon': 'direct',
    },
    {
      'id': '#4',
      'source': 'Facebook Ads',
      'type': 'SOCIAL',
      'channelId': 'fb_form_39202',
      'icon': 'facebook',
    },
    {
      'id': '#5',
      'source': 'Reference',
      'type': 'ORGANIC',
      'channelId': 'ref_internal',
      'icon': 'direct',
    },
    {
      'id': '#6',
      'source': 'Social Media',
      'type': 'SOCIAL',
      'channelId': 'sm_generic',
      'icon': 'direct',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isSmallScreen = size.width < 360;
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
                  onPressed: () {},
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
                            width: 35,
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
                          Expanded(
                            child: Text(
                              'SOURCE',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: Text(
                              'CHANNEL ID',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                            child: Text(
                              'ACTIONS',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: const Color(0xFF999999),
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
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _leadSources.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE0E0E0),
                      ),
                      itemBuilder: (context, index) {
                        final source = _leadSources[index];
                        return _buildLeadSourceRow(source);
                      },
                    ),

                    // Pagination
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left arrow
                          InkWell(
                            onTap: _currentPage > 1
                                ? () {
                                    setState(() {
                                      _currentPage--;
                                    });
                                  }
                                : null,
                            child: Icon(
                              Icons.chevron_left,
                              color: _currentPage > 1
                                  ? const Color(0xFF666666)
                                  : const Color(0xFFCCCCCC),
                              size: 24,
                            ),
                          ),

                          // Page numbers
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 1; i <= _totalPages; i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentPage = i;
                                      });
                                    },
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: _currentPage == i
                                            ? const Color(0xFF00695C)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$i',
                                        style: TextStyle(
                                          color: _currentPage == i
                                              ? Colors.white
                                              : const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          // Right section
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'PAGE $_currentPage OF $_totalPages',
                                style: const TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: _currentPage < _totalPages
                                    ? () {
                                        setState(() {
                                          _currentPage++;
                                        });
                                      }
                                    : null,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: _currentPage < _totalPages
                                      ? const Color(0xFF666666)
                                      : const Color(0xFFCCCCCC),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildLeadSourceRow(Map<String, String> source) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // ID
          SizedBox(
            width: 35,
            child: Text(
              source['id']!,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Source with Icon
          Expanded(
            child: Row(
              children: [
                _buildSourceIcon(source['icon']!),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        source['source']!,
                        style: const TextStyle(
                          color: Color(0xFF1A1A1A),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        source['type']!,
                        style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Channel ID
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              source['channelId']!,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          // Actions
          SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Color(0xFFFF9800),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.delete_outline,
                      color: Color(0xFFE53935),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceIcon(String iconType) {
    IconData icon;
    Color bgColor;

    switch (iconType) {
      case 'facebook':
        icon = Icons.facebook;
        bgColor = const Color(0xFF1877F2);
        break;
      case 'direct':
      default:
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
