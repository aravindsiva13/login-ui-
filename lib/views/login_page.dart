// import 'package:flutter/material.dart';
// import '../viewmodels/login_viewmodel.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
//   final LoginViewModel _viewModel = LoginViewModel();
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _emailHovered = false;
//   bool _passwordHovered = false;
//   bool _buttonHovered = false;
  
//   late AnimationController _borderController;
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _borderController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();
    
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
    
//     // Start the fade-in animation
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _borderController.dispose();
//     _fadeController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
    
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           // Try with your image first
//           image: DecorationImage(
//             image: AssetImage('assets/images/black_bg1.jpg'),
//             fit: BoxFit.cover,
//             onError: null, // Will fall back to color if image fails
//           ),
//           // Fallback gradient if image doesn't load
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF2D1B69),
//               Color(0xFF0F0C29),
//             ],
//           ),
//         ),
//         // Semi-transparent overlay for better text readability
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.2), // Lighter overlay to match background
//           ),
//           child: SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24),
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 400),
//                   child: Column(
//                     children: [
//                       // Animated border with static form content
//                       FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: AnimatedBuilder(
//                           animation: _borderController,
//                           builder: (context, child) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gradient: SweepGradient(
//                                   startAngle: _borderController.value * 6.28, // 2π
//                                   colors: const [
//                                     Colors.transparent,
//                                     Colors.white,
//                                     Colors.transparent,
//                                     Colors.transparent,
//                                   ],
//                                   stops: const [0.0, 0.1, 0.2, 1.0],
//                                 ),
//                               ),
//                               padding: const EdgeInsets.all(2),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.9),
//                                   borderRadius: BorderRadius.circular(18),
//                                 ),
//                                 padding: const EdgeInsets.all(24),
//                                 child: Form(
//                                   key: _formKey,
//                                   child: Column(
//                                     children: [
//                                       // Minimal profile section
//                                       Container(
//                                         width: 60,
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: Colors.grey.withOpacity(0.3),
//                                             width: 1,
//                                           ),
//                                         ),
//                                         child: const Icon(
//                                           Icons.person_outline,
//                                           size: 24,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16),
//                                       const Text(
//                                         'Welcome Back',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 32),

//                                       // Email Field with hover animation
//                                       MouseRegion(
//                                         onEnter: (_) => setState(() => _emailHovered = true),
//                                         onExit: (_) => setState(() => _emailHovered = false),
//                                         child: AnimatedContainer(
//                                           duration: const Duration(milliseconds: 200),
//                                           transform: Matrix4.identity()..scale(_emailHovered ? 1.02 : 1.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(8),
//                                               boxShadow: _emailHovered
//                                                   ? [
//                                                       BoxShadow(
//                                                         color: Colors.white.withOpacity(0.1),
//                                                         blurRadius: 8,
//                                                         spreadRadius: 1,
//                                                       ),
//                                                     ]
//                                                   : [],
//                                             ),
//                                             child: TextFormField(
//                                               controller: _emailController,
//                                               style: const TextStyle(color: Colors.white),
//                                               decoration: InputDecoration(
//                                                 labelText: 'Email or Phone',
//                                                 labelStyle: const TextStyle(color: Colors.grey),
//                                                 prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
//                                                 fillColor: Colors.transparent,
//                                                 filled: true,
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: const BorderSide(color: Colors.grey, width: 1),
//                                                 ),
//                                                 enabledBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: BorderSide(
//                                                     color: _emailHovered ? Colors.white.withOpacity(0.7) : Colors.grey,
//                                                     width: _emailHovered ? 1.5 : 1,
//                                                   ),
//                                                 ),
//                                                 focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: const BorderSide(color: Colors.white, width: 1.5),
//                                                 ),
//                                               ),
//                                               validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16),

//                                       // Password Field with hover animation
//                                       MouseRegion(
//                                         onEnter: (_) => setState(() => _passwordHovered = true),
//                                         onExit: (_) => setState(() => _passwordHovered = false),
//                                         child: AnimatedContainer(
//                                           duration: const Duration(milliseconds: 200),
//                                           transform: Matrix4.identity()..scale(_passwordHovered ? 1.02 : 1.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(8),
//                                               boxShadow: _passwordHovered
//                                                   ? [
//                                                       BoxShadow(
//                                                         color: Colors.white.withOpacity(0.1),
//                                                         blurRadius: 8,
//                                                         spreadRadius: 1,
//                                                       ),
//                                                     ]
//                                                   : [],
//                                             ),
//                                             child: TextFormField(
//                                               controller: _passwordController,
//                                               obscureText: _obscurePassword,
//                                               style: const TextStyle(color: Colors.white),
//                                               decoration: InputDecoration(
//                                                 labelText: 'Password',
//                                                 labelStyle: const TextStyle(color: Colors.grey),
//                                                 prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
//                                                 fillColor: Colors.transparent,
//                                                 filled: true,
//                                                 suffixIcon: IconButton(
//                                                   icon: Icon(
//                                                     _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                                     color: Colors.grey,
//                                                   ),
//                                                   onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                                                 ),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: const BorderSide(color: Colors.grey, width: 1),
//                                                 ),
//                                                 enabledBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: BorderSide(
//                                                     color: _passwordHovered ? Colors.white.withOpacity(0.7) : Colors.grey,
//                                                     width: _passwordHovered ? 1.5 : 1,
//                                                   ),
//                                                 ),
//                                                 focusedBorder: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.circular(8),
//                                                   borderSide: const BorderSide(color: Colors.white, width: 1.5),
//                                                 ),
//                                               ),
//                                               validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 24),

//                                       // Animated sign in button with hover
//                                       MouseRegion(
//                                         onEnter: (_) => setState(() => _buttonHovered = true),
//                                         onExit: (_) => setState(() => _buttonHovered = false),
//                                         child: SizedBox(
//                                           width: double.infinity,
//                                           height: 50,
//                                           child: AnimatedBuilder(
//                                             animation: _viewModel,
//                                             builder: (context, child) {
//                                               return TweenAnimationBuilder<double>(
//                                                 duration: const Duration(milliseconds: 200),
//                                                 tween: Tween(
//                                                   begin: 1.0,
//                                                   end: _viewModel.isLoading
//                                                       ? 0.95
//                                                       : _buttonHovered
//                                                           ? 1.05
//                                                           : 1.0,
//                                                 ),
//                                                 builder: (context, scale, child) {
//                                                   return Transform.scale(
//                                                     scale: scale,
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         borderRadius: BorderRadius.circular(8),
//                                                         boxShadow: _buttonHovered
//                                                             ? [
//                                                                 BoxShadow(
//                                                                   color: Colors.white.withOpacity(0.3),
//                                                                   blurRadius: 12,
//                                                                   spreadRadius: 2,
//                                                                   offset: const Offset(0, 4),
//                                                                 ),
//                                                               ]
//                                                             : [
//                                                                 BoxShadow(
//                                                                   color: Colors.white.withOpacity(0.1),
//                                                                   blurRadius: 8,
//                                                                   offset: const Offset(0, 2),
//                                                                 ),
//                                                               ],
//                                                       ),
//                                                       child: Material(
//                                                         color: Colors.transparent,
//                                                         child: InkWell(
//                                                           borderRadius: BorderRadius.circular(8),
//                                                           onTap: _viewModel.isLoading ? null : _handleSignIn,
//                                                           child: Center(
//                                                             child: _viewModel.isLoading
//                                                                 ? const SizedBox(
//                                                                     width: 20,
//                                                                     height: 20,
//                                                                     child: CircularProgressIndicator(
//                                                                       strokeWidth: 2,
//                                                                       color: Colors.black,
//                                                                     ),
//                                                                   )
//                                                                 : const Text(
//                                                                     'Sign In',
//                                                                     style: TextStyle(
//                                                                       color: Colors.black,
//                                                                       fontSize: 16,
//                                                                       fontWeight: FontWeight.w600,
//                                                                     ),
//                                                                   ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 16),

//                                       // Simple text button
//                                       TextButton(
//                                         onPressed: () {},
//                                         child: const Text(
//                                           'Create New Account',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _handleSignIn() async {
//     if (_formKey.currentState!.validate()) {
//       final success = await _viewModel.login(
//         _emailController.text,
//         _passwordController.text,
//       );

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(success ? 'Welcome back!' : 
//                 _viewModel.errorMessage ?? 'Login failed'),
//             backgroundColor: success ? Colors.green : Colors.red,
//           ),
//         );
//       }
//     }
//   }
// }


//2



import 'package:flutter/material.dart';
import 'dart:ui';
import '../viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final LoginViewModel _viewModel = LoginViewModel();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/black_bg1.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildGlassContainer(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: -5,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildProfileSection(),
                const SizedBox(height: 40),
                _buildEmailField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 32),
                _buildSignInButton(),
                const SizedBox(height: 20),
                _buildCreateAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.7),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return _buildGlassField(
      controller: _emailController,
      labelText: 'Email or Phone',
      prefixIcon: Icons.person_outline_rounded,
      validator: (value) => value?.isEmpty ?? true ? 'Email is required' : null,
    );
  }

  Widget _buildPasswordField() {
    return _buildGlassField(
      controller: _passwordController,
      labelText: 'Password',
      prefixIcon: Icons.lock_outline_rounded,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: Colors.white.withOpacity(0.7),
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
      validator: (value) => value?.isEmpty ?? true ? 'Password is required' : null,
    );
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white.withOpacity(0.7),
          ),
          suffixIcon: suffixIcon,
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: -2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _viewModel.isLoading ? null : _handleSignIn,
                child: Center(
                  child: _viewModel.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate to create account page
          },
          child: Container(
            width: double.infinity,
            height: 56,
            alignment: Alignment.center,
            child: const Text(
              'Create New Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
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
            content: Text(
              success ? 'Welcome back!' : _viewModel.errorMessage ?? 'Login failed',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }
}