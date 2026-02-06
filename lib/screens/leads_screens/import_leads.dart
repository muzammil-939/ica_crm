import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class ImportLeadsScreen extends StatefulWidget {
  const ImportLeadsScreen({super.key});

  @override
  State<ImportLeadsScreen> createState() => _ImportLeadsScreenState();
}

class _ImportLeadsScreenState extends State<ImportLeadsScreen> {
  final bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return MainLayout(
      title: 'Import Leads',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Import Leads',
                style: TextStyle(
                  fontSize: isSmallScreen ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bulk upload your lead database via secure CSV synchronization studio.',
                style: TextStyle(
                  fontSize: isSmallScreen ? 13 : 14,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: isSmallScreen ? 24 : 32),

              // Main upload card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    // ICA CORP DATA PROCESSOR badge
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2F1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.cloud_outlined,
                              size: 14,
                              color: Color(0xFF00695C),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'ICA CORP DATA PROCESSOR',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF00695C),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 24,
                      ),
                      child: Text(
                        'Upload Lead Database',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 24 : 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 24 : 48,
                      ),
                      child: Text(
                        'Drag your file below or use our standard template to ensure 100% mapping accuracy for your lead fields.',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          color: const Color(0xFF666666),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Content row with drag-drop and requirements
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 24,
                      ),
                      child: isSmallScreen
                          ? Column(
                              children: [
                                _buildDropZone(context, isSmallScreen),
                                const SizedBox(height: 16),
                                _buildRequirementsCard(isSmallScreen),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: _buildDropZone(context, isSmallScreen),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 2,
                                  child: _buildRequirementsCard(isSmallScreen),
                                ),
                              ],
                            ),
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),

                    // Secure import button
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 24,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF757575),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 14 : 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'SECURE IMPORT RECORDS',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),

                    // Security compliance
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        isSmallScreen ? 16 : 24,
                        0,
                        isSmallScreen ? 16 : 24,
                        isSmallScreen ? 20 : 24,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.shield_outlined,
                              size: 18,
                              color: Color(0xFF666666),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SECURITY COMPLIANCE',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 10 : 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF999999),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'All data uploaded is processed through 256-bit SSL encryption. We perform automated GDPR validation checks during the analysis phase.',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 13,
                                      color: const Color(0xFF666666),
                                      height: 1.4,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmallScreen ? 24 : 32),

              // Recent Synchronizations
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.grid_view_rounded,
                        size: isSmallScreen ? 20 : 24,
                        color: const Color(0xFF00695C),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recent Synchronizations',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'VIEW ALL ACTIVITY',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00695C),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sync items
              _buildSyncItem(
                'fb_leads_export_q4.csv',
                'JAN 18, 2026',
                '245 LEADS',
                true,
                isSmallScreen,
              ),
              const SizedBox(height: 12),
              _buildSyncItem(
                'fb_leads_export_q4.csv',
                'JAN 18, 2026',
                '245 LEADS',
                true,
                isSmallScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropZone(BuildContext context, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        // Handle file selection
      },
      child: Container(
        height: isSmallScreen ? 200 : 240,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: _isDragging
              ? const Color(0xFFF0F0F0)
              : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _isDragging
                ? const Color(0xFF00695C)
                : const Color(0xFFE0E0E0),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSmallScreen ? 60 : 70,
              height: isSmallScreen ? 60 : 70,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                size: isSmallScreen ? 30 : 36,
                color: const Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Drop CSV file here',
              style: TextStyle(
                fontSize: isSmallScreen ? 15 : 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF999999),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'CLICK TO BROWSE LOCAL FILES',
              style: TextStyle(
                fontSize: isSmallScreen ? 10 : 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFCCCCCC),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementsCard(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 20 : 22),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.description_outlined,
                size: 14,
                color: Color(0xFF00BFA5),
              ),
              SizedBox(width: 6),
              Text(
                'DOCUMENTATION',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00BFA5),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Sync Requirements',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          _buildRequirement(
            '1',
            'Headers must match exactly:\nFull Name, Email, Phone,\nCountry, qualification...',
          ),
          const SizedBox(height: 12),
          _buildRequirement(
            '2',
            'Phone numbers should include\ncountry codes for WhatsApp\ncompatibility.',
          ),
          const SizedBox(height: 12),
          _buildRequirement(
            '3',
            'Email addresses must be unique\nto prevent duplicates.',
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download, size: 16),
              label: const Text(
                'DOWNLOAD CSV TEMPLATE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF424242)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFCCCCCC),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncItem(
    String filename,
    String date,
    String leads,
    bool validated,
    bool isSmallScreen,
  ) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 14 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            width: isSmallScreen ? 40 : 48,
            height: isSmallScreen ? 40 : 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.description_outlined,
              color: const Color(0xFF757575),
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $leads',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    color: const Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 14,
                  color: Color(0xFF00695C),
                ),
                const SizedBox(width: 4),
                Text(
                  'VALIDATED',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10 : 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00695C),
                    letterSpacing: 0.3,
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
