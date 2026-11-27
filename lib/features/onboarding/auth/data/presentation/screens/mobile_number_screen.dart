
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_us/features/onboarding/auth/data/presentation/screens/otp_verification_screen.dart';
import 'package:hire_us/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:lottie/lottie.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final phoneController = TextEditingController();

  String selectedFlag = '🇱🇰';
  String selectedPhoneCode = '94';
  String? errorText;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void chooseCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedFlag = country.flagEmoji;
          selectedPhoneCode = country.phoneCode;
          errorText = null;
        });
      },
    );
  }

  void continueToOtp() {
    final phone = phoneController.text.trim();

    // Basic validation for the UI
    if (!RegExp(r'^[0-9]{6,15}$').hasMatch(phone)) {
      setState(() {
        errorText = 'Please enter a valid mobile number';
      });
      return;
    }

    setState(() {
      errorText = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: '+$selectedPhoneCode$phone',
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
          const SizedBox(height: 28),

          // Original Hire Us logo
          const HireUsLogo(width: 105),

          const Spacer(flex: 2),

          // Original Figma illustration
          Center(
            child: Lottie.asset(
              'assets/animations/enter mobile.json',
              height: 225,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 12),

          // Screen title
          const Center(
            child: Text(
              'Enter your mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 9),

          const Center(
            child: Text(
              "We'll send you a OTP verification code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 36),

          const Text(
            'Mobile Number',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 7),

          // Error message
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),

          // Country picker and phone number input
          Row(
            children: [
              InkWell(
                onTap: chooseCountry,
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  width: 91,
                  height: 53,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFD9D9E1),
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedFlag,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(width: 3),

                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '+$selectedPhoneCode',
                            style: const TextStyle(fontSize: 13),
                            maxLines: 1,
                          ),
                        ),
                      ),

                      const SizedBox(width: 2),

                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: SizedBox(
                  height: 53,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(15),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter your number',
                      hintStyle: const TextStyle(fontSize: 13),
                      contentPadding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9E1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFFD9D9E1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Color(0xFF2E6DB4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(flex: 3),

          // Original Continue button
          HireUsButton(
            text: 'Continue',
            icon: Icons.arrow_forward,
            onPressed: continueToOtp,
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
