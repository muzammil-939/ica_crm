import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isRolesExpanded = false;
  bool isLeadsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF00695C),
      child: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Company Logo and Name
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      bottom: 32,
                      top: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.public,
                              color: const Color(0xFF00695C),
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'ICA Corp',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dashboard
                  DrawerMenuItem(
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),

                  const SizedBox(height: 4),

                  // Users
                  DrawerMenuItem(
                    icon: Icons.people_outline,
                    title: 'Users',
                    onTap: () {
                      Navigator.pushNamed(context, '/users');
                    },
                  ),

                  const SizedBox(height: 4),

                  // Departments
                  DrawerMenuItem(
                    icon: Icons.business_outlined,
                    title: 'Departments',
                    onTap: () {
                      Navigator.pushNamed(context, '/departments');
                    },
                  ),

                  const SizedBox(height: 4),

                  // Roles & Permissions
                  DrawerExpandableItem(
                    icon: Icons.lock_outline,
                    title: 'Roles & Permissions',
                    isExpanded: isRolesExpanded,
                    onTap: () {
                      setState(() {
                        isRolesExpanded = !isRolesExpanded;
                      });
                    },
                    children: [
                      DrawerSubMenuItem(
                        icon: Icons.person_outline,
                        title: 'Roles',
                        onTap: () {
                          Navigator.pushNamed(context, '/roles');
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.verified_user_outlined,
                        title: 'Permissions',
                        onTap: () {
                          Navigator.pushNamed(context, '/permissions');
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Leads
                  DrawerExpandableItem(
                    icon: Icons.people_outline,
                    title: 'Leads',
                    isExpanded: isLeadsExpanded,
                    onTap: () {
                      setState(() {
                        isLeadsExpanded = !isLeadsExpanded;
                      });
                    },
                    children: [
                      DrawerSubMenuItem(
                        icon: Icons.list_alt,
                        title: 'All Leads',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.history,
                        title: 'Lead History',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.show_chart,
                        title: 'Lead Status',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.send,
                        title: 'Lead Source',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.description_outlined,
                        title: 'Lead Form Name',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.public,
                        title: 'Lead Country',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.cloud_upload_outlined,
                        title: 'Import Leads',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.cloud_download_outlined,
                        title: 'Export Leads',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.school_outlined,
                        title: 'Admissions',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.book_outlined,
                        title: 'Lead Course',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.check_circle_outline,
                        title: 'Lead Qualification',
                        onTap: () {},
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Leads Settings',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Tasks
                  DrawerMenuItem(
                    icon: Icons.check_box_outlined,
                    title: 'Tasks',
                    onTap: () {
                      Navigator.pushNamed(context, '/tasks');
                    },
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Bottom section with divider
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // User Profile
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          radius: 24,
                          child: const Text(
                            'A',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Alex Johnson',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Logout
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.logout,
                            color: Color(0xFFFF6B6B),
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerExpandableItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;

  const DrawerExpandableItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white.withOpacity(0.9), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white.withOpacity(0.7),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: Column(children: children),
          ),
      ],
    );
  }
}

class DrawerSubMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerSubMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
