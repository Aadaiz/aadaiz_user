import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/profile/support/closed_technical_support.dart';
import 'package:aadaiz/src/views/profile/support/get_technical_support.dart';
import 'package:aadaiz/src/views/profile/support/pending_technical_support.dart';
import 'package:aadaiz/src/views/profile/support/technical_support_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalSupport extends StatefulWidget {
  const TechnicalSupport({super.key});

  @override
  State<TechnicalSupport> createState() => _TechnicalSupportState();
}

class _TechnicalSupportState extends State<TechnicalSupport> with SingleTickerProviderStateMixin{

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
                'Technical Support',
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
                horizontal: screenWidth * 0.05
            ),
            child: Column(
                children: [
                  TabBar(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03
                      ),
                      labelStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp
                      ),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicatorColor: AppColor.primary,
                      unselectedLabelColor: AppColor.hintTextColor,
                      labelColor: AppColor.primary,
                      tabs: const <Widget>[
                        Tab(
                            child: Text(
                                'All'
                            )
                        ),
                        Tab(
                            child: Text(
                                'Pending'
                            )
                        ),
                        Tab(
                            child: Text(
                                'Closed'
                            )
                        )
                      ]
                  ),
                  SizedBox(
                    height: screenHeight / 1.4,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[
                          TechnicalSupportList(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth
                          ),
                          const PendingTechnicalSupport(),
                          const ClosedTechnicalSupport()
                        ]
                    )
                  )
                ]
            )
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              onPressed: (){

                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const GetTechnicalSupport()
                    )
                );

              },
              child: SvgPicture.asset(
                  'assets/svg/add_floating.svg',
                  height: screenHeight * 0.1
              )
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
      )
    );

  }

}