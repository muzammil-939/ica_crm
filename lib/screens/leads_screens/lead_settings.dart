import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class LeadsSettingsScreen extends StatefulWidget {
  const LeadsSettingsScreen({super.key});

  @override
  State<LeadsSettingsScreen> createState() => _LeadsSettingsScreenState();
}

class _LeadsSettingsScreenState extends State<LeadsSettingsScreen> {
  // Track visibility state for each column
  Map<String, bool> columnVisibility = {
    'Full Name': true,
    'Email Address': false,
    'Phone Number': true,
    'Country / Region': true,
    'Qualification': false,
    'Lead Source': true,
    'Enrolled Course': false,
    'Lead Status': false,
    'Assigned Agent': true,
    'Source Form': false,
    'Follow Up Date': false,
    'Creation Date': true,
    'Last Activity': false,
    'Doctor\'s Note': false,
    'Internal Notes': false,
  };

  int leadsPerPage = 50;
  bool virtualizationEnabled = true;

  int get enabledColumns => columnVisibility.values.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 900;

    return MainLayout(
      title: 'Leads Settings',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                'Leads Settings',
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Global preferences for lead management, table visibility, and outreach templates.',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 24),

              // Configuration Card and WhatsApp Template
              isSmallScreen
                  ? Column(
                      children: [
                        _buildConfigurationCard(isSmallScreen, isMediumScreen),
                        const SizedBox(height: 16),
                        _buildWhatsAppTemplateCard(isSmallScreen),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildConfigurationCard(
                            isSmallScreen,
                            isMediumScreen,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: _buildWhatsAppTemplateCard(isSmallScreen),
                        ),
                      ],
                    ),

              const SizedBox(height: 24),

              // Performance Section
              _buildPerformanceSection(isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigurationCard(bool isSmallScreen, bool isMediumScreen) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and Save button
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: Color(0xFF00695C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configuration',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 15 : 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Customize lead table and messaging',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 13,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSmallScreen)
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save_outlined, size: 18),
                    label: const Text('Save Changes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00695C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Column Visibility Section
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.view_column_outlined,
                          size: 20,
                          color: Color(0xFF1A1A1A),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Column Visibility',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          columnVisibility.updateAll((key, value) => true);
                        });
                      },
                      child: Text(
                        'ENABLE ALL',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00695C),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildColumnVisibilityGrid(isSmallScreen, isMediumScreen),
              ],
            ),
          ),

          // Save button for mobile
          if (isSmallScreen)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save_outlined, size: 18),
                  label: const Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00695C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildColumnVisibilityGrid(bool isSmallScreen, bool isMediumScreen) {
    int crossAxisCount = isSmallScreen ? 1 : (isMediumScreen ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: isSmallScreen ? 6 : 5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: columnVisibility.length,
      itemBuilder: (context, index) {
        String key = columnVisibility.keys.elementAt(index);
        bool isVisible = columnVisibility[key]!;

        return _buildColumnItem(key, isVisible, isSmallScreen);
      },
    );
  }

  Widget _buildColumnItem(String label, bool isVisible, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        setState(() {
          columnVisibility[label] = !columnVisibility[label]!;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 14,
          vertical: isSmallScreen ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: isVisible ? const Color(0xFFF5F5F5) : Colors.white,
          border: Border.all(
            color: isVisible
                ? const Color(0xFF00695C).withOpacity(0.3)
                : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  color: isVisible
                      ? const Color(0xFF00695C)
                      : const Color(0xFF999999),
                  fontWeight: isVisible ? FontWeight.w500 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isVisible ? const Color(0xFF00695C) : Colors.white,
                border: Border.all(
                  color: isVisible
                      ? const Color(0xFF00695C)
                      : const Color(0xFFCCCCCC),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isVisible
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : const Icon(
                      Icons.visibility_off_outlined,
                      color: Color(0xFFCCCCCC),
                      size: 12,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsAppTemplateCard(bool isSmallScreen) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.smartphone,
                    color: Color(0xFF00695C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'WhatsApp Template',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 15 : 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFCCCCCC),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Hi, thank you for your inquiry!',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF00695C),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Used for quick outreach in All Leads',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 13,
                            color: const Color(0xFF00695C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 16),
                Text(
                  'ACTIVE CONFIGURATION',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF999999),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildConfigItem(
                  'Column Visibility',
                  '$enabledColumns / ${columnVisibility.length}',
                  isSmallScreen,
                ),
                const SizedBox(height: 12),
                _buildConfigItem(
                  'Items per Page',
                  '$leadsPerPage',
                  isSmallScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigItem(String label, String value, bool isSmallScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 13 : 14,
            color: const Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmallScreen ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceSection(bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00695C).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.speed,
                  color: Color(0xFF00BFA5),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Performance',
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          isSmallScreen
              ? Column(
                  children: [
                    _buildPerformanceItem(
                      'LEADS PER PAGE',
                      leadsPerPage,
                      isSmallScreen,
                    ),
                    const SizedBox(height: 16),
                    _buildVirtualizationToggle(isSmallScreen),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildPerformanceItem(
                        'LEADS PER PAGE',
                        leadsPerPage,
                        isSmallScreen,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: _buildVirtualizationToggle(isSmallScreen)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, int value, bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 11 : 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF999999),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF333333)),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(
              fontSize: isSmallScreen ? 15 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVirtualizationToggle(bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF333333)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00695C).withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.view_in_ar_outlined,
              color: Color(0xFF00BFA5),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Virtualization',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Enabled for large datasets',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: const Color(0xFF999999),
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
