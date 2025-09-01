import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user_model.dart';
import '../models/login_request_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // In-memory storage for web (since SQLite doesn't work on web)
  static final List<Map<String, dynamic>> _webUsers = [];
  
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  // Login with web-compatible storage
  Future<UserModel?> login(LoginRequestModel request) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      if (kIsWeb) {
        // Web: Use in-memory storage
        final userMap = _webUsers.firstWhere(
          (user) => user['email'] == request.email && user['password'] == request.password,
          orElse: () => {},
        );
        
        if (userMap.isEmpty) {
          throw Exception('Invalid credentials');
        }
        
        _currentUser = UserModel(
          id: userMap['id'].toString(),
          email: userMap['email'],
          name: userMap['name'],
        );
      } else {
        // Mobile: Use SQLite (import DatabaseHelper here when needed)
        // For now, fallback to mock data
        if (request.email == 'test@test.com' && request.password == 'password') {
          _currentUser = UserModel(
            id: '1',
            email: request.email,
            name: 'Test User',
          );
        } else {
          throw Exception('Invalid credentials');
        }
      }
      
      return _currentUser;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Register new user
  Future<UserModel> register(String email, String name, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      if (kIsWeb) {
        // Web: Check if email exists in memory
        final exists = _webUsers.any((user) => user['email'] == email);
        if (exists) {
          throw Exception('Email already exists');
        }

        // Add to in-memory storage
        final newUser = {
          'id': DateTime.now().millisecondsSinceEpoch,
          'email': email,
          'name': name,
          'password': password,
        };
        _webUsers.add(newUser);

        _currentUser = UserModel(
          id: newUser['id'].toString(),
          email: email,
          name: name,
        );
      } else {
        // Mobile: Use SQLite (implement later)
        _currentUser = UserModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email,
          name: name,
        );
      }

      return _currentUser!;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
  }
}