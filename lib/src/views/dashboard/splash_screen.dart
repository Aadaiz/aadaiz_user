import 'dart:async';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:aadaiz_customer_crm/src/views/auth/controller/auth_controller.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 2), (){
      AuthController.to.checkLoginStatus();
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Image.asset(
          'assets/dashboard/aadaiz.png',
          height: Get.height * 0.7,
          width: Get.width * 0.5
        )
      )
    );

  }

}