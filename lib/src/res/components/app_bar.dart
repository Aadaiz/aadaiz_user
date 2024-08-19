import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomizeAppBar extends StatelessWidget {
  const CustomizeAppBar({super.key, this.text});
final dynamic text;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                'assets/images/back.png',
                //   fit: BoxFit.contain,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          '$text',
          style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  fontSize: 18.00.sp,
                  color: AppColor.primary,
                  fontWeight: FontWeight.w400
              )
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
