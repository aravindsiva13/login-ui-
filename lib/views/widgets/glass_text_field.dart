import 'package:flutter/material.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 480;
    final isTablet = screenWidth > 480 && screenWidth <= 768;
    
    // Responsive font sizes
    final labelFontSize = isMobile ? 14.0 : isTablet ? 15.0 : 16.0;
    final inputFontSize = isMobile ? 15.0 : isTablet ? 16.0 : 16.0;
    final floatingLabelFontSize = isMobile ? 12.0 : isTablet ? 13.0 : 14.0;
    
    // Responsive padding
    final horizontalPadding = isMobile ? 12.0 : isTablet ? 14.0 : 16.0;
    final verticalPadding = isMobile ? 16.0 : isTablet ? 18.0 : 20.0;
    
    // Responsive border radius
    final borderRadius = isMobile ? 10.0 : 12.0;
    
    // Responsive icon size
    final iconSize = isMobile ? 20.0 : 24.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(borderRadius),
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
        style: TextStyle(
          color: Colors.white,
          fontSize: inputFontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: labelFontSize,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: floatingLabelFontSize,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white.withOpacity(0.7),
            size: iconSize,
          ),
          suffixIcon: suffixIcon != null 
              ? IconTheme(
                  data: IconThemeData(size: iconSize),
                  child: suffixIcon!,
                )
              : null,
          fillColor: Colors.transparent,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
        ),
        validator: validator,
      ),
    );
  }
}