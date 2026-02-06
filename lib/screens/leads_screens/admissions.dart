import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class AdmissionsScreen extends StatelessWidget {
  const AdmissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(title: 'Admissions', child: AdmissionsContent());
  }
}

class AdmissionsContent extends StatelessWidget {
  const AdmissionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width > 600;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Text(
              'Admissions',
              style: TextStyle(
                fontSize: isSmallScreen ? 22 : (isTablet ? 28 : 24),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: isSmallScreen ? 4 : 6),
            Text(
              'Track student enrollments, financial collections, and clinical program logs.',
              style: TextStyle(
                fontSize: isSmallScreen ? 13 : 14,
                color: const Color(0xFF666666),
              ),
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),

            // Stats Cards
            _buildStatsCards(context, isSmallScreen, isTablet),

            SizedBox(height: isSmallScreen ? 16 : 20),

            // Search Bar
            _buildSearchBar(context, isSmallScreen),

            SizedBox(height: isSmallScreen ? 16 : 20),

            // Data Table
            _buildDataTable(context, isSmallScreen, isTablet),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(
    BuildContext context,
    bool isSmallScreen,
    bool isTablet,
  ) {
    final cardHeight = isSmallScreen ? 120.0 : 130.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // For mobile screens, show 2x2 grid
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.school_outlined,
                      iconColor: const Color(0xFF00695C),
                      iconBgColor: const Color(0xFFE0F2F1),
                      label: 'TOTAL ADMISSIONS',
                      value: '3',
                      badge: '+32% THIS MONTH',
                      badgeColor: const Color(0xFF4CAF50),
                      height: cardHeight,
                      isSmallScreen: isSmallScreen,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.currency_rupee,
                      iconColor: const Color(0xFF1976D2),
                      iconBgColor: const Color(0xFFE3F2FD),
                      label: 'TOTAL REVENUE',
                      value: '₹434,000',
                      badge: 'PROJECTED VALUE',
                      badgeColor: const Color(0xFF9E9E9E),
                      height: cardHeight,
                      isSmallScreen: isSmallScreen,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF388E3C),
                      iconBgColor: const Color(0xFFE8F5E9),
                      label: 'COLLECTED',
                      value: '₹160,000',
                      badge: 'NET LIQUIDITY',
                      badgeColor: const Color(0xFF9E9E9E),
                      height: cardHeight,
                      isSmallScreen: isSmallScreen,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.receipt_long_outlined,
                      iconColor: const Color(0xFFD32F2F),
                      iconBgColor: const Color(0xFFFFEBEE),
                      label: 'OUTSTANDING',
                      value: '₹274,000',
                      badge: 'ACTION REQUIRED',
                      badgeColor: const Color(0xFF9E9E9E),
                      height: cardHeight,
                      isSmallScreen: isSmallScreen,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        // For larger screens, show horizontal row
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.school_outlined,
                iconColor: const Color(0xFF00695C),
                iconBgColor: const Color(0xFFE0F2F1),
                label: 'TOTAL ADMISSIONS',
                value: '3',
                badge: '+32% THIS MONTH',
                badgeColor: const Color(0xFF4CAF50),
                height: cardHeight,
                isSmallScreen: isSmallScreen,
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: _StatCard(
                icon: Icons.currency_rupee,
                iconColor: const Color(0xFF1976D2),
                iconBgColor: const Color(0xFFE3F2FD),
                label: 'TOTAL REVENUE',
                value: '₹434,000',
                badge: 'PROJECTED VALUE',
                badgeColor: const Color(0xFF9E9E9E),
                height: cardHeight,
                isSmallScreen: isSmallScreen,
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: _StatCard(
                icon: Icons.account_balance_wallet_outlined,
                iconColor: const Color(0xFF388E3C),
                iconBgColor: const Color(0xFFE8F5E9),
                label: 'COLLECTED',
                value: '₹160,000',
                badge: 'NET LIQUIDITY',
                badgeColor: const Color(0xFF9E9E9E),
                height: cardHeight,
                isSmallScreen: isSmallScreen,
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: _StatCard(
                icon: Icons.receipt_long_outlined,
                iconColor: const Color(0xFFD32F2F),
                iconBgColor: const Color(0xFFFFEBEE),
                label: 'OUTSTANDING',
                value: '₹274,000',
                badge: 'ACTION REQUIRED',
                badgeColor: const Color(0xFF9E9E9E),
                height: cardHeight,
                isSmallScreen: isSmallScreen,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 12 : 14,
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: const Color(0xFF9E9E9E),
              size: isSmallScreen ? 20 : 22,
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Expanded(
              child: Text(
                'Search by Lea...',
                style: TextStyle(
                  color: const Color(0xFF9E9E9E),
                  fontSize: isSmallScreen ? 13 : 14,
                ),
              ),
            ),
            if (!isSmallScreen)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'ICA CORP FINANCIAL MANAGEMENT',
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(
    BuildContext context,
    bool isSmallScreen,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header - Only on larger screens
          if (!isSmallScreen && MediaQuery.of(context).size.width > 600)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                    child: Text(
                      'S.NO',
                      style: TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'LEAD IDENTITY',
                      style: TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'ACCOUNT HOLDER',
                      style: TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text(
                      'FINANCIAL PROGRESS',
                      style: TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'LEDGER ACTIONS',
                      style: const TextStyle(
                        color: Color(0xFF00838F),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

          if (!isSmallScreen && MediaQuery.of(context).size.width > 600)
            const Divider(height: 1),

          // Mobile Header
          if (isSmallScreen || MediaQuery.of(context).size.width <= 600)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: const [
                    SizedBox(
                      width: 50,
                      child: Text(
                        'S.NO',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        'LEAD IDENTITY',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: Text(
                        'ACCOUNT HOLDER',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: Text(
                        'FINANCIAL PROGRESS',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'LEDGER ACTIONS',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const Divider(height: 1),

          // Table Rows
          _StudentRow(
            sno: '1',
            leadId: 'lead-4',
            name: 'Dr. Rajesh Kumar',
            designation: 'CLINICAL ASPIRANT',
            progress: 0.24,
            status: 'PARTIALLY P',
            statusColor: const Color(0xFFFF9800),
            statusBgColor: const Color(0xFFFFF3E0),
            isSmallScreen: isSmallScreen,
          ),
          const Divider(height: 1),
          _StudentRow(
            sno: '2',
            leadId: 'lead-5',
            name: 'Dr. Sneha Reddy',
            designation: 'CLINICAL ASPIRANT',
            progress: 1.0,
            status: 'FULLY PAID',
            statusColor: const Color(0xFF4CAF50),
            statusBgColor: const Color(0xFFE8F5E9),
            isSmallScreen: isSmallScreen,
          ),
          const Divider(height: 1),
          _StudentRow(
            sno: '3',
            leadId: 'lead-ol-1',
            name: 'Dr. Amit Verma',
            designation: 'CLINICAL ASPIRANT',
            progress: 0.0,
            status: 'PAYMENT DU',
            statusColor: const Color(0xFFD32F2F),
            statusBgColor: const Color(0xFFFFEBEE),
            isSmallScreen: isSmallScreen,
          ),

          const Divider(height: 1),

          // Pagination Footer - FIXED VERSION
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 10.0 : 16.0),
            child: Column(
              children: [
                // Pagination controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.chevron_left,
                        size: isSmallScreen ? 16 : 18,
                      ),
                      label: Text(
                        'PREVIOUS',
                        style: TextStyle(fontSize: isSmallScreen ? 9 : 11),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFBDBDBD),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 4 : 8,
                        ),
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 4 : 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 12,
                        vertical: isSmallScreen ? 6 : 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00838F),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'PAGE 1/1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 9 : 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: isSmallScreen ? 4 : 8),
                    TextButton.icon(
                      onPressed: null,
                      label: Text(
                        'NEXT',
                        style: TextStyle(fontSize: isSmallScreen ? 9 : 11),
                      ),
                      icon: Icon(
                        Icons.chevron_right,
                        size: isSmallScreen ? 16 : 18,
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFBDBDBD),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 4 : 8,
                        ),
                      ),
                    ),
                  ],
                ),
                // Status info - only show on larger screens
                if (!isSmallScreen &&
                    MediaQuery.of(context).size.width > 600) ...[
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'STABLE COLLECTIONS',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'SHOWING 3 OF 3 ENROLLMENTS',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String label;
  final String value;
  final String badge;
  final Color badgeColor;
  final double height;
  final bool isSmallScreen;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.label,
    required this.value,
    required this.badge,
    required this.badgeColor,
    required this.height,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: isSmallScreen ? 18 : 22,
                ),
              ),
              Flexible(
                child: Text(
                  badge,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: isSmallScreen ? 7.5 : 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 8 : 9,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9E9E9E),
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  final String sno;
  final String leadId;
  final String name;
  final String designation;
  final double progress;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final bool isSmallScreen;

  const _StudentRow({
    required this.sno,
    required this.leadId,
    required this.name,
    required this.designation,
    required this.progress,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Use horizontal scroll for mobile/small tablets
    if (screenWidth <= 600) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(
                  sno,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '#',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF666666),
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            leadId,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.description_outlined,
                      size: 16,
                      color: Color(0xFF9E9E9E),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      designation,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF9E9E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 180,
                child: Row(
                  children: [
                    const Text(
                      'PROGRESS',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: const Color(0xFFF5F5F5),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress == 1.0
                                ? const Color(0xFF4CAF50)
                                : progress > 0
                                ? const Color(0xFFFF9800)
                                : const Color(0xFFE0E0E0),
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            status.contains('FULLY')
                                ? Icons.check_circle_outline
                                : status.contains('PARTIALLY')
                                ? Icons.access_time
                                : Icons.error_outline,
                            size: 13,
                            color: statusColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      iconSize: 18,
                      color: const Color(0xFF666666),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Desktop/Tablet view
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              sno,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF666666),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '#',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        leadId,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: Color(0xFF9E9E9E),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9E9E9E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const Text(
                  'PROGRESS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFFF5F5F5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress == 1.0
                            ? const Color(0xFF4CAF50)
                            : progress > 0
                            ? const Color(0xFFFF9800)
                            : const Color(0xFFE0E0E0),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        status.contains('FULLY')
                            ? Icons.check_circle_outline
                            : status.contains('PARTIALLY')
                            ? Icons.access_time
                            : Icons.error_outline,
                        size: 16,
                        color: statusColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  iconSize: 20,
                  color: const Color(0xFF666666),
                  onPressed: () {},
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
}
