import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_colors.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/login_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:lottie/lottie.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          const HireUsLogo(width: 105),
          const Spacer(flex: 2),
          Center(
            child: Lottie.asset(
              'assets/animations/choose type.json',
              height: 205,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text(
              'Choose type',
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
          ),
          const SizedBox(height: 17),
          Center(
            child: Container(
              width: 235,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFA8C6E6),
                border: Border.all(color: const Color(0xFF27354E)),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 83,
                    child: ElevatedButton(
                      onPressed: () => openLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text('Hire', style: TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 83,
                    child: ElevatedButton(
                      onPressed: () => openLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text('Worker', style: TextStyle(fontSize: 26)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
          const PoweredByText(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
