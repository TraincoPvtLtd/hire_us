
import 'package:flutter/material.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/residential_reg_screen.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/mobile_number_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (!formKey.currentState!.validate()) return;

    // UI demo only. Real login must call the backend.
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
      minHeight: 720,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),

          const Center(
            child: HireUsLogo(width: 142),
          ),

          const SizedBox(height: 58),

          const Text(
            'Sign in to your\nAccount',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 13),

          const Text(
            'Enter your email and password to log in',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 36),

          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'example@gmail.com',
                  ),
                  validator: (value) {
                    if (value == null ||
                        !RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: passwordController,
                  obscureText: hidePassword,
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
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
              ),

              const SizedBox(width: 6),

              const Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: () {
                  showDemoMessage(
                    context,
                    'Forgot password is not connected yet',
                  );
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          HireUsButton(
            text: 'Log In',
            onPressed: login,
          ),

          const SizedBox(height: 15),

          const OrDivider(),

          const SizedBox(height: 15),

          SocialLoginButton(
            text: 'Continue with Google',
            isGoogle: true,
            onPressed: () {
              showDemoMessage(
                context,
                'Google sign in is not connected yet',
              );
            },
          ),

          const SizedBox(height: 10),

          SocialLoginButton(
            text: 'Continue with Facebook',
            isGoogle: false,
            onPressed: () {
              showDemoMessage(
                context,
                'Facebook sign in is not connected yet',
              );
            },
          ),

          const Spacer(),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const ResidentialRegScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
