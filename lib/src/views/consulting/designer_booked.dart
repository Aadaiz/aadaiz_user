import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignerBooked extends StatelessWidget {
  const DesignerBooked({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/success_mark.svg'
              ),
              SizedBox(
                height: screenHeight * 0.033
              ),
              Center(
                child: Text(
                    'Your Meeting has been scheduled\nsuccessfully.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.00.sp,
                        color: AppColor.black
                    )
                )
              )
            ]
        )
    );

  }

}