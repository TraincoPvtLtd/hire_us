import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_theme.dart';
import 'package:hire_us/features/onboarding/presentation/screens/welcome_screen.dart';

void main(){
  runApp(const HireUsApp());
}

class HireUsApp extends StatelessWidget{

  const HireUsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HireUs',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.LightTheme,
      home: const WelcomeScreen(),
    );
  }

}