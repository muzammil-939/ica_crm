import 'package:flutter/material.dart';
import 'package:ica_crm/layouts/main_layout.dart';

// Task Model
class Task {
  final String id;
  final String title;
  final String description;
  final String assignee;
  final String date;
  final String time;
  final String priority; // 'HIGH', 'MEDIUM', 'LOW'
  final String type; // 'phone', 'email', 'document', 'other'
  final DateTime dueDate;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.date,
    required this.time,
    required this.priority,
    required this.type,
    required this.dueDate,
    this.isDone = false,
  });
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // View state: 'LIST' or 'PLANNER'
  String currentView = 'LIST';

  // Filter state: 'VIEW ALL', 'TODAY', 'OVERDUE', 'UPCOMING'
  String currentFilter = 'VIEW ALL';

  // Sample tasks data
  final List<Task> allTasks = [
    Task(
      id: '1',
      title: 'Call for MBBS Documents',
      description: 'Need to verify MCI registration and degree certificates.',
      assignee: 'Priya Sharma',
      date: 'JAN 27',
      time: '12:37',
      priority: 'HIGH',
      type: 'phone',
      dueDate: DateTime(2026, 1, 27, 12, 37),
      isDone: false,
    ),
    Task(
      id: '2',
      title: 'Send WhatsApp Course Syllabus',
      description: 'Interested in Clinical Cardiology fellowship.',
      assignee: 'Rahul Patel',
      date: 'JAN 25',
      time: '12:37',
      priority: 'MEDIUM',
      type: 'document',
      dueDate: DateTime(2026, 1, 25, 12, 37),
      isDone: false,
    ),
    Task(
      id: '3',
      title: 'Email Enrollment Link',
      description: 'Expressed intent to enroll in Fetal Medicine.',
      assignee: 'Dr. Anjali Gupta',
      date: 'JAN 28',
      time: '12:37',
      priority: 'HIGH',
      type: 'email',
      dueDate: DateTime(2026, 1, 28, 12, 37),
      isDone: false,
    ),
    Task(
      id: '4',
      title: 'Collect Fellowship Deposit',
      description: 'Fellowship payment pending.',
      assignee: 'Dr. Sneha Reddy',
      date: 'JAN 27',
      time: '12:37',
      priority: 'MEDIUM',
      type: 'document',
      dueDate: DateTime(2026, 1, 27, 12, 37),
      isDone: false,
    ),
  ];

  // Get filtered tasks based on current filter
  List<Task> get filteredTasks {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (currentFilter) {
      case 'TODAY':
        return allTasks.where((task) {
          final taskDate = DateTime(
            task.dueDate.year,
            task.dueDate.month,
            task.dueDate.day,
          );
          return taskDate.isAtSameMomentAs(today) && !task.isDone;
        }).toList();

      case 'OVERDUE':
        return allTasks.where((task) {
          final taskDate = DateTime(
            task.dueDate.year,
            task.dueDate.month,
            task.dueDate.day,
          );
          return taskDate.isBefore(today) && !task.isDone;
        }).toList();

      case 'UPCOMING':
        return allTasks.where((task) {
          final taskDate = DateTime(
            task.dueDate.year,
            task.dueDate.month,
            task.dueDate.day,
          );
          return taskDate.isAfter(today) && !task.isDone;
        }).toList();

      default: // VIEW ALL
        return allTasks.where((task) => !task.isDone).toList();
    }
  }

  // Get tasks grouped by date for planner view
  Map<String, List<Task>> get groupedTasks {
    final Map<String, List<Task>> grouped = {};
    final tasks = filteredTasks;

    for (var task in tasks) {
      final dateKey = task.date;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(task);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Tasks',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Manage your daily action items, follow-up calls, and document collection protocols.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // Content Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                children: [
                  // Search and Toggle Section
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by name, email, phone',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[400],
                                size: 22,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // View Toggle
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            _buildViewToggle('LIST'),
                            _buildViewToggle('PLANNER'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Filter Tabs
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        _buildFilterTab('VIEW ALL'),
                        _buildFilterTab('TODAY'),
                        _buildFilterTab('OVERDUE'),
                        _buildFilterTab('UPCOMING'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Schedule Task Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D7C66),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0D7C66).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(28),
                        onTap: () {
                          // Add your schedule task logic here
                        },
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'SCHEDULE TASK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Display tasks based on current view
                  if (currentView == 'LIST')
                    _buildListView()
                  else
                    _buildPlannerView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // View Toggle Widget
  Widget _buildViewToggle(String view) {
    final isActive = currentView == view;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentView = view;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE8F4F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Text(
          view,
          style: TextStyle(
            color: isActive ? const Color(0xFF0D7C66) : Colors.grey[400],
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // Filter Tab Widget
  Widget _buildFilterTab(String filter) {
    final isActive = currentFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFE8F4F1) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              filter,
              style: TextStyle(
                color: isActive ? const Color(0xFF0D7C66) : Colors.grey[400],
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // List View
  Widget _buildListView() {
    final tasks = filteredTasks;

    if (tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Text(
            'No tasks found',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ),
      );
    }

    return Column(
      children: tasks
          .map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildTaskCard(task),
            ),
          )
          .toList(),
    );
  }

  // Planner View
  Widget _buildPlannerView() {
    final grouped = groupedTasks;

    if (grouped.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Text(
            'No tasks scheduled',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ),
      );
    }

    final sortedDates = grouped.keys.toList()
      ..sort((a, b) {
        // Simple date comparison based on day number
        final aDay = int.tryParse(a.split(' ')[1]) ?? 0;
        final bDay = int.tryParse(b.split(' ')[1]) ?? 0;
        return aDay.compareTo(bDay);
      });

    return Column(
      children: sortedDates.map((date) {
        final tasksForDate = grouped[date]!;
        final dayName = _getDayName(date);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0D7C66),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tasksForDate.length.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Tasks for this date
            ...tasksForDate
                .map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildPlannerTaskCard(task),
                  ),
                )
                .toList(),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  // Get day name from date string
  String _getDayName(String dateStr) {
    // Simple mapping for demo - you can enhance this
    final day = int.tryParse(dateStr.split(' ')[1]) ?? 0;
    final now = DateTime.now();

    if (day == now.day) return 'TODAY';
    if (day == now.day + 1) return 'TOMORROW';

    // Map day numbers to day names (simplified)
    const days = [
      'SUNDAY',
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
    ];
    final date = DateTime(now.year, now.month, day);
    return days[date.weekday % 7];
  }

  // Detailed Task Card for List View
  Widget _buildTaskCard(Task task) {
    final priorityColor = task.priority == 'HIGH'
        ? const Color(0xFFFF4D4D)
        : task.priority == 'MEDIUM'
        ? const Color(0xFFFDB022)
        : Colors.grey;

    final hasPhone = task.type == 'phone';
    final hasEmail = task.type == 'email';
    final hasDocument = task.type == 'document';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      color: priorityColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (hasPhone)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F4F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.phone,
                          color: Color(0xFF0D7C66),
                          size: 20,
                        ),
                      ),
                    if (hasEmail)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF4E6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mail_outline,
                          color: Color(0xFFFDB022),
                          size: 20,
                        ),
                      ),
                    if (hasDocument)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F4F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Color(0xFF0D7C66),
                          size: 20,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Icon(Icons.more_vert, color: Colors.grey[400], size: 24),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: const Color(0xFFE8F4F1),
                      child: Icon(
                        Icons.person_outline,
                        color: const Color(0xFF0D7C66),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      task.assignee,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey[400], size: 18),
                    const SizedBox(width: 6),
                    Text(
                      task.date,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0D7C66), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    setState(() {
                      task.isDone = true;
                    });
                  },
                  child: const Center(
                    child: Text(
                      'MARK AS DONE',
                      style: TextStyle(
                        color: Color(0xFF0D7C66),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Compact Task Card for Planner View
  Widget _buildPlannerTaskCard(Task task) {
    IconData typeIcon;
    Color iconColor;
    Color iconBgColor;

    switch (task.type) {
      case 'phone':
        typeIcon = Icons.phone;
        iconColor = const Color(0xFF0D7C66);
        iconBgColor = const Color(0xFFE8F4F1);
        break;
      case 'email':
        typeIcon = Icons.mail_outline;
        iconColor = const Color(0xFFFDB022);
        iconBgColor = const Color(0xFFFFF4E6);
        break;
      case 'document':
        typeIcon = Icons.description_outlined;
        iconColor = const Color(0xFF7C3AED);
        iconBgColor = const Color(0xFFF3E8FF);
        break;
      default:
        typeIcon = Icons.task_alt;
        iconColor = Colors.grey;
        iconBgColor = Colors.grey[200]!;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(typeIcon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          task.assignee,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              task.time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
