import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:aadaiz/src/views/home/customize_widget.dart';
import 'package:aadaiz/src/views/home/material_widget.dart';
import 'package:aadaiz/src/views/home/top_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    HomeController.to.getGender();
    HomeController.to.getBannerList();
    // Calculate the offset to center the middle item
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body:  SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(2.0.hp),
                const TopWidget(),
                Gap(3.0.hp),
                Image.asset(
                  'assets/images/fc.png',
                  fit:BoxFit.fill,
                  //  height: 10.0.hp,
                  width: Get.width,
                ),
                Gap(3.0.hp),
                const CustomizeWidget(),
                Gap(3.0.hp),
                Image.asset(
                  'assets/images/mb.png',
                  fit:BoxFit.fill,
                  //  height: 10.0.hp,
                  width: Get.width,
                ),
                Gap(3.0.hp),
               const FabricWidget(),
                Gap(3.0.hp),
              ],
            ),
          )),
    );
  }
}
