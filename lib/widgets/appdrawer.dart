import 'package:flutter/material.dart';
import 'package:ica_crm/services/features/auth/auth_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isRolesExpanded = false;
  bool isLeadsExpanded = false;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? userEmail;
  String? userInitial;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final email = await _storage.read(key: 'user_email');

    if (!mounted) return;

    setState(() {
      userEmail = email;
      userInitial = email != null && email.isNotEmpty
          ? email[0].toUpperCase()
          : '?';
    });
  }

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
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  ),

                  const SizedBox(height: 4),

                  // Users
                  DrawerMenuItem(
                    icon: Icons.people_outline,
                    title: 'Users',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/users');
                    },
                  ),

                  const SizedBox(height: 4),

                  // Departments
                  DrawerMenuItem(
                    icon: Icons.business_outlined,
                    title: 'Departments',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/departments');
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
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/roles');
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.verified_user_outlined,
                        title: 'Permissions',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/permissions',
                          );
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
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/all_leads');
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.history,
                        title: 'Lead History',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_history',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.show_chart,
                        title: 'Lead Status',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_status',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.send,
                        title: 'Lead Source',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_source',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.description_outlined,
                        title: 'Lead Form Name',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_form_name',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.public,
                        title: 'Lead Country',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_country',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.cloud_upload_outlined,
                        title: 'Import Leads',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/import_leads',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.cloud_download_outlined,
                        title: 'Export Leads',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/export_leads',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.school_outlined,
                        title: 'Admissions',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/admissions',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.book_outlined,
                        title: 'Lead Course',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_course',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.check_circle_outline,
                        title: 'Lead Qualification',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_qualification',
                          );
                        },
                      ),
                      DrawerSubMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Leads Settings',
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                            context,
                            '/lead_settings',
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Tasks
                  DrawerMenuItem(
                    icon: Icons.check_box_outlined,
                    title: 'Tasks',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/tasks');
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
                    padding: const EdgeInsets.only(left: 22, right: 60),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                          context,
                          '/profile_settings',
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 0.5, color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              radius: 20,
                              child: Text(
                                userInitial ?? '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                userEmail ?? 'Loading...',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Confirm Logout"),
                            content: const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context); // close dialog

                                  final authApi = AuthApi();
                                  await authApi.logout();

                                  if (!mounted) return;

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                        (route) => false,
                                  );
                                },
                                child: const Text("Logout"),
                              ),
                            ],
                          ),
                        );
                      },

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
