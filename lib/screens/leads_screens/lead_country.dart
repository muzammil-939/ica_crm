import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class LeadCountryScreen extends StatefulWidget {
  const LeadCountryScreen({super.key});

  @override
  State<LeadCountryScreen> createState() => _LeadCountryScreenState();
}

class _LeadCountryScreenState extends State<LeadCountryScreen> {
  final TextEditingController _searchController = TextEditingController();

  final LeadsApi _api = LeadsApi();

  List<Map<String, dynamic>> _allCountries = [];
  List<Map<String, dynamic>> _filteredCountries = [];

  bool _isLoading = false;

  int _currentPage = 1;
  int _totalPages = 1;

  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
    _searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchCountries() async {
    try {
      setState(() => _isLoading = true);

      final data = await _api.getLeadCountries();

      setState(() {
        _allCountries = data;
        _applySearchAndPagination();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load countries: $e')),
      );
    }
  }

  void _onSearchChanged() {
    setState(() {
      _currentPage = 1;
      _applySearchAndPagination();
    });
  }

  void _applySearchAndPagination() {
    final query = _searchController.text.toLowerCase();

    _filteredCountries = _allCountries.where((country) {
      final name = country['name']?.toString().toLowerCase() ?? '';
      final id = country['id']?.toString() ?? '';
      return name.contains(query) || id.contains(query);
    }).toList();

    _totalPages = (_filteredCountries.length / _pageSize).ceil();
    if (_totalPages == 0) _totalPages = 1;

    if (_currentPage > _totalPages) {
      _currentPage = _totalPages;
    }
  }

  List<Map<String, dynamic>> get _paginatedCountries {
    final start = (_currentPage - 1) * _pageSize;
    final end = start + _pageSize;

    if (start >= _filteredCountries.length) return [];

    return _filteredCountries.sublist(
      start,
      end > _filteredCountries.length
          ? _filteredCountries.length
          : end,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final isTablet = size.width > 600;

    return MainLayout(
      title: 'Lead Country',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(isSmallScreen, isTablet),

              SizedBox(height: isSmallScreen ? 16 : 20),

              // Search and Add Button Row
              _buildSearchAndAddRow(isSmallScreen, isTablet),

              SizedBox(height: isSmallScreen ? 16 : 20),

              // Data Table
              _buildDataTable(isSmallScreen, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lead Country',
          style: TextStyle(
            fontSize: isSmallScreen ? 22 : (isTablet ? 28 : 24),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: isSmallScreen ? 4 : 8),
        Text(
          'Manage regional boundaries and international lead assignments.',
          style: TextStyle(
            fontSize: isSmallScreen ? 13 : (isTablet ? 16 : 14),
            color: const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndAddRow(bool isSmallScreen, bool isTablet) {
    return Row(
      children: [
        // Add Country Button
        ElevatedButton.icon(
          onPressed: _showAddCountryDialog,
          icon: Icon(Icons.add_circle_outline, size: isSmallScreen ? 18 : 20),
          label: Text(
            'ADD COUNTRY',
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00695C),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: isSmallScreen ? 10 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),

        SizedBox(width: isSmallScreen ? 8 : 12),

        // Search Field
        Expanded(
          child: Container(
            height: isSmallScreen ? 42 : 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search countries...',
                hintStyle: TextStyle(
                  color: const Color(0xFF999999),
                  fontSize: isSmallScreen ? 13 : 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF999999),
                  size: isSmallScreen ? 20 : 22,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 12,
                  vertical: isSmallScreen ? 10 : 12,
                ),
              ),
              style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
            ),
          ),
        ),

        // Country Count
        if (!isSmallScreen)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
    '${_filteredCountries.length} COUNTRIES',
              style: TextStyle(
                fontSize: isSmallScreen ? 11 : 12,
                color: const Color(0xFF999999),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDataTable(bool isSmallScreen, bool isTablet) {
    return Container(
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
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: isSmallScreen ? 12 : 16,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: isSmallScreen ? 30 : 40,
                  child: Text(
                    'S.NO',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF666666),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'COUNTRY',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF666666),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (!isSmallScreen)
                  Expanded(
                    flex: 2,
                    child: Text(
                      'CODE',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 11 : 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF666666),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                SizedBox(
                  width: isSmallScreen ? 70 : 100,
                  child: Text(
                    'ACTIONS',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF666666),
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          // Table Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _paginatedCountries.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
            itemBuilder: (context, index) {
              final serialNumber =
                  ((_currentPage - 1) * _pageSize) + index + 1;

              return _buildTableRow(
                serialNumber,
                _paginatedCountries[index],
                isSmallScreen,
                isTablet,
              );
            },
          ),
          SizedBox(height: 20),
          _buildPaginationControls(),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _currentPage > 1
              ? () => setState(() => _currentPage--)
              : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          'Page $_currentPage of $_totalPages',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        IconButton(
          onPressed: _currentPage < _totalPages
              ? () => setState(() => _currentPage++)
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _buildTableRow(
    int serialNo,
    Map<String, dynamic> country,
    bool isSmallScreen,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 14 : 16,
      ),
      child: Row(
        children: [
          // Serial Number
          SizedBox(
            width: isSmallScreen ? 30 : 40,
            child: Text(
              '$serialNo',
              style: TextStyle(
                fontSize: isSmallScreen ? 13 : 14,
                color: const Color(0xFF666666),
              ),
            ),
          ),

          // Country Info
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Location Icon
                Container(
                  width: isSmallScreen ? 32 : 36,
                  height: isSmallScreen ? 32 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: const Color(0xFF00695C),
                    size: isSmallScreen ? 16 : 18,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 12),

                // Country Name and Region
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        country['name'],
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      const Text(
                        'Lead Country',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Code Badge (hide on small screens)
          if (!isSmallScreen)
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  country['id'].toString(),
                  style: TextStyle(
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00695C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // Action Buttons
          SizedBox(
            width: isSmallScreen ? 70 : 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Edit Button
                Container(
                  width: isSmallScreen ? 32 : 36,
                  height: isSmallScreen ? 32 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.edit_outlined,
                      size: isSmallScreen ? 16 : 18,
                      color: const Color(0xFFFF8F00),
                    ),
                    onPressed: () {
                      _showEditCountryDialog(country);
                    },
                  ),
                ),
                SizedBox(width: isSmallScreen ? 6 : 8),

                // Delete Button
                Container(
                  width: isSmallScreen ? 32 : 36,
                  height: isSmallScreen ? 32 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.delete_outline,
                      size: isSmallScreen ? 16 : 18,
                      color: const Color(0xFFE53935),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text(
                            'Delete Country',
                            style: TextStyle(
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to delete this country?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE53935),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                Navigator.pop(context);

                                try {
                                  await _api.deleteLeadCountry(country['id']);

                                  setState(() {
                                    _allCountries.removeWhere(
                                            (c) => c['id'] == country['id']);
                                    _applySearchAndPagination();
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Country deleted')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Delete failed: $e')),
                                  );
                                }
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showAddCountryDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Create Lead Country',
          style: TextStyle(
            color: Color(0xFF059669),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Country Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF059669),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                final newCountry =
                await _api.createLeadCountry({"name": name});

                setState(() {
                  _allCountries.insert(0, newCountry);
                  _applySearchAndPagination();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Country created successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showEditCountryDialog(Map<String, dynamic> country) {
    final TextEditingController nameController =
    TextEditingController(text: country['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Edit Lead Country',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Country Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final updatedName = nameController.text.trim();
              if (updatedName.isEmpty) return;

              Navigator.pop(context);

              try {
                final updatedCountry =
                await _api.updateLeadCountry(
                  country['id'],
                  {"name": updatedName},
                );

                setState(() {
                  final index = _allCountries.indexWhere(
                          (c) => c['id'] == country['id']);

                  if (index != -1) {
                    _allCountries[index] = updatedCountry;
                  }

                  _applySearchAndPagination();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Country updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: $e')),
                );
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }


}

