import 'package:aadaiz_customer_crm/src/res/components/comming_soon.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/profile/support/technical_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return ComingSoonOverlay(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: InkWell(
              onTap: ()=> Get.back(),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.016
                  ),
                  child: Image.asset(
                      'assets/images/back.png'
                  )
              ),
            ),
            title: Text(
                'Help Center',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black
                )
            ),
            elevation: 2,
            centerTitle: true,
            shadowColor: AppColor.black,
            forceMaterialTransparency: false
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.055
          ),
          child: Column(
            children: [
              SizedBox(
                  height: screenHeight * 0.03
              ),
              CircleAvatar(
                radius: 33,
                backgroundColor: AppColor.circleBgColor,
                child: SvgPicture.asset(
                    'assets/svg/help.svg'
                )
              ),
              SizedBox(
                height: screenHeight * 0.03
              ),
              Text(
                  'Hello, How Can We\nHelp You?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.066
              ),
              Container(
                color: AppColor.helpContainerColor,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.013
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){
      
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => const TechnicalSupport()
                            )
                        );
      
                      },
                      visualDensity: const VisualDensity(
                        vertical: -4
                      ),
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svg/ic_support.svg'
                      ),
                      title: Text(
                          'Technical Support',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.00.sp,
                              color: AppColor.black
                          )
                      ),
                        trailing: Icon(
                            Icons.chevron_right_sharp,
                          size: screenHeight * 0.045
                        )
                    ),
                    const Divider(
                        color: AppColor.helpDividerColor
                    ),
                    Text(
                        '''Select If You're Facing A Problem With Purchasing Account Or App Bug.''',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.helpTextColor
                        )
                    )
                  ]
                )
              )
            ]
          )
        )
      ),
    );

  }

}