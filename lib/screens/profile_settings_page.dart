import 'package:flutter/material.dart';
import '../layouts/main_layout.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hasChanges = false;

  // Form controllers
  final _displayNameController = TextEditingController(text: 'Alex Johnson');
  final _emailController = TextEditingController(
    text: 'alex.johnson@crmstudio.io',
  );
  final _phoneController = TextEditingController(text: '9876543210');
  final _monthlyTargetController = TextEditingController(text: '0');

  // Dropdown values
  String _selectedOfficer = 'Sagar (Super Admin)';
  String _selectedRank = 'SUPER ADMIN';
  String _selectedDivision = 'ADMIN';

  // Dropdown options
  final List<String> _officers = [
    'Sagar (Super Admin)',
    'John Smith (Manager)',
    'Sarah Lee (Director)',
    'Mike Johnson (Team Lead)',
  ];

  final List<String> _ranks = [
    'SUPER ADMIN',
    'ADMIN',
    'MANAGER',
    'TEAM LEAD',
    'MEMBER',
  ];

  final List<String> _divisions = [
    'ADMIN',
    'SALES',
    'MARKETING',
    'SUPPORT',
    'OPERATIONS',
  ];

  @override
  void initState() {
    super.initState();
    // Listen to all text field changes
    _displayNameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _phoneController.addListener(_onFieldChanged);
    _monthlyTargetController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  void _onDropdownChanged() {
    setState(() {
      _hasChanges = true;
    });
  }

  void _handleImagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Camera feature would open here');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Gallery picker would open here');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove Photo'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Photo removed');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleCommit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Changes'),
          content: const Text('Are you sure you want to save these changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _hasChanges = false;
                });
                _showSnackBar('Changes saved successfully!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
              ),
              child: const Text('SAVE'),
            ),
          ],
        ),
      );
    }
  }

  void _handleAbort() {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Discard Changes'),
          content: const Text('Are you sure you want to discard all changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Reset all fields
                _displayNameController.text = 'Alex Johnson';
                _emailController.text = 'alex.johnson@crmstudio.io';
                _phoneController.text = '9876543210';
                _monthlyTargetController.text = '0';
                setState(() {
                  _selectedOfficer = 'Sagar (Super Admin)';
                  _selectedRank = 'SUPER ADMIN';
                  _selectedDivision = 'ADMIN';
                  _hasChanges = false;
                });
                _showSnackBar('Changes discarded');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('DISCARD'),
            ),
          ],
        ),
      );
    } else {
      _showSnackBar('No changes to discard');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _monthlyTargetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return MainLayout(
      title: 'Profile Settings',
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: const Color(0xFF00695C),
                      size: isSmallScreen ? 24 : 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile Settings',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage your personal information, contact details, and professional targets.',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 14,
                              color: const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Profile Card
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar with camera icon
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFF00695C),
                                radius: isSmallScreen ? 40 : 50,
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isSmallScreen ? 32 : 40,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: _handleImagePicker,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00695C),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 16),

                          // Name and badges
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ALEX JOHNSON',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 18 : 22,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1A1A1A),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildBadge(
                                      'SUPER ADMIN',
                                      const Color(0xFF00695C),
                                    ),
                                    _buildBadge(
                                      'ADMIN',
                                      const Color(0xFF666666),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Your profile identity is managed across all CRM divisions. Changes to your username will update your display initials instantly.',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 13,
                                    color: const Color(0xFF666666),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Account sync badge
                          if (!isSmallScreen)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'ACCOUNT SYNC',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: const Color(0xFF999999),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: const Color(0xFF00695C),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Verified Professional',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFF00695C),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Account sync for small screens
                      if (isSmallScreen) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF00695C),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Verified Professional',
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xFF00695C),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Change indicator
                if (_hasChanges)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3CD),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFE082)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFFE65100),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'You have unsaved changes',
                            style: TextStyle(
                              color: const Color(0xFFE65100),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Personal Identity & Command Performance sections
                if (isSmallScreen)
                  // Stack vertically on small screens
                  Column(
                    children: [
                      _buildPersonalIdentitySection(),
                      const SizedBox(height: 16),
                      _buildCommandPerformanceSection(),
                    ],
                  )
                else
                  // Side by side on larger screens
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildPersonalIdentitySection()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildCommandPerformanceSection()),
                    ],
                  ),

                const SizedBox(height: 24),

                // Global State Sync & Action Buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GLOBAL STATE SYNC',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: const Color(0xFF999999),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'RANK: SUPER ADMIN • SYNC ACTIVE',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: const Color(0xFF1A1A1A),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (isSmallScreen)
                        // Stack buttons vertically on small screens
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: _handleAbort,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  side: BorderSide(
                                    color: _hasChanges
                                        ? Colors.red
                                        : const Color(0xFFDDDDDD),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'ABORT CHANGES',
                                  style: TextStyle(
                                    color: _hasChanges
                                        ? Colors.red
                                        : const Color(0xFF1A1A1A),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _hasChanges ? _handleCommit : null,
                                icon: const Icon(Icons.save, size: 18),
                                label: const Text(
                                  'COMMIT UPDATES',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00695C),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: const Color(
                                    0xFFE0E0E0,
                                  ),
                                  disabledForegroundColor: const Color(
                                    0xFF999999,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        // Side by side on larger screens
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _handleAbort,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  side: BorderSide(
                                    color: _hasChanges
                                        ? Colors.red
                                        : const Color(0xFFDDDDDD),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'ABORT CHANGES',
                                  style: TextStyle(
                                    color: _hasChanges
                                        ? Colors.red
                                        : const Color(0xFF1A1A1A),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: ElevatedButton.icon(
                                onPressed: _hasChanges ? _handleCommit : null,
                                icon: const Icon(Icons.save, size: 18),
                                label: const Text(
                                  'COMMIT UPDATES',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00695C),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: const Color(
                                    0xFFE0E0E0,
                                  ),
                                  disabledForegroundColor: const Color(
                                    0xFF999999,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalIdentitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'PERSONAL IDENTITY',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF999999),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildEditableField(
            'YOUR DISPLAY NAME',
            _displayNameController,
            Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildEditableField(
            'OFFICIAL EMAIL',
            _emailController,
            Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildEditableField(
            'COMMUNICATION LINE',
            _phoneController,
            Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCommandPerformanceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'COMMAND & PERFORMANCE',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF999999),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildEditableField(
            'MONTHLY CONVERSION TARGET',
            _monthlyTargetController,
            Icons.flag_outlined,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a target';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildInteractiveDropdown(
            'DIRECT COMMANDING OFFICER',
            _selectedOfficer,
            _officers,
            Icons.person_outline,
            (value) {
              setState(() {
                _selectedOfficer = value!;
                _onDropdownChanged();
              });
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildInteractiveDropdown(
                  'YOUR ACCESS RANK',
                  _selectedRank,
                  _ranks,
                  null,
                  (value) {
                    setState(() {
                      _selectedRank = value!;
                      _onDropdownChanged();
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInteractiveDropdown(
                  'ASSIGNED DIVISION',
                  _selectedDivision,
                  _divisions,
                  null,
                  (value) {
                    setState(() {
                      _selectedDivision = value!;
                      _onDropdownChanged();
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: const Color(0xFF999999),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF1A1A1A),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF999999), size: 20),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
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
              borderSide: const BorderSide(color: Color(0xFF00695C), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveDropdown(
    String label,
    String value,
    List<String> items,
    IconData? icon,
    void Function(String?)? onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: const Color(0xFF999999),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF999999),
                size: 20,
              ),
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF1A1A1A),
                fontWeight: FontWeight.w500,
              ),
              dropdownColor: Colors.white,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: const Color(0xFF999999), size: 20),
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: Text(item, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
