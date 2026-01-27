import 'package:flutter/material.dart';
import 'package:ica_crm/layouts/main_layout.dart';

import '../widgets/appdrawer.dart';

class CommandCentralScreen extends StatefulWidget {
  const CommandCentralScreen({super.key});

  @override
  State<CommandCentralScreen> createState() => _CommandCentralScreenState();
}

class _CommandCentralScreenState extends State<CommandCentralScreen> {
  String selectedPersonnel = 'ALL PERSONNEL';
  String selectedTimeRange = 'LAST 30 DAYS';

  final List<String> personnelOptions = [
    'All Personnel',
    'Alex Johnson',
    'Sarah Williams',
    'Michael Chen',
    'Emily Davis',
    'Rahul Patel',
  ];

  final List<String> timeRangeOptions = [
    'Today',
    'Last 7 Days',
    'Last 30 Days',
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Overview',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COMMAND CENTRAL',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'INTELLIGENCE PORTFOLIO',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        '•',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'REAL-TIME',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF666666),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personnel Dropdown
                  CustomDropdown(
                    icon: Icons.person_outline,
                    value: selectedPersonnel,
                    options: personnelOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedPersonnel = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Time Range and Refresh Row
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown(
                          icon: Icons.access_time,
                          value: selectedTimeRange,
                          options: timeRangeOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedTimeRange = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Color(0xFF00897B),
                            size: 28,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Section Title
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        color: Color(0xFF999999),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'LEAD INTELLIGENCE SUMMARY',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF999999),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Omni-Leads Card
                  MetricCard(
                    color: const Color(0xFF2962FF),
                    icon: Icons.groups_outlined,
                    title: 'OMNI-LEADS (TOTAL)',
                    value: '5',
                    change: '+12% from last period',
                    isPositive: true,
                  ),
                  const SizedBox(height: 16),

                  // Fresh Leads Card
                  MetricCard(
                    color: const Color(0xFF00897B),
                    icon: Icons.auto_awesome,
                    title: 'FRESH LEADS',
                    value: '1',
                    change: null,
                    isPositive: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final IconData icon;
  final String value;
  final List<String> options;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.icon,
    required this.value,
    required this.options,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF666666),
                size: 24,
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
              letterSpacing: 0.5,
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            elevation: 8,
            menuMaxHeight: 300,
            items: options.map((String option) {
              bool isSelected = option.toUpperCase() == value;
              return DropdownMenuItem<String>(
                value: option.toUpperCase(),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFE0F2F1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF00695C)
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: Color(0xFF00695C),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            selectedItemBuilder: (BuildContext context) {
              return options.map((String option) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Icon(icon, color: const Color(0xFF00695C), size: 22),
                      const SizedBox(width: 14),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String value;
  final String? change;
  final bool? isPositive;

  const MetricCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.value,
    this.change,
    this.isPositive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.0,
            ),
          ),
          if (change != null) ...[
            const SizedBox(height: 12),
            Text(
              change!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
