import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNotification extends StatefulWidget {
  const UserNotification({super.key});

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.016
              ),
              child: Image.asset(
                  'assets/images/back.png'
              )
          ),
          title: Text(
              'Notification',
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
              height: screenHeight * 0.033
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 8.0
              ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.black.withOpacity(0.2),
                          blurRadius: 7,
                          offset: const Offset(0, 1)
                      )
                    ]
                ),
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/completed.svg'
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Success',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.00.sp,
                            color: AppColor.titleBlackColor
                        )
                    ),
                    Text(
                        '1h ago',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.00.sp,
                            color: AppColor.titleHintColor
                        )
                    )
                  ]
                ),
                subtitle: Text(
                    'Order Placed Successfully. Thank you for shopping with us.',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.00.sp,
                        color: AppColor.titleBlackColor
                    )
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 8.0
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.black.withOpacity(0.2),
                        blurRadius: 7,
                        offset: const Offset(0, 1)
                    )
                  ]
              ),
              child: ListTile(
                leading: SvgPicture.asset(
                    'assets/svg/ticket.svg'
                ),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Last Chance',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.00.sp,
                              color: AppColor.titleBlackColor
                          )
                      ),
                      Text(
                          '2h ago',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.00.sp,
                              color: AppColor.titleHintColor
                          )
                      )
                    ]
                ),
                subtitle: Text(
                    'Save Upto 50% Off On First Self Customization.',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.00.sp,
                        color: AppColor.titleBlackColor
                    )
                )
              )
            ),
            SizedBox(
                height: screenHeight * 0.033
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.022
              ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.black.withOpacity(0.2),
                          blurRadius: 7,
                          offset: const Offset(0, 1)
                      )
                    ]
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.17,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/cotton_satten.png',
                      fit: BoxFit.cover
                    )
                  ),
                  ListTile(
                    title: Text(
                        'Hey, Josh!',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 10.00.sp,
                            color: AppColor.black
                        )
                    ),
                    subtitle: Text(
                        'Get upto 20% off on select items. Hurry! Offer valid only for the next 2 hours',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.00.sp,
                            color: AppColor.hintTextColor
                        )
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.033
                    ),
                    child: Text(
                        'Shop now',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.00.sp,
                            color: AppColor.primary
                        )
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );

  }

}