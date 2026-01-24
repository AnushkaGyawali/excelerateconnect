import 'package:flutter/material.dart';
import '../models/program.dart';

class EnrollmentService extends ChangeNotifier {
  // Singleton pattern
  static final EnrollmentService _instance = EnrollmentService._internal();
  factory EnrollmentService() => _instance;
  EnrollmentService._internal();

  List<Program> _enrolledPrograms = [];

  // Enroll in a program
  void enrollInProgram(Program program) {
    if (!_enrolledPrograms.any((p) => p.id == program.id)) {
      _enrolledPrograms.add(program);
      notifyListeners(); // Notify listeners about change

      // Print for debugging
      debugPrint('Enrolled in: ${program.title}');
      debugPrint('Total enrolled programs: ${_enrolledPrograms.length}');
    }
  }

  // Get all enrolled programs
  List<Program> getEnrolledPrograms() {
    return List.from(_enrolledPrograms);
  }

  // Check if enrolled in a program
  bool isEnrolled(String programId) {
    return _enrolledPrograms.any((p) => p.id == programId);
  }

  // Remove enrollment
  void unenrollFromProgram(String programId) {
    _enrolledPrograms.removeWhere((p) => p.id == programId);
    notifyListeners();
  }

  // Clear all enrollments
  void clearEnrollments() {
    _enrolledPrograms.clear();
    notifyListeners();
  }

  // Get count
  int get enrolledCount => _enrolledPrograms.length;
}
