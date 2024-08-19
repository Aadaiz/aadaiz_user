import 'dart:async';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/routes/routes_name.dart';
import 'package:aadaiz/src/views/auth/controller/auth_controller.dart';
import 'package:aadaiz/src/views/dashboard/dashboard.dart';
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
      AuthController.to.checkLoginStatus(context);
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
          child: Center(
            child: Image.asset(
              'assets/dashboard/aadaiz.png',
              height: Get.height * 0.7,
              width: Get.width * 0.5
            )
          )
      )
    );

  }

}