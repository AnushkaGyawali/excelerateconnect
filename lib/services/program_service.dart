import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/program.dart';

class ProgramService {
  static Future<List<Program>> getProgramsFromJson() async {
    await Future.delayed(const Duration(seconds: 1));

    final mockJson = '''
    [
      {
        "id": "1",
        "title": "Web Design",
        "provider": "Excelerate",
        "duration": "15 hours",
        "category": "Design",
        "tags": ["Visual Identity", "UI/UX", "Coding"],
        "rating": 4.8,
        "enrolled": 1250,
        "price": "\$99.99",
        "description": "Master modern web design with Figma and responsive principles",
        "level": "Intermediate",
        "hours": 15,
        "isPopular": true,
        "isNew": false
      },
      {
        "id": "2",
        "title": "App Development",
        "provider": "Excelerate",
        "duration": "18 hours",
        "category": "Coding",
        "tags": ["Flutter", "Dart", "Mobile"],
        "rating": 4.9,
        "enrolled": 890,
        "price": "\$129.99",
        "description": "Build cross-platform apps with Flutter",
        "level": "Advanced",
        "hours": 18,
        "isPopular": true,
        "isNew": false
      },
      {
        "id": "3",
        "title": "Data Science",
        "provider": "Excelerate",
        "duration": "24 hours",
        "category": "Coding",
        "tags": ["Python", "ML", "AI"],
        "rating": 4.7,
        "enrolled": 2100,
        "price": "\$149.99",
        "description": "Data analysis and machine learning fundamentals",
        "level": "Advanced",
        "hours": 24,
        "isPopular": true,
        "isNew": true
      },
      {
        "id": "4",
        "title": "UI/UX Painting",
        "provider": "Excelerate",
        "duration": "12 hours",
        "category": "Painting",
        "tags": ["Visual", "Art", "Design"],
        "rating": 4.6,
        "enrolled": 540,
        "price": "\$79.99",
        "description": "Learn digital painting for UI design",
        "level": "Beginner",
        "hours": 12,
        "isPopular": false,
        "isNew": true
      },
      {
        "id": "5",
        "title": "Music Production",
        "provider": "Excelerate",
        "duration": "20 hours",
        "category": "Music",
        "tags": ["Audio", "Mixing", "DAW"],
        "rating": 4.5,
        "enrolled": 320,
        "price": "\$89.99",
        "description": "Produce professional music tracks",
        "level": "Intermediate",
        "hours": 20,
        "isPopular": false,
        "isNew": false
      },
      {
        "id": "6",
        "title": "Visual Identity Design",
        "provider": "Excelerate",
        "duration": "10 hours",
        "category": "Visual Identity",
        "tags": ["Branding", "Logo", "Typography"],
        "rating": 4.7,
        "enrolled": 780,
        "price": "\$69.99",
        "description": "Create complete visual identity systems",
        "level": "Intermediate",
        "hours": 10,
        "isPopular": true,
        "isNew": false
      },
      {
        "id": "7",
        "title": "Mathematics for Programmers",
        "provider": "Excelerate",
        "duration": "16 hours",
        "category": "Mathematics",
        "tags": ["Algorithms", "Logic", "Calculus"],
        "rating": 4.4,
        "enrolled": 420,
        "price": "\$59.99",
        "description": "Essential math for software development",
        "level": "Advanced",
        "hours": 16,
        "isPopular": false,
        "isNew": true
      },
      {
        "id": "8",
        "title": "Creative Writing",
        "provider": "Excelerate",
        "duration": "14 hours",
        "category": "Writing",
        "tags": ["Storytelling", "Content", "Blog"],
        "rating": 4.3,
        "enrolled": 290,
        "price": "\$49.99",
        "description": "Improve your writing skills for digital content",
        "level": "Beginner",
        "hours": 14,
        "isPopular": false,
        "isNew": false
      }
    ]
    ''';

    final jsonData = jsonDecode(mockJson);
    return List<Program>.from(
        jsonData.map((program) => Program.fromJson(program)));
  }

  // Filter programs by category, duration, and search query
  static List<Program> filterPrograms({
    required List<Program> allPrograms,
    String category = 'All',
    String? durationFilter,
    String searchQuery = '',
    List<String> selectedTags = const [],
  }) {
    List<Program> filtered = allPrograms;

    // Apply category filter
    if (category != 'All') {
      filtered = filtered.where((p) => p.category == category).toList();
    }

    // Apply duration filter
    if (durationFilter != null) {
      final range = _parseDurationRange(durationFilter);
      if (range != null) {
        filtered = filtered.where((p) {
          return p.hours >= range[0] && p.hours <= range[1];
        }).toList();
      }
    }

    // Apply search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p.tags.any(
                (tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Apply tag filters
    if (selectedTags.isNotEmpty) {
      filtered = filtered.where((p) {
        return p.tags.any((tag) => selectedTags.contains(tag));
      }).toList();
    }

    return filtered;
  }

  static List<int>? _parseDurationRange(String duration) {
    final parts = duration.split('-');
    if (parts.length == 2) {
      return [
        int.tryParse(parts[0]) ?? 0,
        int.tryParse(parts[1]) ?? 0,
      ];
    }
    return null;
  }

  // Get all unique categories
  static List<String> getAllCategories(List<Program> programs) {
    final categories = programs.map((p) => p.category).toSet().toList();
    return ['All', ...categories];
  }

  // Get all unique tags
  static List<String> getAllTags(List<Program> programs) {
    final allTags = programs.expand((p) => p.tags).toSet().toList();
    return allTags;
  }
}
