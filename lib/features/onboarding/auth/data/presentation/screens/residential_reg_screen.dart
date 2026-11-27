
import 'package:flutter/material.dart';
import 'package:hire_us/core/theme/app_colors.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/login_screen.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/mobile_number_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class ResidentialRegScreen extends StatefulWidget {
  const ResidentialRegScreen({super.key});

  @override
  State<ResidentialRegScreen> createState() =>
      _ResidentialRegScreenState();
}

class _ResidentialRegScreenState
    extends State<ResidentialRegScreen> {

  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;
  bool acceptedTerms = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void register() {
    if (!formKey.currentState!.validate()) return;

    if (!acceptedTerms) {
      showDemoMessage(
        context,
        'Please accept the terms and privacy policy',
      );
      return;
    }

    // UI demo only. Backend registration is not connected yet.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MobileNumberScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      minHeight: 820,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 7),

          const Center(
            child: HireUsLogo(width: 140),
          ),

          const SizedBox(height: 20),

          const Text(
            'Create your\nAccount',
            style: TextStyle(
              fontSize: 29,
              height: 1.1,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Create an account to continue',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 12),

          Form(
            key: formKey,
            child: Column(
              children: [
                // Username
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 11),

                // Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value == null ||
                        !RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value.trim())) {
                      return 'Invalid E-mail address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 11),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 11),

                // Confirm Password
                TextFormField(
                  controller: confirmController,
                  obscureText: hideConfirm,
                  decoration: InputDecoration(
                    hintText: 'Re-enter Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirm = !hideConfirm;
                        });
                      },
                      icon: Icon(
                        hideConfirm
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords must match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Password strength progress
          LinearProgressIndicator(
            value: (passwordController.text.length / 12)
                .clamp(0.0, 1.0)
                .toDouble(),
            backgroundColor: const Color(0xFFF0F0F0),
            color: AppColors.success,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),

          const SizedBox(height: 10),

          // Terms and Conditions
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      acceptedTerms = value ?? false;
                    });
                  },
                ),
              ),

              const SizedBox(width: 6),

              const Expanded(
                child: Text(
                  'I accept the terms and privacy policy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          HireUsButton(
            text: 'Register',
            onPressed: register,
          ),

          const SizedBox(height: 12),

          const OrDivider(),

          const SizedBox(height: 12),

          SocialLoginButton(
            text: 'Continue with Google',
            isGoogle: true,
            onPressed: () {
              showDemoMessage(
                context,
                'Google sign up is not connected yet',
              );
            },
          ),

          const SizedBox(height: 8),

          SocialLoginButton(
            text: 'Continue with Facebook',
            isGoogle: false,
            onPressed: () {
              showDemoMessage(
                context,
                'Facebook sign up is not connected yet',
              );
            },
          ),

          const Spacer(),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
