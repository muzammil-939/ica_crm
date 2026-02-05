import 'package:flutter/material.dart';
import 'package:ica_crm/screens/dashboard.dart';
import 'package:ica_crm/screens/departments_page.dart';
import 'package:ica_crm/screens/leads_screens/all_leads.dart';
import 'package:ica_crm/screens/leads_screens/lead_country.dart';
import 'package:ica_crm/screens/leads_screens/lead_form_name.dart';
import 'package:ica_crm/screens/leads_screens/lead_history.dart';
import 'package:ica_crm/screens/leads_screens/lead_source.dart';
import 'package:ica_crm/screens/leads_screens/lead_status.dart';
import 'package:ica_crm/screens/login_page.dart';
import 'package:ica_crm/screens/permissions.dart';
import 'package:ica_crm/screens/roles.dart';
import 'package:ica_crm/screens/tasks_page.dart';
import 'package:ica_crm/screens/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal[900],
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00674F)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => CommandCentralScreen(),
        '/departments': (context) => DepartmentsPage(),
        '/tasks': (context) => TasksPage(),
        '/users': (context) => UsersManagement(),
        '/roles': (context) => RolesScreen(),
        '/permissions': (context) => PermissionsScreen(),
        '/all_leads': (context) => AllLeadsScreen(),
        '/lead_history': (context) => LeadHistoryScreen(),
        '/leads_status': (context) => LeadStatusScreen(),
        '/leads_source': (context) => LeadSourceScreen(),
        '/leads_form_name': (context) => LeadFormNameScreen(),
        '/leads_country': (context) => LeadCountryScreen(),
      },
    );
  }
}
