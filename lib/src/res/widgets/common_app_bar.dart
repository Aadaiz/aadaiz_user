import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key, required this.title, this.isCheck = false, this.isLoading,  this.onTap});
  final String title;
  final bool? isCheck;
  final bool? isLoading;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    return AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
              child: Image.asset('assets/images/back.png', height: 15.0.hp, width: 5.0.wp,)),
        ),
        title: Text(title,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14.00.sp,
                color: AppColor.black)),
        actions: [
          isCheck == true
              ? Padding(
                  padding: EdgeInsets.only(right: screenHeight * 0.016),
                  child: isLoading==true?
                  SizedBox(
                    height: 03.00.hp,
                    width: 5.00.hp,
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: AppColor.primary,
                      size: 5.00.hp,
                    ),
                  )
                  :InkWell(
                    onTap: onTap,
                    child: Icon(Icons.check,
                      size: screenHeight * 0.035,
                      color: AppColor.primary,
                    ),
                  ),
                  )
              : const SizedBox()
        ],
        centerTitle: true,
        shadowColor: AppColor.black,
        forceMaterialTransparency: false);
  }
}
