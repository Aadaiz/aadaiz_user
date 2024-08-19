import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Completed extends StatefulWidget {

  final double screenWidth;
  final double screenHeight;

  const Completed({super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {

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
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              shape: const Border(),
                visualDensity: const VisualDensity(
                    vertical: -3
                ),
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
                children: [
                  Divider(
                      color: AppColor.black.withOpacity(0.2)
                  ),
                  Text(
                      'Meeting Was Ended',
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
                        const Spacer(),
                        Text(
                            '25 Min',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.00.sp,
                                color: AppColor.black
                            )
                        ),
                        SizedBox(
                          width: widget.screenWidth * 0.03
                        )
                      ]
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.screenWidth * 0.03
                    ),
                    height: widget.screenHeight / 2.8,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                          image: AssetImage(
                            'assets/images/consulting/container_overlay.png'
                          )
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/consulting/see_design.png',
                        ),
                        SizedBox(
                          height: widget.screenHeight * 0.022
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              width: widget.screenWidth * 0.38,
                              height: widget.screenHeight * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/ic_download.svg',
                                    width: widget.screenWidth * 0.05
                                  ),
                                  SizedBox(
                                    width: widget.screenWidth * 0.03
                                  ),
                                  Text(
                                      'Your design',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 9.00.sp,
                                          color: Colors.white
                                      )
                                  )
                                ]
                              )
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColor.black.withOpacity(0.2)
                                  )
                                ),
                                width: widget.screenWidth * 0.38,
                                height: widget.screenHeight * 0.06,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/cube.svg',
                                          width: widget.screenWidth * 0.05
                                      ),
                                      SizedBox(
                                          width: widget.screenWidth * 0.03
                                      ),
                                      Text(
                                          'Your design',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.00.sp,
                                              color: AppColor.black
                                          )
                                      )
                                    ]
                                )
                            )
                          ]
                        ),
                        SizedBox(
                            height: widget.screenHeight * 0.02
                        )
                      ]
                    )
                  )
                ]
            )
          )
        ]
    );

  }

}