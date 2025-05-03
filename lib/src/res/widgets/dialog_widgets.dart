import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogWidgets{

  static Widget paymentFailed({required BuildContext context, required double screenWidth, required double screenHeight}){

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
      ),
      child: SizedBox(
        height: screenHeight / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: ()=> Navigator.pop(context),
                child: SvgPicture.asset(
                    'assets/svg/ic_close.svg',
                    width: screenWidth * 0.1
                )
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1
                ),
                titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                      'Payment Error',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.kaiseiDecol(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.00.sp,
                          color: AppColor.primary
                      )
                  ),
                  subtitle: Text(
                      '\nPurchase failed. please try different card Or check your current card information ',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 9.00.sp,
                          color: AppColor.black
                      )
                  )
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.01
                  ),
                  height: screenHeight * 0.055,
                  color: AppColor.primary,
                  width: screenWidth / 2.2,
                  alignment: Alignment.center,
                  child: Text(
                      'Try Again',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.00.sp,
                          color: Colors.white
                      )
                  )
              )
            ]
        )
      )
    );

  }

}