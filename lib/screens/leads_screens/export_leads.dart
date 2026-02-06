import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';

class ExportLeadsScreen extends StatefulWidget {
  const ExportLeadsScreen({super.key});

  @override
  State<ExportLeadsScreen> createState() => _ExportLeadsScreenState();
}

class _ExportLeadsScreenState extends State<ExportLeadsScreen> {
  // Date controllers
  final TextEditingController _createdStartDate = TextEditingController();
  final TextEditingController _createdEndDate = TextEditingController();
  final TextEditingController _updateStartDate = TextEditingController();
  final TextEditingController _updateEndDate = TextEditingController();
  final TextEditingController _followUpStartDate = TextEditingController();
  final TextEditingController _followUpEndDate = TextEditingController();

  // Selected values
  String? _selectedStatus;
  String? _selectedSource;
  String? _selectedCourse;
  String? _selectedCountry;
  String? _selectedQualifications;
  String? _selectedAssignedTo;

  // Export fields selection
  final Map<String, bool> _exportFields = {
    'ID': true,
    'Full Name': true,
    'Email': true,
    'Phone': true,
    'Country': true,
    'Branch': true,
    'Qualification': true,
    'Source': true,
  };

  int get _activeFieldsCount => _exportFields.values.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isSmallScreen = size.width < 360;

    return MainLayout(
      title: 'Export Leads',
      child: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Export Leads',
              style: TextStyle(
                fontSize: isTablet ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Generate advanced Excel reports with custom column mapping and deep filtering.',
              style: TextStyle(
                fontSize: isTablet ? 16 : 14,
                color: const Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 32),

            // ICA Corp Extraction Hub Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Color(0xFF00695C),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'ICA CORP EXTRACTION HUB',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 10 : 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00695C),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Configure Excel Export Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configure Excel Export',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fine-tune your dataset before generating the report.',
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 13,
                          color: const Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSmallScreen) const SizedBox(width: 16),
                if (!isSmallScreen)
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.file_download, size: 18),
                    label: const Text('GENERATE EXCEL REPORT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),

            if (isSmallScreen) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.file_download, size: 18),
                  label: const Text('GENERATE EXCEL REPORT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Timeline Sections
            if (isTablet)
              Row(
                children: [
                  Expanded(
                    child: _buildTimelineCard(
                      'Created at Timeline',
                      Icons.access_time,
                      Colors.blue,
                      _createdStartDate,
                      _createdEndDate,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimelineCard(
                      'Update History',
                      Icons.history,
                      Colors.orange,
                      _updateStartDate,
                      _updateEndDate,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTimelineCard(
                      'Follow Up Schedule',
                      Icons.calendar_today,
                      Colors.teal,
                      _followUpStartDate,
                      _followUpEndDate,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildTimelineCard(
                    'Created at Timeline',
                    Icons.access_time,
                    Colors.blue,
                    _createdStartDate,
                    _createdEndDate,
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineCard(
                    'Update History',
                    Icons.history,
                    Colors.orange,
                    _updateStartDate,
                    _updateEndDate,
                  ),
                  const SizedBox(height: 16),
                  _buildTimelineCard(
                    'Follow Up Schedule',
                    Icons.calendar_today,
                    Colors.teal,
                    _followUpStartDate,
                    _followUpEndDate,
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // Target Demographics Section
            Container(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        color: Color(0xFF00695C),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Target Demographics',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (isTablet)
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                'STATUS',
                                'Select Status',
                                _selectedStatus,
                                (v) => setState(() => _selectedStatus = v),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                'SOURCE',
                                'Select Source',
                                _selectedSource,
                                (v) => setState(() => _selectedSource = v),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                'COURSE',
                                'Select Course',
                                _selectedCourse,
                                (v) => setState(() => _selectedCourse = v),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown(
                                'COUNTRY',
                                'Select Country',
                                _selectedCountry,
                                (v) => setState(() => _selectedCountry = v),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                'QUALIFICATIONS',
                                'Select Qualifications',
                                _selectedQualifications,
                                (v) =>
                                    setState(() => _selectedQualifications = v),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDropdown(
                                'ASSIGNED TO',
                                'Select Assigned To',
                                _selectedAssignedTo,
                                (v) => setState(() => _selectedAssignedTo = v),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildDropdown(
                          'STATUS',
                          'Select Status',
                          _selectedStatus,
                          (v) => setState(() => _selectedStatus = v),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                          'SOURCE',
                          'Select Source',
                          _selectedSource,
                          (v) => setState(() => _selectedSource = v),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                          'COURSE',
                          'Select Course',
                          _selectedCourse,
                          (v) => setState(() => _selectedCourse = v),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                          'COUNTRY',
                          'Select Country',
                          _selectedCountry,
                          (v) => setState(() => _selectedCountry = v),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                          'QUALIFICATIONS',
                          'Select Qualifications',
                          _selectedQualifications,
                          (v) => setState(() => _selectedQualifications = v),
                        ),
                        const SizedBox(height: 16),
                        _buildDropdown(
                          'ASSIGNED TO',
                          'Select Assigned To',
                          _selectedAssignedTo,
                          (v) => setState(() => _selectedAssignedTo = v),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Column Mapping Section
            Container(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.view_column,
                        color: Color(0xFF00BFA5),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'COLUMN MAPPING',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 10 : 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00BFA5),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Select Export Fields',
                    style: TextStyle(
                      fontSize: isTablet ? 22 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        final allSelected = _exportFields.values.every(
                          (v) => v,
                        );
                        _exportFields.updateAll((key, value) => !allSelected);
                      });
                    },
                    child: Text(
                      'SELECT ALL FIELDS',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF00BFA5),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ..._exportFields.entries.map(
                    (entry) => _buildExportField(entry.key, entry.value),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ACTIVE MAPPING',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 10 : 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF666666),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '$_activeFieldsCount / ${_exportFields.length} Columns',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 11 : 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Export Forecast Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        color: Color(0xFF00695C),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'EXPORT FORECAST',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 10 : 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00695C),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.people_outline,
                        color: Color(0xFF1A1A1A),
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '842 Records',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ESTIMATED FILE SIZE: 142KB',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 10 : 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF666666),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard(
    String title,
    IconData icon,
    Color iconColor,
    TextEditingController startController,
    TextEditingController endController,
  ) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF666666),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'START DATE',
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF999999),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildDateField(startController),
          const SizedBox(height: 16),
          Text(
            'END DATE',
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF999999),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildDateField(endController),
        ],
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'dd-mm-yyyy',
        hintStyle: const TextStyle(color: Color(0xFF999999)),
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 18,
          color: Color(0xFF666666),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF00695C)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          controller.text =
              '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
        }
      },
    );
  }

  Widget _buildDropdown(
    String label,
    String hint,
    String? value,
    Function(String?) onChanged,
  ) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 10 : 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF00695C),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF666666)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF00695C)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
          ),
          items: const [],
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildExportField(String label, bool isSelected) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _exportFields[label] = !isSelected;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2A2A2A)
                : const Color(0xFF242424),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF00BFA5)
                  : const Color(0xFF333333),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: const Color(0xFF00BFA5),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _createdStartDate.dispose();
    _createdEndDate.dispose();
    _updateStartDate.dispose();
    _updateEndDate.dispose();
    _followUpStartDate.dispose();
    _followUpEndDate.dispose();
    super.dispose();
  }
}
