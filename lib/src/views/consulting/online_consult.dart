import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/consulting/appointment.dart';
import 'package:aadaiz/src/views/consulting/completed.dart';
import 'package:aadaiz/src/views/consulting/scheduled.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineConsult extends StatefulWidget {
  const OnlineConsult({super.key});

  @override
  State<OnlineConsult> createState() => _OnlineConsultState();
}

class _OnlineConsultState extends State<OnlineConsult> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this
    );

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                'Online Consult',
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
            horizontal: screenWidth * 0.022
          ),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.05,
                margin: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03
                ),
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.0066,
                    horizontal: screenWidth * 0.016
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.tabBorderColor
                  )
                ),
                child: TabBar(
                    labelStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.00.sp
                    ),
                    indicatorWeight: 1,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: const BoxDecoration(
                        color: AppColor.tabSelectedColor
                    ),
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColor.tabSelectedColor,
                    unselectedLabelColor: AppColor.black,
                    labelColor: AppColor.black,
                    tabs: const <Widget>[
                      Tab(
                          child: Text(
                              'Appointment'
                          )
                      ),
                      Tab(
                          child: Text(
                              'Scheduled'
                          )
                      ),
                      Tab(
                          child: Text(
                              'Completed'
                          )
                      )
                    ]
                )
              ),
              SizedBox(
                height: screenHeight / 1.5,
                child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Appointment(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth
                      ),
                      Scheduled(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth
                      ),
                      Completed(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth
                      )
                    ]
                )
              )
            ]
          )
        )
      )
    );

  }

}