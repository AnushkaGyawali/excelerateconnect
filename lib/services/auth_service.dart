import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class AuthService {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _fileName = 'users.json';
  List<User> _users = [];
  User? _currentUser;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = json.decode(contents);
        _users = jsonList.map((json) => User.fromMap(json)).toList();
      } else {
        // Start with empty users list
        _users = [];
        await _saveUsers();
      }
      _initialized = true;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading users: $e');
      }
      _users = [];
      _initialized = true;
    }
  }

  Future<void> _saveUsers() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_fileName');
      
      final jsonList = _users.map((user) => user.toMap()).toList();
      final jsonString = json.encode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving users: $e');
      }
    }
  }

  // Register new user
  Future<AuthResult> register(User user) async {
    await init(); // Ensure initialized
    
    // Check if email already exists
    if (_users.any((u) => u.email.toLowerCase() == user.email.toLowerCase())) {
      return AuthResult(success: false, message: 'Email already registered');
    }

    // Validate email format
    if (!_isValidEmail(user.email)) {
      return AuthResult(success: false, message: 'Invalid email format');
    }

    // Validate password strength
    if (user.password.length < 6) {
      return AuthResult(success: false, message: 'Password must be at least 6 characters');
    }

    _users.add(user);
    await _saveUsers();
    
    // Auto-login after registration
    _currentUser = user;
    
    return AuthResult(success: true, message: 'Registration successful');
  }

  // Login user
  Future<AuthResult> login(String email, String password) async {
    await init(); // Ensure initialized
    
    final user = _users.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      orElse: () => User(name: '', email: '', password: ''),
    );

    if (user.email.isEmpty) {
      return AuthResult(success: false, message: 'Invalid email or password');
    }

    _currentUser = user;
    return AuthResult(success: true, message: 'Login successful');
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _currentUser != null;
  }

  // Get current user
  User? get currentUser => _currentUser;

  // Logout
  void logout() {
    _currentUser = null;
  }

  // Email validation
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  // Clear all users (for debugging)
  Future<void> clearAllUsers() async {
    _users = [];
    _currentUser = null;
    await _saveUsers();
  }

  // Get all users (for debugging)
  List<User> getAllUsers() {
    return List.from(_users);
  }

  // Print all users (for debugging)
  void printAllUsers() {
    if (kDebugMode) {
      print('=== STORED USERS ===');
      print('Total users: ${_users.length}');
      if (_users.isEmpty) {
        print('No users registered yet.');
      } else {
        for (var user in _users) {
          print('📧 ${user.email} | 👤 ${user.name}');
        }
      }
      print('===================');
    }
  }
}

class AuthResult {
  final bool success;
  final String message;

  AuthResult({required this.success, required this.message});
}