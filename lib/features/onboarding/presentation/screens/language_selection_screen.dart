import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_colors.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/role_selection_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:lottie/lottie.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'Sinhala';

  Widget languageOption(String text, String symbol) {
    final isSelected = selectedLanguage == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = text;
        });
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                symbol,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 24),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
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
              'assets/animations/choose language.json',
              height: 205,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Choose the language',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          languageOption('Sinhala', 'A'),
          languageOption('தமிழ்', 'அ'),
          languageOption('English', 'A'),
          const SizedBox(height: 10),
          HireUsButton(
            text: 'Keep Going',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoleSelectionScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const PoweredByText(),
          const Spacer(),
        ],
      ),
    );
  }
}
