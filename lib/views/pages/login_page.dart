
import 'package:flutter/material.dart';
import '../../viewmodels/login_viewmodel.dart';
import '../../utils/validators.dart';

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Simple responsive logic
              final isSmall = constraints.maxWidth < 600;
              final padding = isSmall ? 20.0 : 40.0;
              final maxWidth = isSmall ? constraints.maxWidth * 0.9 : 400.0;
              
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: Container(
                    width: maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    padding: EdgeInsets.all(isSmall ? 24 : 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Profile Section
                          Container(
                            width: isSmall ? 60 : 80,
                            height: isSmall ? 60 : 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: isSmall ? 30 : 40,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: isSmall ? 16 : 20),
                          
                          // Title
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: isSmall ? 24 : 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: isSmall ? 6 : 8),
                          
                          // Subtitle
                          Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: isSmall ? 14 : 16,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: isSmall ? 30 : 40),
                          
                          // Email Field
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email or Phone',
                            icon: Icons.person_outline_rounded,
                            validator: Validators.validateEmail,
                            isSmall: isSmall,
                          ),
                          SizedBox(height: isSmall ? 16 : 20),
                          
                          // Password Field
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline_rounded,
                            obscureText: _obscurePassword,
                            validator: Validators.validatePassword,
                            isSmall: isSmall,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: Colors.white.withOpacity(0.7),
                                size: isSmall ? 20 : 24,
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          SizedBox(height: isSmall ? 24 : 32),
                          
                          // Sign In Button
                          AnimatedBuilder(
                            animation: _viewModel,
                            builder: (context, child) {
                              return _buildButton(
                                text: 'Sign In',
                                onPressed: _viewModel.isLoading ? null : _handleSignIn,
                                isPrimary: true,
                                isLoading: _viewModel.isLoading,
                                isSmall: isSmall,
                              );
                            },
                          ),
                          SizedBox(height: isSmall ? 16 : 20),
                          
                          // Create Account Button
                          _buildButton(
                            text: 'Create New Account',
                            onPressed: _handleCreateAccount,
                            isPrimary: false,
                            isSmall: isSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    required bool isSmall,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(
          color: Colors.white,
          fontSize: isSmall ? 14 : 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: isSmall ? 14 : 16,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
            size: isSmall ? 20 : 24,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 16,
            vertical: isSmall ? 16 : 20,
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isPrimary,
    bool isLoading = false,
    required bool isSmall,
  }) {
    return SizedBox(
      width: double.infinity,
      height: isSmall ? 48 : 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.white : Colors.transparent,
          foregroundColor: isPrimary ? Colors.black : Colors.white,
          elevation: isPrimary ? 2 : 0,
          side: isPrimary ? null : BorderSide(color: Colors.white.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: isSmall ? 20 : 24,
                height: isSmall ? 20 : 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(isPrimary ? Colors.black : Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: isSmall ? 16 : 18,
                  fontWeight: FontWeight.w600,
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
    // Navigate to create account page
  }
}