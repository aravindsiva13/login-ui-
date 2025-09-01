import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  User? _user;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  User? get user => _user;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String emailOrPhone, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _authService.login(emailOrPhone, password);
      _isLoading = false;
      notifyListeners();
      
      if (_user == null) {
        _errorMessage = 'Invalid credentials';
        return false;
      }
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Login failed. Please try again.';
      notifyListeners();
      return false;
    }
  }
}