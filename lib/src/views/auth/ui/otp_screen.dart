import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.mobile, this.isLogin = true});
  final dynamic mobile;
  final dynamic isLogin;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _otpController; // Local controller

  @override
  void initState() {
    super.initState();
    // Initialize local controller and sync with AuthController
    _otpController = TextEditingController(
      text: AuthController.to.otp.value.text,
    );
    AuthController.to.verifyLoading(false);
  }

  @override
  void dispose() {
    // Dispose of the local controller
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
            child: Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          AuthController.to.otp.text = _otpController.text;
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.greyTitleColor),
                            color: Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 25,
                                weight: 25,
                                color: AppColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  Text(
                    'Verify Phone Number',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(16),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Please enter the 6 digit code sent to ",
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '+91 ${AuthController.to.mobile.text} ',
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                fontSize: 12.00,
                                color: AppColor.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "through SMS",
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: PinCodeTextField(
                      controller: _otpController, // Use local controller
                      appContext: context,
                      textStyle: GoogleFonts.jost(
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      pastedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 10.0.hp,
                        fieldWidth: 10.0.wp,
                        activeColor: AppColor.primary,
                        selectedFillColor: AppColor.primary,
                        selectedColor: AppColor.primary,
                        inactiveColor: AppColor.primary,
                        inactiveFillColor: Colors.transparent,
                        activeFillColor: Colors.transparent,
                      ),
                      cursorColor: AppColor.primary,
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        // Sync with AuthController
                        AuthController.to.otp.text = value;
                      },
                      onCompleted: (value) {
                        // Sync with AuthController
                        AuthController.to.otp.text = value;
                      },
                    ),
                  ),
                  const Gap(16),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: InkWell(
                      onTap: () {
                        widget.isLogin
                            ? AuthController.to.verifyOtpLogin()
                            : AuthController.to.verifyOtp(context);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Didn’t receive a code?  ",
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontSize: 15.00,
                                  color: Color(0xff999999),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'Resend otp',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                  fontSize: 15.00,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(24),
                  CommonButton(
                    press: () {
                      if (widget.isLogin) {
                        AuthController.to.verifyOtpLogin();
                      } else {
                        AuthController.to.verifyOtp(context);
                      }
                    },
                    text: 'Verify number',
                    borderRadius: 0.0,
                    loading: AuthController.to.verifyLoading.value,
                  ),
                  const Gap(32),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "By continuing you’re indicating that you accept our  ",
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of Use ',
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "and our ",
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                fontSize: 12.00,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                color: Color(0xff999999),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
