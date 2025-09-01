import '../models/user_model.dart';
import '../models/login_request_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<UserModel?> login(LoginRequestModel request) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock authentication logic
      if (request.email.isNotEmpty && request.password.length >= 6) {
        _currentUser = UserModel(
          id: '1',
          email: request.email,
          name: 'Akshay',
        );
        return _currentUser;
      }
      
      throw Exception('Invalid credentials');
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  bool get isLoggedIn => _currentUser != null;
}