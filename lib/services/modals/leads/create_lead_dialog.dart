import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class CreateLeadDialog extends StatefulWidget {
  final VoidCallback onSuccess;

  const CreateLeadDialog({super.key, required this.onSuccess});

  @override
  State<CreateLeadDialog> createState() => _CreateLeadDialogState();
}

class _CreateLeadDialogState extends State<CreateLeadDialog> {
  final _formKey = GlobalKey<FormState>();
  final LeadsApi _api = LeadsApi();
  final TextEditingController _followUpController = TextEditingController();

  bool isSubmitting = false;

  // Form Fields
  String fullName = '';
  String email = '';
  String phone = '';
  String altPhone = '';
  int? status;
  int? source;
  int? course;
  int? country;
  int? qualification;
  int? assignedTo;
  DateTime? followUp;
  String notes = '';

  // Dropdown data
  List<dynamic> statuses = [];
  List<dynamic> sources = [];
  List<dynamic> courses = [];
  List<dynamic> countries = [];
  List<dynamic> qualifications = [];
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    _loadDropdowns();
  }

  Future<void> _loadDropdowns() async {
    try {
      final results = await Future.wait([
        _api.getStatuses(),
        _api.getSources(),
        _api.getCourses(),
        _api.getCountries(),
        _api.getQualifications(),
        _api.getUsers(),
      ]);

      setState(() {
        statuses = results[0];
        sources = results[1];
        courses = results[2];
        countries = results[3];
        qualifications = results[4];
        users = results[5];
      });
    } catch (e) {
      debugPrint("Dropdown error: $e");
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final payload = {
      "full_name": fullName,
      "email": email,
      "phone": phone,
      if (altPhone.isNotEmpty) "alt_phone": altPhone,
      if (status != null) "status": status,
      if (source != null) "source": source,
      if (course != null) "course": course,
      if (country != null) "country": country,
      if (qualification != null) "qualification": qualification,
      if (assignedTo != null) "assigned_to": assignedTo,
      if (followUp != null)
        "follow_up": followUp!.toIso8601String(),
      if (notes.isNotEmpty) "notes": notes,
    };

    try {
      await _api.createLead(payload);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lead created successfully")),
      );

      widget.onSuccess();
      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const Text(
                    "Register New Lead",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  // Row 1
                  Row(
                    children: [
                      Expanded(child: _input("Full Name", (v) => fullName = v)),
                      const SizedBox(width: 12),
                      Expanded(child: _input("Email", (v) => email = v)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Row 2
                  Row(
                    children: [
                      Expanded(child: _input("Phone", (v) => phone = v)),
                      const SizedBox(width: 12),
                      Expanded(child: _input("Alt Phone", (v) => altPhone = v, required: false)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Dropdown grid (2 columns like web)
                  _dropdownRow("Status", statuses, status, (v) => status = v),
                  _dropdownRow("Source", sources, source, (v) => source = v),
                  _dropdownRow("Course", courses, course, (v) => course = v),
                  _dropdownRow("Country", countries, country, (v) => country = v),
                  _dropdownRow("Qualification", qualifications, qualification, (v) => qualification = v),
                  _dropdownRow("Assign To", users, assignedTo, (v) => assignedTo = v),

                  const SizedBox(height: 12),

                  // Follow Up
                  TextFormField(
                    controller: _followUpController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: "Follow Up"),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          final selected = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );

                          setState(() {
                            followUp = selected;
                            _followUpController.text =
                                DateFormat("dd MMM yyyy, hh:mm a").format(selected);
                          });
                        }
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: "Notes"),
                    onChanged: (v) => notes = v,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: isSubmitting ? null : _submit,
                          child: Text(isSubmitting ? "Creating..." : "Create Lead")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _followUpController.dispose();
    super.dispose();
  }

  Widget _input(String label, Function(String) onChanged, {bool required = true}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (v) => v == null || v.isEmpty ? "$label is required" : null
          : null,
      onChanged: onChanged,
    );
  }

  Widget _dropdownRow(
      String label,
      List<dynamic> items,
      int? selectedValue,
      Function(int) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<int>(
        value: selectedValue,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: items
            .where((item) => item['id'] != null)
            .map<DropdownMenuItem<int>>((item) {
          // 🔥 Handle both name and username
          final displayText =
              item['name'] ??
                  item['username'] ??
                  '';

          return DropdownMenuItem<int>(
            value: item['id'],
            child: Text(
              displayText.toString().isNotEmpty
                  ? displayText.toString()
                  : "Unnamed",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList(),
        onChanged: (v) {
          if (v != null) {
            setState(() {
              onChanged(v);
            });
          }
        },
      ),
    );
  }
}