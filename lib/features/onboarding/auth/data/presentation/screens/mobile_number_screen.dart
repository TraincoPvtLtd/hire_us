
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
    final allCountries = CountryService().getAll();
    List<Country> filteredCountries = List.from(allCountries);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFD9D9E1)),
                        ),
                      ),
                      onChanged: (query) {
                        final q = query.trim().toLowerCase();
                        setModalState(() {
                          filteredCountries = allCountries.where((c) {
                            return c.name.toLowerCase().contains(q) ||
                                c.phoneCode.contains(q);
                          }).toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedFlag = country.flagEmoji;
                              selectedPhoneCode = country.phoneCode;
                              errorText = null;
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  country.flagEmoji,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const SizedBox(width: 14),
                                
                                SizedBox(
                                  width: 68,
                                  child: Text(
                                    '+${country.phoneCode}',
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF1A1F36),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF1A1F36),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
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
