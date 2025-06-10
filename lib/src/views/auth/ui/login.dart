import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfield.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:aadaiz_customer_crm/src/views/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/components/input_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _mobile = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
    _mobile.dispose();

  }

@override
  void initState() {
    _mobile.addListener((){
      setState(() {
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Obx(
            () => Column(
              children: <Widget>[
                const Gap(32),
                SvgPicture.asset('assets/svg/otp.svg', width: Get.width * 0.5),
                Gap(Get.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OTP Verification',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          fontSize: 24.00.sp,
                          color: AppColor.borderGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * 0.8,
                      child: Text(
                        'We will send you one-time password to you mobile number',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                            fontSize: 14.00.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(Get.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter Mobile number',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          fontSize: 14.00.sp,
                          color: AppColor.borderGrey.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                SizedBox(
                  width: Get.width * 0.8,
                  child: InputField(
                    focusNode: focusNode,
                    type: false,
                    controller: AuthController.to.loginMobile,
                    keyboardType: TextInputType.number,
                    labeltext: '',
                    validator: (data) {
                      final bool isValid = GetUtils.isPhoneNumber(
                        data.toString().trimRight(),
                      );
                      if (data == "" || data == null) {
                        return "Please enter the mobile number";
                      } else if (isValid == false) {
                        return "Please enter the valid mobile number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const Gap(24),
                CommonButton(
                  text: 'Get OTP',
                  press: () {
                    AuthController.to.login(mobile: _mobile.text);
                  },
                  loading: AuthController.to.loginLoading.value,
                  borderRadius: 0.0,
                ),
                const Gap(32),
                InkWell(
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        RoutesName.registerActivity,
                      ),
                  child: Text(
                    "Don't have an account? Signup Now",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
