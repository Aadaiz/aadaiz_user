import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfield.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> _genderList = <String>['Male', 'Female', 'Others'];
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  String? _genderError; // To store gender validation error

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                child: Form(
                  key: signUpFormKey,
                  child: Column(children: <Widget>[
                    const Gap(32),
                    Text('Hello! Register to get started',
                        style: GoogleFonts.kaiseiDecol(
                            fontSize: 30.sp,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700)),
                    const Gap(16),
                    CommonTextField(
                      textEditingController: AuthController.to.name,
                      type: TextInputType.text,
                      width: Get.width,
                      hintText: 'Username',
                      onchange: (String e) {},
                      validator: (data) {
                        if (data == null || data == '') {
                          return "Please enter the user name";
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    CommonTextField(
                      textEditingController: AuthController.to.email,
                      type: TextInputType.emailAddress,
                      width: Get.width,
                      hintText: 'Email',
                      onchange: (String e) {},
                      validator: (data) {
                        if (data == null || data == '') {
                          return "Please enter the Email Id";
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CommonTextField(
                            textEditingController: AuthController.to.mobile,
                            type: TextInputType.phone,
                            width: Get.width * 0.6,
                            hintText: 'Mobile number',
                            isMobile: true,

                            onchange: (String e) {},
                            validator: (data) {
                              if (data == null || data == '') {
                                return "Please enter the mobile number";
                              } else if (data.length != 10) {
                                return "Mobile number must be exactly 10 digits";
                              }
                              return null;
                            },
                          ),
                          CommonTextField(
                            textEditingController: AuthController.to.age,
                            type: TextInputType.phone,
                            width: Get.width * 0.28,
                            hintText: 'Age',
                            onchange: (String e) {},
                            validator: (data) {
                              if (data == null || data == '') {
                                return "Please enter the Age";
                              }
                              return null;
                            },
                          ),
                        ]),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: _genderList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: _genderText(_genderList[index]));
                                })),
                        // Display gender error message if any
                        if (_genderError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 12),
                            child: Text(
                              _genderError!,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(24),
                    Obx(
                          () => CommonButton(
                          text: 'Register',
                          borderRadius: 0.0,
                          loading: AuthController.to.signUpLoading.value,
                          press: () {
                            setState(() {
                              _genderError = AuthController.to.genderValue.value.isEmpty
                                  ? "Please choose gender"
                                  : null;
                            });
                            if (signUpFormKey.currentState!.validate() && _genderError == null) {
                              AuthController.to.signUp();
                            }
                          }),
                    ),
                    const Gap(32),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              color: AppColor.lightGreyColor,
                              width: Get.width * 0.35,
                              height: 1),
                          Text('Or',
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              color: AppColor.lightGreyColor,
                              width: Get.width * 0.35,
                              height: 1)
                        ]),
                    const Gap(32),
                    Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.transparent),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/dashboard/google.png',
                                    height: Get.width * 0.05,
                                  ),
                                  const Gap(16),
                                  Text('Continue With Google',
                                      style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: AppColor.primary,
                                              fontWeight: FontWeight.w500)))
                                ]))),
                    const Gap(48),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, RoutesName.loginActivity),
                      child: Text('Already have an account? Login Now',
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w500))),
                    )
                  ]),
                ))));
  }

  Widget _genderText(String text) {
    return InkWell(
        onTap: () {
          setState(() {
            AuthController.to.genderValue.value = text;
            _genderError = null; // Clear error when gender is selected
          });
        },
        child: Container(
            height: 60,
            width: 123,
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(text,
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  fontSize: 10.0.sp,
                                  color: AppColor.greyTitleColor,
                                  fontWeight: FontWeight.w400))),
                      Radio<String>(
                          value: text,
                          activeColor: AppColor.primary,
                          groupValue: AuthController.to.genderValue.value,
                          onChanged: (String? value) {
                            setState(() {
                              AuthController.to.genderValue.value = value!;
                              _genderError = null; // Clear error on selection
                            });
                          })
                    ]),
              ],
            )));
  }
}