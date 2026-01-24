import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/profile/user_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     HomeController.to.getGender();
  //     HomeController.to.getBannerList();
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,


              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(22, 62, 22, 20),
                  color: AppColor.primary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/dashboard/aadaiz.png',
                        fit: BoxFit.fill,
                        //  height: 10.0.hp,
                        width: 25.0.wp,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const UserNotification());
                            },
                            child: Image.asset(
                              'assets/images/notification.png',
                              fit: BoxFit.fill,
                              color: AppColor.white,
                              //  height: 10.0.hp,
                              width: 5.0.wp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To',
                      style: GoogleFonts.dmSans(
                        fontSize: 20.sp,
                        height: 1,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'aadaiz',
                      style: GoogleFonts.kaiseiDecol(
                        height: 1,
                        fontSize: 45.sp,
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'The future of tailoring and fashion designing'.toUpperCase(),
                        style: GoogleFonts.dmSans(
                          fontSize: 13.sp,
                          color: AppColor.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Image.asset('assets/images/aadaiz_home.png'),
                    const SizedBox(height: 10),
                    Image.asset('assets/images/home_rect.png'),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 7,right: 7,bottom: 10),
                      child: Image.asset('assets/images/home_last.png'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
