import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:aadaiz/src/views/my_orders/active_orders.dart';
import 'package:aadaiz/src/views/my_orders/cancelled_orders.dart';
import 'package:aadaiz/src/views/my_orders/completed_orders.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/widgets/common_app_bar.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {

    super.initState();
    _tabController = TabController(
        length: 3,
        vsync: this
    );
    // Future.delayed(const Duration(milliseconds: 500),(){
    //   HomeController.to.getMyOrdersList('active');
    // });

  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(
              100,
              6.0.hp,
            ),
            child: const CommonAppBar(
              title: 'My Orders',
            ),
          ),
        body: Column(
          children: [
            TabBar(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                  horizontal: screenWidth * 0.016
                ),
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.00.sp
                ),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColor.primary
                ),
                dividerColor: Colors.transparent,
                indicatorColor: AppColor.primary,
                unselectedLabelColor: AppColor.black,
                labelColor: Colors.white,
                tabs: <Widget>[
                 Container(
                   width: double.infinity,
                   decoration: BoxDecoration(
                     border: Border.all(
                       color: AppColor.primary
                     )
                   ),
                   child: const Tab(
                       child: Text(
                           'Active'
                       )
                   )
                 ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.primary
                          )
                      ),
                    child: const Tab(
                        child: Text(
                            'Completed'
                        )
                    )
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.primary
                          )
                      ),
                    child: const Tab(
                        child: Text(
                            'Cancelled'
                        )
                    )
                  )
                ]
            ),
            AutoScaleTabBarView(
                controller: _tabController,
                children: const <Widget>[
                  ActiveOrders(),
                  CompletedOrders(),
                  CancelledOrders()
                ]
            )
          ]
        )
      )
    );

  }

}