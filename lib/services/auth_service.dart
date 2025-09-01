import '../models/user.dart';

class AuthService {
  Future<User?> login(String emailOrPhone, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    
    if ((emailOrPhone == "test@test.com" || emailOrPhone == "1234567890") &&
        password == "password") {
      return User(
        id: "1",
        email: emailOrPhone,
        name: "Test User",
      );
    }
    return null;
  }
}