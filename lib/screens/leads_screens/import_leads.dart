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
                          children: [
                            const Icon(
                              Icons.cloud_outlined,
                              size: 14,
                              color: Color(0xFF00695C),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'ICA CORP DATA PROCESSOR',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal[800],
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
                        'Upload your Excel file below to begin the two-step import process.',
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
                      child: Column(
                        children: [
                          _buildDropZone(context, isSmallScreen),
                          const SizedBox(height: 16),
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
                            backgroundColor: Colors.teal[800],
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
                            'UPLOAD FILE',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
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
}
