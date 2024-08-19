import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalSupportList extends StatefulWidget {

  final double screenHeight;
  final double screenWidth;

  const TechnicalSupportList({super.key, required this.screenHeight, required this.screenWidth});

  @override
  State<TechnicalSupportList> createState() => _TechnicalSupportListState();
}

class _TechnicalSupportListState extends State<TechnicalSupportList> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index){

          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: widget.screenHeight * 0.01,
                horizontal: widget.screenWidth * 0.01
            ),
            child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: widget.screenHeight * 0.018,
                  horizontal: widget.screenWidth * 0.03
                ),
                // height: widget.screenHeight * 0.18,
                width: double.infinity,
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
                      Row(
                          children: [
                            Text(
                                'Ticket Number',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.00.sp,
                                    color: AppColor.primary
                                )
                            ),
                            SizedBox(
                                width: widget.screenWidth * 0.022
                            ),
                            Text(
                                '#123345',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.00.sp,
                                    color: AppColor.hintTextColor
                                )
                            ),
                            const Spacer(),
                            Text(
                                'May 5, 2024',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.00.sp,
                                    color: AppColor.primary
                                )
                            )
                          ]
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              'Size not fixed',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.00.sp,
                                  color: AppColor.primary
                              )
                          ),
                          subtitle: Text(
                              'I ordered one of your dress but that size is not suitable properly',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.00.sp,
                                  color: AppColor.hintTextColor
                              )
                          )
                      ),
                      Container(
                          height: widget.screenHeight * 0.03,
                          width: widget.screenWidth * 0.18,
                          decoration: BoxDecoration(
                              color: AppColor.supportStatusColor,
                              borderRadius: BorderRadius.circular(18)
                          ),
                          alignment: Alignment.center,
                          child: Text(
                              'Pending',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.00.sp,
                                  color: Colors.white
                              )
                          )
                      )
                    ]
                )
            )
          );

        }
    );

  }

}