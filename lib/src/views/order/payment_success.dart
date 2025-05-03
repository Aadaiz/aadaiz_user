import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.05
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text(
                  'Success!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kaiseiDecol(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.00.sp,
                      color: AppColor.black
                  )
              ),
              subtitle: Text(
                  'Your order will be delivered soon.\nThank you for choosing our app!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black
                  )
              )
            ),
            Container(
              width: screenWidth / 2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(28)
              ),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.018,
                horizontal: screenWidth * 0.05
              ),
              child: Text(
                'Continue shopping',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.00.sp,
                  color: Colors.white
                )
              )
            ),
            Image.asset(
              'assets/images/success_women.png',
              height: screenHeight / 1.6,
              width: screenWidth
            )
          ]
        )
      )
    );

  }

}