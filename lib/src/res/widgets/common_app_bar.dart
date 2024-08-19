import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    return AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
              child: Image.asset('assets/images/back.png')),
        ),
        title: Text(title,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14.00.sp,
                color: AppColor.black)),
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColor.black,
        forceMaterialTransparency: false);
  }
}
