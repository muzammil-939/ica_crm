import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class LeadFormNameScreen extends StatefulWidget {
  const LeadFormNameScreen({super.key});

  @override
  State<LeadFormNameScreen> createState() => _LeadFormNameScreenState();
}

class _LeadFormNameScreenState extends State<LeadFormNameScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _forms = [
    {
      'id': 1,
      'name': 'Apply Now Form',
      'category': 'CORE',
      'externalId': 'form_apply_main',
    },
    {
      'id': 2,
      'name': 'PG Diploma form-copy',
      'category': 'ACADEMIC',
      'externalId': 'fb_pg_dip_22',
    },
    {
      'id': 3,
      'name': 'Registration Form',
      'category': 'ONBOARDING',
      'externalId': 'reg_001_global',
    },
    {
      'id': 4,
      'name': 'fellowship course form',
      'category': 'ACADEMIC',
      'externalId': 'fshp_course_24',
    },
    {
      'id': 5,
      'name': 'Certification course form',
      'category': 'ACADEMIC',
      'externalId': 'cert_v3_main',
    },
    {
      'id': 6,
      'name': 'Course Enquiry Form',
      'category': 'LEAD GEN',
      'externalId': 'enq_general_hub',
    },
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

    // Mobile-only padding and sizing
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;
    final verticalPadding = isSmallScreen ? 16.0 : 20.0;
    final titleFontSize = isSmallScreen ? 22.0 : 26.0;
    final subtitleFontSize = isSmallScreen ? 13.0 : 14.0;

    return MainLayout(
      title: 'Lead Form Name',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Lead Form Name',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: isSmallScreen ? 6 : 8),
              Text(
                'Manage specialized lead capture forms and their integration identifiers.',
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: const Color(0xFF666666),
                  height: 1.4,
                ),
              ),
              SizedBox(height: isSmallScreen ? 20 : 24),

              // Action Bar (Add Form button and Search)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Add Form Button
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: const Text('ADD FORM'),
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
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Search Bar
                  Container(
                    height: isSmallScreen ? 42 : 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name or ID...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: isSmallScreen ? 13 : 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF999999),
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 16 : 20),

              // Forms Count
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '11 FORMS',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF999999),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),

              // Mobile Card View
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _forms.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final form = _forms[index];
                  return _buildMobileFormCard(form, isSmallScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileFormCard(Map<String, dynamic> form, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Serial Number and Form Icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Serial Number Badge
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${form['id']}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Form Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9F8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: Color(0xFF00695C),
                ),
              ),
              const Spacer(),

              // Actions
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined),
                    color: const Color(0xFFFF9800),
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline),
                    color: const Color(0xFFFF4444),
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Form Name
          Text(
            form['name'],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),

          // Category
          Text(
            form['category'],
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF999999),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // External ID
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.tag, size: 14, color: Color(0xFF666666)),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    form['externalId'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
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
