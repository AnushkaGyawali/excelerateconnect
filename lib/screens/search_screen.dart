import 'package:flutter/material.dart';
import '../models/program.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String? _selectedDuration;

  final List<Program> _allPrograms = [
    Program(
      id: '1',
      title: 'Web Design',
      provider: 'Excelerate',
      duration: '15 hours',
      category: 'Design',
      tags: ['Visual Identity', 'Painting', 'Coding', 'Writing'],
      rating: 4.8,
      enrolled: 1250,
      price: '\$99.99',
      description: 'Master modern web design',
      level: 'Intermediate',
      hours: 15,
      isPopular: true,
      isNew: false,
    ),
    Program(
      id: '2',
      title: 'App Development',
      provider: 'Excelerate',
      duration: '18 hours',
      category: 'Coding',
      tags: ['Flutter', 'Mobile', 'UI/UX'],
      rating: 4.9,
      enrolled: 890,
      price: '\$129.99',
      description: 'Build cross-platform apps',
      level: 'Advanced',
      hours: 18,
      isPopular: true,
      isNew: false,
    ),
    Program(
      id: '3',
      title: 'Data Science',
      provider: 'Excelerate',
      duration: '24 hours',
      category: 'Coding',
      tags: ['Python', 'ML', 'AI'],
      rating: 4.7,
      enrolled: 2100,
      price: '\$149.99',
      description: 'Data analysis fundamentals',
      level: 'Advanced',
      hours: 24,
      isPopular: true,
      isNew: true,
    ),
    Program(
      id: '4',
      title: 'UI/UX Painting',
      provider: 'Excelerate',
      duration: '12 hours',
      category: 'Painting',
      tags: ['Visual', 'Art', 'Design'],
      rating: 4.6,
      enrolled: 540,
      price: '\$79.99',
      description: 'Digital painting for UI design',
      level: 'Beginner',
      hours: 12,
      isPopular: false,
      isNew: true,
    ),
    Program(
      id: '5',
      title: 'Visual Identity Design',
      provider: 'Excelerate',
      duration: '10 hours',
      category: 'Visual Identity',
      tags: ['Branding', 'Logo', 'Typography'],
      rating: 4.7,
      enrolled: 780,
      price: '\$69.99',
      description: 'Create visual identity systems',
      level: 'Intermediate',
      hours: 10,
      isPopular: true,
      isNew: false,
    ),
  ];

  List<Program> _filteredPrograms = [];

  @override
  void initState() {
    super.initState();
    _filteredPrograms = _allPrograms;
  }

  void _applyFilters() {
    setState(() {
      _filteredPrograms = _allPrograms.where((program) {
        // Category filter
        if (_selectedCategory != 'All' &&
            program.category != _selectedCategory) {
          return false;
        }

        // Search query filter
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          if (!program.title.toLowerCase().contains(query) &&
              !program.description.toLowerCase().contains(query) &&
              !program.tags.any((tag) => tag.toLowerCase().contains(query))) {
            return false;
          }
        }

        // Duration filter
        if (_selectedDuration != null) {
          final range = _selectedDuration!.split('-');
          if (range.length == 2) {
            final min = int.tryParse(range[0]) ?? 0;
            final max = int.tryParse(range[1]) ?? 0;
            if (program.hours < min || program.hours > max) {
              return false;
            }
          }
        }

        return true;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedCategory = 'All';
      _selectedDuration = null;
      _filteredPrograms = _allPrograms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                            _applyFilters();
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _applyFilters();
                });
              },
            ),
          ),

          // Filter Section
          ExpansionTile(
            title: const Text(
              'Search Filter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            initiallyExpanded: true,
            children: [
              // Categories
              _buildFilterSection(
                'Categories',
                [
                  'Design',
                  'Painting',
                  'Coding',
                  'Music',
                  'Visual Identity',
                  'Mathematics'
                ],
                _selectedCategory,
                (category) {
                  setState(() {
                    _selectedCategory = category;
                    _applyFilters();
                  });
                },
              ),

              // Duration
              _buildFilterSection(
                'Duration',
                [
                  '3-8 Hours',
                  '8-14 Hours',
                  '14-20 Hours',
                  '20-24 Hours',
                  '24-30 Hours'
                ],
                _selectedDuration ?? '',
                (duration) {
                  setState(() {
                    _selectedDuration =
                        duration == _selectedDuration ? null : duration;
                    _applyFilters();
                  });
                },
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearFilters,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primary,
                          side: const BorderSide(color: AppTheme.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Clear'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Apply Filter'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Results
          Expanded(
            child: _filteredPrograms.isEmpty
                ? const Center(
                    child: Text(
                      'No programs found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredPrograms.length,
                    itemBuilder: (context, index) {
                      final program = _filteredPrograms[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading:
                              const Icon(Icons.school, color: AppTheme.primary),
                          title: Text(program.title),
                          subtitle: Text(
                            '${program.provider} • ${program.duration}',
                          ),
                          trailing: Text(
                            program.price,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    String selectedValue,
    Function(String) onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final isSelected = option == selectedValue;
              return ChoiceChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (_) => onTap(option),
                selectedColor: AppTheme.primary.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: isSelected ? AppTheme.primary : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
