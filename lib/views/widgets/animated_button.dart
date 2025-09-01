// lib/views/widgets/animated_button.dart
import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final double? height;

  const AnimatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 480;
    final isTablet = screenWidth > 480 && screenWidth <= 768;
    
    // Responsive heights
    final buttonHeight = height ?? (isMobile ? 48.0 : isTablet ? 52.0 : 56.0);
    
    // Responsive font sizes
    final fontSize = isPrimary 
        ? (isMobile ? 16.0 : isTablet ? 17.0 : 18.0)
        : (isMobile ? 14.0 : isTablet ? 15.0 : 16.0);
    
    // Responsive border radius
    final borderRadius = isMobile ? 10.0 : 12.0;
    
    // Responsive loading indicator size
    final loadingSize = isMobile ? 20.0 : 24.0;

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: Container(
        decoration: BoxDecoration(
          color: isPrimary ? Colors.white : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(borderRadius),
          border: isPrimary
              ? null
              : Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
          boxShadow: isPrimary
              ? [
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
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: isLoading ? null : onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.0 : 20.0,
                vertical: isMobile ? 8.0 : 12.0,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: loadingSize,
                        height: loadingSize,
                        child: CircularProgressIndicator(
                          strokeWidth: isMobile ? 2.0 : 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isPrimary ? Colors.black : Colors.white,
                          ),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: TextStyle(
                            color: isPrimary ? Colors.black : Colors.white,
                            fontSize: fontSize,
                            fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                            letterSpacing: isPrimary ? 0.5 : 0.3,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}