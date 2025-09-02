

import '../models/user_model.dart';
import '../models/login_request_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static final List<Map<String, String>> _users = [];
  
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<UserModel> login(LoginRequestModel request) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    final user = _users.firstWhere(
      (user) => user['email'] == request.email && user['password'] == request.password,
      orElse: () => {},
    );
    
    if (user.isEmpty) {
      throw Exception('Invalid credentials');
    }
    
    _currentUser = UserModel(
      id: user['id']!,
      email: user['email']!,
      name: user['name'],
    );
    
    return _currentUser!;
  }

  Future<UserModel> register(String email, String name, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    // Check if email exists
    if (_users.any((user) => user['email'] == email)) {
      throw Exception('Email already exists');
    }

    final newUser = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'email': email,
      'name': name,
      'password': password,
    };
    
    _users.add(newUser);

    _currentUser = UserModel(
      id: newUser['id']!,
      email: email,
      name: name,
    );

    return _currentUser!;
  }

  Future<void> logout() async {
    _currentUser = null;
  }
}