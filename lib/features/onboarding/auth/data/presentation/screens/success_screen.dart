import 'package:flutter/material.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/login_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const HireUsLogo(width: 105),
          const Spacer(flex: 2),
          Center(
            child: Lottie.asset(
              'assets/animations/success.json',
              height: 245,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Success !',
              style: TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'Congratulation! You have been successfully\nauthenticated',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const Spacer(flex: 3),
          HireUsButton(
            text: 'Finish',
            onPressed: () {
              // Home screen is not implemented yet; return to the login demo.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
          const SizedBox(height: 57),
        ],
      ),
    );
  }
}
