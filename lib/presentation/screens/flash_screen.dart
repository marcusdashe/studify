import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/studify_colors.dart';
import '../../core/constants/studify_image_paths.dart';
import '../../core/constants/text_resources.dart';
import 'file_management_screen.dart';


class FlashScreen extends StatefulWidget {
  static const routeName = '/flash-screen';

  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeInAnimation;


  @override
  void initState() {
    super.initState();

    // Main logo animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Pulse animation controller for background effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Logo size animation
    _sizeAnimation = Tween<double>(begin: 80.0, end: 140.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Logo opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    // Pulse animation for glow effect
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Fade in animation for bottom text
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _animationController.forward();

    await Future.delayed(const Duration(milliseconds: 2500));

    Navigator.of(context).pushReplacementNamed(FileManagementScreen.routeName);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: StudifyColors.primary.withOpacity(0.5),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildBackground(size),
              _buildAnimatedLogo(),
              _buildPoweredByFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackground(Size size) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            StudifyImagePaths.bgPath,
            fit: BoxFit.cover,
          ),
        ),
        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  StudifyColors.background.withOpacity(0.95),
                  StudifyColors.background,
                  StudifyColors.background.withOpacity(0.95),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        // Animated pulse circles in background
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Center(
              child: Container(
                width: 200 * _pulseAnimation.value,
                height: 200 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: StudifyColors.accent.withOpacity(0.05),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Center(
              child: Container(
                width: 150 * _pulseAnimation.value,
                height: 150 * _pulseAnimation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: StudifyColors.primary.withOpacity(0.03),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with glow effect
            Container(
              width: _sizeAnimation.value,
              height: _sizeAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: StudifyColors.primary.withOpacity(
                      0.3 * _opacityAnimation.value,
                    ),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                  BoxShadow(
                    color: StudifyColors.primaryLight.withOpacity(
                      0.2 * _opacityAnimation.value,
                    ),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Image.asset(
                  StudifyImagePaths.logoPath,
                  width: _sizeAnimation.value,
                  height: _sizeAnimation.value,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Optional: Add app name or tagline
            FadeTransition(
              opacity: _fadeInAnimation,
              child: const Text(
                StudifyTextResources.tagFlashSreen,
                style: TextStyle(
                  color: StudifyColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPoweredByFooter() {
    return Positioned(
      bottom: 40,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeInAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      StudifyImagePaths.buildprizeLogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Powered by BuildPrize",
                    style: TextStyle(
                      fontSize: 12,
                      color: StudifyColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}