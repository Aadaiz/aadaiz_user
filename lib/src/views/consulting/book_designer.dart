import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/consulting/designer_booked.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDesigner extends StatefulWidget {
  const BookDesigner({super.key});

  @override
  State<BookDesigner> createState() => _BookDesignerState();
}

class _BookDesignerState extends State<BookDesigner> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              'Booking Details',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.033
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Designer',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.033
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.033
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4)
                        )
                      ]
                  ),
                  child: Row(
                      children: [
                        SizedBox(
                            height: screenHeight * 0.1,
                            child: Stack(
                                children: [
                                  SizedBox(
                                      child: Image.asset(
                                          'assets/images/consulting/designer_avatar.png',
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  const Positioned(
                                      top: 7,
                                      right: 7,
                                      child: CircleAvatar(
                                          radius: 7,
                                          backgroundColor: AppColor.circleDotColor
                                      )
                                  )
                                ]
                            )
                        ),
                        SizedBox(
                            width: screenWidth * 0.05
                        ),
                        SizedBox(
                            height: screenHeight * 0.1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Vijay',
                                      style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.00.sp,
                                          color: AppColor.designerColor
                                      )
                                  ),
                                  Text(
                                      'Designer',
                                      style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.00.sp,
                                          color: AppColor.designerRoleColor
                                      )
                                  ),
                                  Text(
                                      '⭐️ 4.5 (135 reviews)',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 9.00.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.designerRoleColor
                                      )
                                  )
                                ]
                            )
                        )
                      ]
                  )
              ),
              ExpansionTile(
                  shape: const Border(),
                childrenPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05
                ),
                  title: Text(
                      'Schedule Timings',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.00.sp,
                          color: AppColor.black
                      )
                  ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Scheduled Date',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.hintTextColor
                          )
                      ),
                      Text(
                          'Mar 24, 2024',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.hintTextColor
                          )
                      )
                    ]
                  ),
                  SizedBox(
                    height: screenHeight * 0.01
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Time',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.hintTextColor
                            )
                        ),
                        Text(
                            '11:00 AM',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.hintTextColor
                            )
                        )
                      ]
                  ),
                  SizedBox(
                      height: screenHeight * 0.01
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Duration',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.hintTextColor
                            )
                        ),
                        Text(
                            '20 Min',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.hintTextColor
                            )
                        )
                      ]
                  )
                ]
              )
            ]
          )
        )
      ),
      bottomNavigationBar: BottomAppBar(
          notchMargin: 0,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.01
          ),
          color: Colors.transparent,
          child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03
              ),
              dense: true,
              tileColor: AppColor.primary,
              titleAlignment: ListTileTitleAlignment.center,
              title: Text(
                  'Total',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.00.sp,
                      color: Colors.white
                  )
              ),
              subtitle: Text(
                  '₹314.00',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.00.sp,
                      color: Colors.white
                  )
              ),
              trailing: InkWell(
                  onTap: (){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const DesignerBooked()
                        )
                    );

                  },
                  child: Container(
                      height: screenHeight * 0.066,
                      width: screenWidth * 0.35,
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.033
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/ic_pay.png',
                              width: screenWidth * 0.066,
                            ),
                            Text(
                                'Payment',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            )
                          ]
                      )
                  )
              )
          )
      )
    );

  }

}