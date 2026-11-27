
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_colors.dart';

// Common layout for onboarding screens
class OnboardingPage extends StatelessWidget {
  final Widget child;
  final double minHeight;

  const OnboardingPage({
    super.key,
    required this.child,
    this.minHeight = 690,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: math.max(
                    constraints.maxHeight,
                    minHeight,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Hire Us logo widget
class HireUsLogo extends StatelessWidget {
  final double width;

  const HireUsLogo({
    super.key,
    this.width = 110,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/hire_us_logo.png',
      width: width,
      fit: BoxFit.contain,
    );
  }
}

// Common blue button
class HireUsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const HireUsButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

// Google and Facebook login buttons
class SocialLoginButton extends StatelessWidget {
  final String text;
  final bool isGoogle;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.isGoogle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 43,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          side: const BorderSide(
            color: Color(0xFFE8EBF1),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isGoogle
                  ? 'assets/icons/google.png'
                  : 'assets/icons/facebook.png',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 10),

            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Divider with Or text
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFE0E4EA),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Or',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),

        Expanded(
          child: Divider(
            color: Color(0xFFE0E4EA),
          ),
        ),
      ],
    );
  }
}

// Powered by text
class PoweredByText extends StatelessWidget {
  const PoweredByText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Powered by Trainco (PVT) LTD',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color(0xFF737C8C),
        ),
      ),
    );
  }
}

// Show a simple message
void showDemoMessage(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}
