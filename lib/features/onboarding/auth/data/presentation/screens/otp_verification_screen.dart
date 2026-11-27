import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_us/core/theme/app_colors.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/success_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:lottie/lottie.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final fields = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());
  bool isMovingNext = false;

  @override
  void dispose() {
    for (final controller in fields) {
      controller.dispose();
    }
    for (final node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    final code = fields.map((field) => field.text).join();
    if (code.length == 4 && !isMovingNext) {
      isMovingNext = true;
      FocusScope.of(context).unfocus();
      // This is a design demo, not real SMS/OTP verification.
      Future.delayed(const Duration(milliseconds: 350), () {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuccessScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const HireUsLogo(width: 105),
          const SizedBox(height: 36),
          Center(
            child: Lottie.asset(
              'assets/animations/otp verification.json',
              height: 205,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Enter Code',
              style: TextStyle(fontSize: 27, color: Colors.black),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'Please type OTP verification code sent to\n${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 42),
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index == 3 ? 0 : 12),
                  child: TextField(
                    controller: fields[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontSize: 44,
                      color: index == 3 ? AppColors.error : AppColors.success,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      border: const UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: index == 3 ? AppColors.error : AppColors.success,
                          width: 4,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: index == 3 ? AppColors.error : AppColors.success,
                          width: 4,
                        ),
                      ),
                    ),
                    onChanged: (value) => onCodeChanged(index, value),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text("If you didn't receive a code !", style: TextStyle(fontSize: 13)),
                TextButton(
                  onPressed: () => showDemoMessage(context, 'Resend OTP is not connected yet'),
                  child: const Text('Resend', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
