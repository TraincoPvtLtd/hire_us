import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_colors.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/get_started_button.dart';
import 'package:lottie/lottie.dart';
import 'package:hire_us/features/onboarding/presentation/screens/language_selection_screen.dart';

class WelcomeScreen extends StatelessWidget{

  const WelcomeScreen({super.key});
  void _onGetStarted(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.surface,
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const SizedBox(height: 16),
             Padding(
               padding: const EdgeInsets.only(left: 4.0),
               child: Image.asset(
                 'assets/images/hire_us_logo.png',
                 height: 40,
                 fit: BoxFit.contain,
                 errorBuilder: (context, error, stackTrace){
                   return Row(
                     mainAxisSize: MainAxisSize.min,
                     children: const [
                       Icon(Icons.handyman_rounded,
                       color: AppColors.primaryDark, size: 28),
                       SizedBox(width: 8),
                       Text(
                         'HIRE',
                         style: TextStyle(
                           color: AppColors.primaryDark,
                           fontSize: 20,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                       Text(
                         'US',
                         style: TextStyle(
                           color: AppColors.accentDark,
                           fontSize: 20,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                     ],
                   );
                 },
               ),
             ),

             Expanded(
               child: Center(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Lottie.asset(
                     'assets/animations/welcome_animation.json',
                     width: double.infinity,
                     fit: BoxFit.contain,
                     repeat: true,
                     animate: true,
                     frameRate: FrameRate(30),
                   ),
                 ),
               ),
             ),

             GetStartedButton(
               label: 'Get Started',
               onSlideComplete: () => _onGetStarted(context),
             ),

             const SizedBox(height: 24),

             const Center(
               child: Text(
                 'Powered by Trainco (PVT) LTD',
                 style: TextStyle(
                   color: AppColors.textSecondary,
                   fontSize: 13,
                   fontWeight: FontWeight.w600,
                   letterSpacing: 0.2,
                 ),
               ),
             ),

             const SizedBox(height: 20),
           ],
         ),
       ),
     ),
   );
  }
}