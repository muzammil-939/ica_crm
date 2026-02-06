import 'package:flutter/material.dart';
import 'package:ica_crm/screens/dashboard.dart';
import 'package:ica_crm/screens/departments_page.dart';
import 'package:ica_crm/screens/leads_screens/admissions.dart';
import 'package:ica_crm/screens/leads_screens/all_leads.dart';
import 'package:ica_crm/screens/leads_screens/export_leads.dart';
import 'package:ica_crm/screens/leads_screens/import_leads.dart';
import 'package:ica_crm/screens/leads_screens/lead_country.dart';
import 'package:ica_crm/screens/leads_screens/lead_course.dart';
import 'package:ica_crm/screens/leads_screens/lead_form_name.dart';
import 'package:ica_crm/screens/leads_screens/lead_history.dart';
import 'package:ica_crm/screens/leads_screens/lead_qualification.dart';
import 'package:ica_crm/screens/leads_screens/lead_settings.dart';
import 'package:ica_crm/screens/leads_screens/lead_source.dart';
import 'package:ica_crm/screens/leads_screens/lead_status.dart';
import 'package:ica_crm/screens/login_page.dart';
import 'package:ica_crm/screens/permissions_page.dart';
import 'package:ica_crm/screens/profile_settings_page.dart';
import 'package:ica_crm/screens/roles_page.dart';
import 'package:ica_crm/screens/tasks_page.dart';
import 'package:ica_crm/screens/users_page.dart';

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
        '/lead_status': (context) => LeadStatusScreen(),
        '/lead_source': (context) => LeadSourceScreen(),
        '/lead_form_name': (context) => LeadFormNameScreen(),
        '/lead_country': (context) => LeadCountryScreen(),
        '/import_leads': (context) => ImportLeadsScreen(),
        '/export_leads': (context) => ExportLeadsScreen(),
        '/admissions': (context) => AdmissionsScreen(),
        '/lead_course': (context) => LeadCourseScreen(),
        '/lead_qualification': (context) => LeadQualificationScreen(),
        '/lead_settings': (context) => LeadsSettingsScreen(),
        '/profile_settings': (context) => ProfileSettingsScreen(),
      },
    );
  }
}
