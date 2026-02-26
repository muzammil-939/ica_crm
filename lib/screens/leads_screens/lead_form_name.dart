import 'package:flutter/material.dart';
import '../../layouts/main_layout.dart';
import 'package:ica_crm/services/features/leads/leads_api.dart';

class LeadFormNameScreen extends StatefulWidget {
  const LeadFormNameScreen({super.key});

  @override
  State<LeadFormNameScreen> createState() => _LeadFormNameScreenState();
}

class _LeadFormNameScreenState extends State<LeadFormNameScreen> {
  final TextEditingController searchController = TextEditingController();
  final LeadsApi _api = LeadsApi();

  bool isLoading = true;
  List<Map<String, dynamic>> allForms = [];
  List<Map<String, dynamic>> filteredForms = [];

  String? _nextUrl;
  String? _previousUrl;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchLeadForms();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchLeadForms({String? url}) async {
    try {
      setState(() => isLoading = true);

      final data = await _api.getLeadForms(url: url);

      final results = List<Map<String, dynamic>>.from(data['results'] ?? []);
      final count = data['count'] ?? results.length;

      setState(() {
        allForms = results;
        filteredForms = results;

        _nextUrl = data['next'];
        _previousUrl = data['previous'];
        _totalCount = count;

        _totalPages = (filteredForms.length / 10).ceil();
        _currentPage = 1;

        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load forms: $e")),
      );
    }
  }

  List<Map<String, dynamic>> get _paginatedForms {
    const pageSize = 10;
    final start = (_currentPage - 1) * pageSize;
    final end = start + pageSize;

    if (start >= filteredForms.length) return [];

    return filteredForms.sublist(
      start,
      end > filteredForms.length ? filteredForms.length : end,
    );
  }

  void _onSearchChanged() {
    setState(() {
      _currentPage = 1;
      _applySearchAndPagination();
    });
  }

  void _showCreateFormDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController externalIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Create Lead Form',
          style: TextStyle(
            color: Color(0xFF059669),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Form name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(hintText: 'Facebook ID'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => isLoading = true);

                final newForm = await _api.createLeadForm({
                  "name": name,
                  "facebook_id": externalIdController.text.trim(), // map correctly
                });

                setState(() {
                  allForms.insert(0, newForm);
                  _applySearchAndPagination();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form created successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Create failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF059669),
              foregroundColor: Colors.white,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> form) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Form',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${form['name']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
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
                setState(() => isLoading = true);

                await _api.deleteLeadForm(form['id']);

                setState(() {
                  allForms.removeWhere((f) => f['id'] == form['id']);
                  filteredForms.removeWhere((f) => f['id'] == form['id']);

                  _totalPages = (filteredForms.length / 10).ceil();

                  if (_currentPage > _totalPages && _totalPages > 0) {
                    _currentPage = _totalPages;
                  }
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Lead Form Name',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HEADER SECTION
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Manage and configure specialized lead capture forms with integration identifiers.',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 16),

                // Action Button
                ElevatedButton.icon(
                  onPressed: _showCreateFormDialog,
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text(
                    'ADD NEW FORM',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF059669),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by form name or ID...',
                    hintStyle: const TextStyle(color: Colors.black38),
                    prefixIcon:
                    const Icon(Icons.search, color: Colors.black38),
                    filled: true,
                    fillColor: const Color(0xFFF5F7FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${filteredForms.length} FORMS',
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // FORMS LIST
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredForms.isEmpty
                ? _buildEmptyState()
                : Column(
              children: [

                /// LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _paginatedForms.length,
                    itemBuilder: (context, index) {
                      return _buildFormCard(_paginatedForms[index]);
                    },
                  ),
                ),

                /// PAGINATION (Modern Style)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFE0E0E0), width: 1),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      /// Page Info
                      Text(
                        'PAGE $_currentPage OF $_totalPages',
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Arrows + Page Numbers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: _currentPage > 1
                                ? () => setState(() => _currentPage--)
                                : null,
                            child: Icon(
                              Icons.chevron_left,
                              color: _currentPage > 1
                                  ? const Color(0xFF666666)
                                  : const Color(0xFFCCCCCC),
                            ),
                          ),

                          const SizedBox(width: 6),

                          ...List.generate(
                            _totalPages,
                                (index) => index + 1,
                          )
                              .where((page) =>
                          page >= _currentPage - 1 &&
                              page <= _currentPage + 1)
                              .map(
                                (page) => Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                              child: InkWell(
                                onTap: () =>
                                    setState(() => _currentPage = page),
                                child: Container(
                                  width: 34,
                                  height: 34,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _currentPage == page
                                        ? const Color(0xFF059669)
                                        : Colors.transparent,
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '$page',
                                    style: TextStyle(
                                      color: _currentPage == page
                                          ? Colors.white
                                          : const Color(0xFF666666),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                              .toList(),

                          const SizedBox(width: 6),

                          InkWell(
                            onTap: _currentPage < _totalPages
                                ? () => setState(() => _currentPage++)
                                : null,
                            child: Icon(
                              Icons.chevron_right,
                              color: _currentPage < _totalPages
                                  ? const Color(0xFF666666)
                                  : const Color(0xFFCCCCCC),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.description_outlined,
            size: 64,
            color: Colors.black26,
          ),
          SizedBox(height: 16),
          Text(
            'No forms found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your search',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(Map<String, dynamic> form) {
    final id = form['id']?.toString() ?? '';
    final name = form['name'] ?? 'No Name';
    final facebookId = form['facebook_id'] ?? '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'ID: $id',
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),

                // EDIT BUTTON
                IconButton(
                  onPressed: () => _showEditFormDialog(form),
                  icon: const Icon(Icons.edit_outlined),
                  color: const Color(0xFFFFA726), // yellow
                ),

                // DELETE BUTTON
                IconButton(
                  onPressed: () => _confirmDelete(form),
                  icon: const Icon(Icons.delete_outline),
                  color: const Color(0xFFE53935),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow('Form Name', name),
                const SizedBox(height: 12),
                _buildDetailRow('Facebook ID', facebookId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showEditFormDialog(Map<String, dynamic> form) {
    final TextEditingController nameController =
    TextEditingController(text: form['name']);
    final TextEditingController externalIdController =
    TextEditingController(text: form['facebook_id']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Lead Form',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Form name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: externalIdController,
                decoration: const InputDecoration(hintText: 'Facebook ID'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedName = nameController.text.trim();
              if (updatedName.isEmpty) return;

              Navigator.pop(context);

              try {
                setState(() => isLoading = true);

                final updatedForm = await _api.updateLeadForm(
                  form['id'],
                  {
                    "name": updatedName,
                    "facebook_id": externalIdController.text.trim(),
                  },
                );

                setState(() {
                  final index =
                  allForms.indexWhere((f) => f['id'] == form['id']);

                  if (index != -1) {
                    allForms[index] = updatedForm;
                  }

                  _applySearchAndPagination();
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form updated successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Update failed: $e')),
                );
              } finally {
                setState(() => isLoading = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _applySearchAndPagination() {
    final query = searchController.text.toLowerCase();

    filteredForms = allForms.where((form) {
      final name = form['name']?.toString().toLowerCase() ?? '';
      final id = form['id']?.toString() ?? '';
      return name.contains(query) || id.contains(query);
    }).toList();

    _totalPages = (filteredForms.length / 10).ceil();
    if (_totalPages == 0) _totalPages = 1;

    if (_currentPage > _totalPages) {
      _currentPage = _totalPages;
    }
  }
}