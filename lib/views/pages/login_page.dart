import 'package:flutter/material.dart';
import '../../viewmodels/login_viewmodel.dart';
import '../../utils/validators.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/animated_button.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _viewModel = LoginViewModel();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 480;
    final isTablet = screenWidth > 480 && screenWidth <= 768;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1a1a1a), Color(0xFF000000)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 20.0 : 40.0),
              child: GlassContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Section
                      Container(
                        width: isMobile ? 60 : 80,
                        height: isMobile ? 60 : 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: isMobile ? 30 : 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      
                      // Title
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isMobile ? 6 : 8),
                      
                      // Subtitle
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: isMobile ? 30 : 40),
                      
                      // Email Field
                      GlassTextField(
                        controller: _emailController,
                        labelText: 'Email or Phone',
                        prefixIcon: Icons.person_outline_rounded,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      
                      // Password Field
                      GlassTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: _obscurePassword,
                        validator: Validators.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            color: Colors.white.withOpacity(0.7),
                            size: isMobile ? 20 : 24,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      SizedBox(height: isMobile ? 24 : 32),
                      
                      // Sign In Button
                      AnimatedBuilder(
                        animation: _viewModel,
                        builder: (context, child) {
                          return AnimatedButton(
                            text: 'Sign In',
                            onPressed: _viewModel.isLoading ? null : _handleSignIn,
                            isLoading: _viewModel.isLoading,
                            isPrimary: true,
                            height: isMobile ? 48 : 56,
                          );
                        },
                      ),
                      SizedBox(height: isMobile ? 16 : 20),
                      
                      // Create Account Button
                      AnimatedButton(
                        text: 'Create New Account',
                        onPressed: _handleCreateAccount,
                        isPrimary: false,
                        height: isMobile ? 48 : 56,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      final success = await _viewModel.login(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Welcome back!' : _viewModel.errorMessage ?? 'Login failed'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  void _handleCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }
}