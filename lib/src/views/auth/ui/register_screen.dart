import 'dart:developer';

import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/res/components/common_textfield.dart';
import 'package:aadaiz/src/res/components/form_validation.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
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
                            fontSize: 30,
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
                        } else {
                          return null;
                        }
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
                        } else {
                          return null;
                        }
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
                              } else {
                                return null;
                              }
                            },
                          ),
                          CommonTextField(
                            textEditingController:AuthController.to.age,
                            type: TextInputType.phone,
                            width: Get.width * 0.2,
                            hintText: 'Age',
                            onchange: (String e) {},
                            validator: (data) {
                              if (data == null || data == '') {
                                return "Please enter the Age";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ]),
                    const Gap(16),
                    SizedBox(
                        height: 60,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _genderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: _genderText(_genderList[index]));
                            })),
                    const Gap(24),
                    Obx(
                      () => CommonButton(
                          text: 'Register',
                          borderRadius: 0.0,
                          loading: AuthController.to.signUpLoading.value,
                          press: () {
                            if (signUpFormKey.currentState!.validate()) {
                              AuthController.to.signUp();
                            }
                          }),
                    ),
                    const Gap(32),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              color: AppColor.greyTitleColor,
                              width: Get.width * 0.35,
                              height: 1),
                          Text('Or',
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w400))),
                          Container(
                              color: AppColor.greyTitleColor,
                              width: Get.width * 0.35,
                              height: 1)
                        ]),
                    const Gap(32),
                    Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.greyTitleColor),
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
          });
        },
        child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
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
                        });
                      })
                ])));
  }
}
