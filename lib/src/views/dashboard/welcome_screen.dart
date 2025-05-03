import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: AppColor.backGroundColor,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32
                ),
                child: Stack(
                    children: <Widget>[
                      Image.asset('assets/dashboard/aadai_wel.png',
                          height: Get.height * 0.8,
                          width: Get.width
                      ),
                      Text(
                          'Create your unique style with our customizable dresses !',
                          style: GoogleFonts.kaiseiDecol(
                              fontSize: 21,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w700
                          )
                      ),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              height: 150,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: <Color>[
                                        AppColor.backGroundColor,
                                        AppColor.backGroundColor,
                                        AppColor.backGroundColor,
                                        AppColor.backGroundColor,
                                        AppColor.backGroundColor.withOpacity(0.8),
                                        AppColor.backGroundColor.withOpacity(0.3),
                                        AppColor.backGroundColor.withOpacity(0.03)
                                      ]
                                  )
                              )
                          )
                      )
                    ]
                )
            )
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8),
            child:  CommonButton(
                text: 'Get Started',
                press: ()=> Navigator.pushNamed(context, RoutesName.registerActivity)
            )
        )
    );

  }

}