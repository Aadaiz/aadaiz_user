import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/consulting/review_designer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';

class DesignerDetail extends StatefulWidget {
  const DesignerDetail({super.key});

  @override
  State<DesignerDetail> createState() => _DesignerDetailState();
}

class _DesignerDetailState extends State<DesignerDetail> {

  final List<String> _duration = ["1", "2"];
  final String _selectedValue = "1";

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
              'Designer Details',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.022
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              SizedBox(
                  height: screenHeight * 0.03
              ),
              Text(
                  'About',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                height: screenHeight * 0.022
              ),
              Text(
                  "Highly Creative And Detail-Oriented Fashion\nDesigner With Over Seven Years Of Experience\nDesigning And Developing Women's Apparel For High-End Fashion Brands.",
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.00.sp,
                      color: AppColor.hintTextColor
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.03
              ),
              Text(
                  'Select Date',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              TimelineCalendar(
                calendarType: CalendarType.GREGORIAN,
                calendarLanguage: "en",
                calendarOptions: CalendarOptions(
                  viewType: ViewType.DAILY,
                  toggleViewType: true,
                  headerMonthElevation: 10,
                  headerMonthShadowColor: Colors.black26,
                  headerMonthBackColor: Colors.transparent,
                ),
                dayOptions: DayOptions(
                    compactMode: true,
                    weekDaySelectedColor: const Color(0xff3AC3E2),
                    disableDaysBeforeNow: true),
                headerOptions: HeaderOptions(
                    weekDayStringType: WeekDayStringTypes.SHORT,
                    monthStringType: MonthStringTypes.FULL,
                    backgroundColor: const Color(0xff3AC3E2),
                    headerTextColor: Colors.black),
                onChangeDateTime: (datetime) {

                },
              ),
              SizedBox(
                  height: screenHeight * 0.03
              ),
              Text(
                  'Available Time',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              GroupButton<String>(
                  buttons: const <String>['9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM'],
                  onSelected: (String val, int index, bool isSelected){},
                  options: GroupButtonOptions(
                      buttonWidth: screenWidth * 0.2,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      borderRadius: BorderRadius.circular(8),
                      selectedBorderColor: AppColor.primary,
                      unselectedBorderColor: AppColor.hintTextColor,
                      selectedColor: AppColor.primary,
                      unselectedColor: Colors.white,
                      selectedTextStyle: GoogleFonts.dmSans(
                        fontSize: 10.00.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white
                      ),
                      unselectedTextStyle: GoogleFonts.dmSans(
                          fontSize: 10.00.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black
                      )
                  )
              ),
              Container(
                  width: double.infinity,
                  height: screenHeight * 0.05,
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.03
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color: AppColor.dropdownBgColor
                      )
                  ),
                  child: DropdownButton<String>(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20
                      ),
                      borderRadius: BorderRadius.circular(3),
                      underline: const SizedBox(),
                      value: _selectedValue,
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.black.withOpacity(0.5)
                      ),
                      isExpanded: true,
                      hint: Text(
                          'Select Duration',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.black.withOpacity(0.5)
                          )
                      ),
                      items: _duration.map<DropdownMenuItem<String>>((String val){

                        return DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                                val
                            )
                        );

                      }).toList(),
                      onChanged: (String? val) {}
                  )
              ),
              CommonButton(
                  press: (){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const ReviewDesigner()
                        )
                    );

                  },
                text: 'Continue'
              ),
              SizedBox(
                  height: screenHeight * 0.022
              )
            ]
          )
        )
      )
    );

  }

}