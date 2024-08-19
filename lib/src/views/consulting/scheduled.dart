import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Scheduled extends StatefulWidget {

  final double screenWidth;
  final double screenHeight;

  const Scheduled({super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<Scheduled> createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Today',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 14.00.sp,
                color: AppColor.primary
            )
        ),
        SizedBox(
          height: widget.screenHeight * 0.03
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenWidth * 0.033,
            vertical: widget.screenHeight * 0.018
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.scheduledContainerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomRight: Radius.circular(18)
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.containerShadowColor.withOpacity(0.3),
                blurRadius: 18
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                visualDensity: const VisualDensity(
                  vertical: -3
                ),
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(
                    'assets/images/consulting/designer_avatar.png',
                  width: widget.screenWidth * 0.1
                ),
                title: Row(
                  children: [
                    Text(
                        'Mr.Joe',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.00.sp,
                            color: AppColor.black
                        )
                    )
                  ]
                ),
                subtitle: Row(
                  children: [
                    Text(
                        'Fashion Designer',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 9.00.sp,
                            color: AppColor.black
                        )
                    )
                  ]
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: AppColor.customGreen,
                    borderRadius: BorderRadius.circular(33)
                  ),
                  width: widget.screenWidth * 0.22,
                  height: widget.screenHeight * 0.033,
                  alignment: Alignment.center,
                  child: Text(
                      'Scheduled ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 8.00.sp,
                          color: AppColor.black
                      )
                  )
                )
              ),
              Divider(
                color: AppColor.black.withOpacity(0.2)
              ),
              Text(
                  'Booking Information',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 10.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                height: widget.screenHeight * 0.01
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/ic_calendar.svg'
                  ),
                  SizedBox(
                    width: widget.screenWidth * 0.018
                  ),
                  Text(
                      'Mar 24, 2024',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.00.sp,
                          color: AppColor.black
                     )
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                      'assets/svg/ic_clock.svg'
                  ),
                  SizedBox(
                      width: widget.screenWidth * 0.018
                  ),
                  Text(
                      '11:00 AM',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.00.sp,
                          color: AppColor.black
                      )
                  ),
                  const Spacer()
                ]
              )
            ]
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: widget.screenWidth * 0.033
              ),
              height: widget.screenHeight * 0.07,
                width: widget.screenWidth / 2.4,
                decoration: BoxDecoration(
                    color: AppColor.scheduledContainerColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.containerShadowColor.withOpacity(0.3),
                          blurRadius: 18
                      )
                    ]
                ),
              child: Container(
                height: widget.screenHeight * 0.045,
                  alignment: Alignment.center,
                  width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.primary
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.00.sp,
                        color: AppColor.primary
                    )
                )
              )
            ),
            const Spacer(),
            SizedBox(
                height: widget.screenHeight * 0.045,
                width: widget.screenWidth / 2.4,
              child: CommonButton(
                  press: (){},
                text: 'Join Meeting'
              )
            ),
            const Spacer()
          ]
        )
      ]
    );

  }

}