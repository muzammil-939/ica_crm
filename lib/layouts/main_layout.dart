import 'package:flutter/material.dart';
import '../widgets/appdrawer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout({super.key, required this.child, this.title = 'Overview'});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width > 600;

    // Responsive sizing
    final titleFontSize = isSmallScreen ? 16.0 : (isTablet ? 20.0 : 18.0);
    final iconSize = isSmallScreen ? 22.0 : (isTablet ? 28.0 : 26.0);
    final avatarRadius = isSmallScreen ? 18.0 : 20.0;
    final avatarFontSize = isSmallScreen ? 14.0 : 16.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: isSmallScreen ? 8 : null,
        title: Row(
          children: [
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF666666),
              size: isSmallScreen ? 18 : 20,
            ),
            SizedBox(width: isSmallScreen ? 2 : 4),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF1A1A1A),
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        actions: [
          // Conditionally show theme icon only on larger screens
          if (!isSmallScreen || size.width >= 380)
            IconButton(
              icon: Icon(
                Icons.wb_sunny_outlined,
                color: const Color(0xFF1A1A1A),
                size: iconSize,
              ),
              onPressed: () {},
              padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
              constraints: const BoxConstraints(),
            ),

          // Search icon
          IconButton(
            icon: Icon(
              Icons.search,
              color: const Color(0xFF1A1A1A),
              size: iconSize,
            ),
            onPressed: () {},
            padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
            constraints: const BoxConstraints(),
          ),

          // Notification icon with badge
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: const Color(0xFF1A1A1A),
                  size: iconSize,
                ),
                onPressed: () {},
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                constraints: const BoxConstraints(),
              ),
              Positioned(
                right: isSmallScreen ? 6 : 10,
                top: isSmallScreen ? 6 : 10,
                child: Container(
                  width: isSmallScreen ? 7 : 8,
                  height: isSmallScreen ? 7 : 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          // User avatar
          Padding(
            padding: EdgeInsets.only(
              right: isSmallScreen ? 8 : 12,
              left: isSmallScreen ? 2 : 4,
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF00695C),
              radius: avatarRadius,
              child: Text(
                'A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: avatarFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}
