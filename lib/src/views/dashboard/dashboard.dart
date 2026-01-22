import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/consulting.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/cart.dart';
import 'package:aadaiz_customer_crm/src/views/home/home_screen.dart';
import 'package:aadaiz_customer_crm/src/views/material/material_screen.dart';
import 'package:aadaiz_customer_crm/src/views/order/material_cart.dart';
import 'package:aadaiz_customer_crm/src/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_border/flutter_animate_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customer_crm/screens/customer_dashboard.dart';
import '../home/self_customization/self_customize.dart';
import '../my_orders/my_orders_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const route = '/homepage';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = DashboardController.to;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List icon = [
    {'icon': 'assets/dashboard/home.png', 'text': 'Home'},
    {'icon': 'assets/dashboard/profile.png', 'text': 'Profile'},
    // {'icon': 'assets/dashboard/orders.png', 'text': 'My Orders'},
    // {'icon': 'assets/dashboard/cart.png', 'text': 'Cart'},
    {'icon': 'assets/dashboard/orders.png', 'text': 'StitchPro'},
  ];

  final List<Widget> screens = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
    // const MyOrderScreen(),
    // const MaterialCart(),
    const ProfileScreen(),
  ];

  final List<Map<String, dynamic>> drawerIcon = <Map<String, dynamic>>[
    // {
    //   'icon': 'assets/dashboard/self.png',
    //   'text': 'Self Customization',
    //   'screen': const SelfCustomize()
    // },
    // {
    //   'icon': 'assets/dashboard/consult.png',
    //   'text': 'Consulting',
    //   'screen': const Consulting()
    // },
    // {
    //   'icon': 'assets/dashboard/fabric.png',
    //   'text': 'Material',
    //   'screen': const MaterialScreen()
    // },
    {
      'icon': 'assets/dashboard/cor.png',
      'text': 'Customer orders',
      'screen': const CustomerDashboard()
    },
  ];
  final FlutterAnimateBorderController aniController =
  FlutterAnimateBorderController(isLoading: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColor.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Image.asset(
                        'assets/dashboard/aadai.png',
                        height: 10.0.hp,
                        width: 27.0.wp,
                      ),
                    ),
                  ],
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: drawerIcon.length,
                  itemBuilder: (context, index) {
                    bool isCustomerOrders =
                        drawerIcon[index]['text'] == 'Customer orders';

                    Widget menuRow = Row(
                      children: [
                        Image.asset(
                          drawerIcon[index]['icon'],
                          height: 4.0.hp,
                          width: 7.0.wp,
                          color: AppColor.primary,
                        ),
                        Gap(5.0.wp),
                        Text(
                          drawerIcon[index]['text']=='Customer orders'?'StitchPro Orders':drawerIcon[index]['text'],
                          style: GoogleFonts.inter(
                            fontSize: 14.0.sp,
                            color: AppColor.primary,
                            fontWeight: isCustomerOrders
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                        if (isCustomerOrders) ...[
                          Gap(3.0.wp),

                        ],
                      ],
                    );

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            drawerIcon[index]['screen'],
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(1.0.hp, 2.0.hp, 3.0.hp, 3.0.hp),


                        child:Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12),
                          child: menuRow,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Obx(
                () => Expanded(
              child: screens[controller.tabSelected.value],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 7.0.hp,
        color: AppColor.backGroundColor,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: icon.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index != 2) {
                  controller.tabSelected.value = index;
                } else {
                  _scaffoldKey.currentState?.openDrawer();
                }
              },
              child: Obx(
                    () => SizedBox(
                      width: 33.0.wp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        icon[index]['icon'],
                        height: 3.0.hp,
                        width: 6.0.wp,
                        color: controller.tabSelected.value == index ||
                            index == 4
                            ? AppColor.primary
                            : AppColor.unSelectColor,
                      ),
                      Text(
                        icon[index]['text'],
                        style: GoogleFonts.inter(
                          fontSize: 9.0.sp,
                          color: controller.tabSelected.value == index ||
                              index == 4
                              ? AppColor.primary
                              : AppColor.unSelectColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
