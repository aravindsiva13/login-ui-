import 'package:flutter/material.dart';
import 'dart:ui';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Responsive sizing
    final isMobile = screenWidth <= 480;
    final isTablet = screenWidth > 480 && screenWidth <= 768;
    final isDesktop = screenWidth > 768;
    
    // Dynamic container width
    double containerWidth;
    if (isMobile) {
      containerWidth = screenWidth * (isLandscape ? 0.6 : 0.9);
    } else if (isTablet) {
      containerWidth = isLandscape ? screenWidth * 0.5 : screenWidth * 0.7;
    } else {
      containerWidth = 450;
    }

    // Responsive border radius
    final responsiveBorderRadius = borderRadius ?? (isMobile ? 16.0 : isTablet ? 20.0 : 24.0);

    // Responsive padding
    final responsivePadding = padding ?? EdgeInsets.all(
      isMobile ? 20.0 : isTablet ? 28.0 : 32.0,
    );

    return Container(
      width: width ?? containerWidth,
      height: height,
      margin: margin,
      constraints: BoxConstraints(
        maxWidth: isDesktop ? 500 : double.infinity,
        minHeight: isMobile ? (isLandscape ? 350 : 400) : 450,
        maxHeight: isLandscape && isMobile ? screenHeight * 0.85 : double.infinity,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsiveBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(responsiveBorderRadius),
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
            padding: responsivePadding,
            child: child,
          ),
        ),
      ),
    );
  }
}