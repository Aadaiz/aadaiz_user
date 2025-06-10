import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/consulting.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/cart.dart';
import 'package:aadaiz_customer_crm/src/views/home/home_screen.dart';
import 'package:aadaiz_customer_crm/src/views/material/material_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customer_crm/screens/customer_dashboard.dart';
import '../home/self_customization/costume_designer.dart';
import '../home/self_customization/self_customize.dart';
import '../my_orders/my_orders_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const route = '/homepage';
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List icon = [
    {'icon': 'assets/dashboard/home.png', 'text': 'Home'},
    {'icon': 'assets/dashboard/profile.png', 'text': 'Profile'},
    {'icon': 'assets/dashboard/orders.png', 'text': 'My Orders'},
    {'icon': 'assets/dashboard/cart.png', 'text': 'Cart'},
    {'icon': 'assets/dashboard/menu.png', 'text': 'Menu'},
  ];

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
    const HomeScreen(),
    const Cart(),
    const ProfileScreen(),
  ];

  List<Map<String, dynamic>> drawerIcon = <Map<String, dynamic>>[
    {'icon': 'assets/dashboard/self.png', 'text': 'Self Customization','screen': const SelfCustomize()},
    {'icon': 'assets/dashboard/consult.png', 'text': 'Consulting','screen': const Consulting()},
    {'icon': 'assets/dashboard/fabric.png', 'text': 'Material','screen': const MaterialScreen()},
  ];
   final controller =  Get.put(DashboardController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/dashboard/aadai.png',
                      height: 10.0.hp,
                      width: 20.0.wp,
                    ),
                  ],
                ),
                Gap(3.0.hp),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: drawerIcon.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.pop(context); // Close the drawer
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => drawerIcon[index]['screen']));
                        },
                        child: SizedBox(
                          width: 20.00.wp,
                          height: 10.0.hp,
                          child: Row(
                            children: [
                              Image.asset(
                                drawerIcon[index]['icon'],
                                height: 03.00.hp,
                                width: 06.00.wp,
                                color:
                                     AppColor.primary,
                              ),
                              Gap(5.0.wp),
                              Text(drawerIcon[index]['text'],
                                  style: GoogleFonts.dmSans(
                                      textStyle:  TextStyle(
                                          fontSize: 9.00.sp,
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.w400))),
                              //const Gap(4)
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(child: screens[controller.tabSelected.value])
            ],
          )),
      bottomNavigationBar: Container(
        height: 7.00.hp,
        color: AppColor.backGroundColor,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: icon.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  if(index!=4){
                    setState(() {
                      controller.tabSelected.value=index;
                    });
                  }else{
                    _scaffoldKey.currentState?.openDrawer();
                  }
                },
                child: SizedBox(
                  width: 20.00.wp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        icon[index]['icon'],
                        height: 03.00.hp,
                        width: 06.00.wp,
                        color: controller.tabSelected.value==index || index==4
                            ? AppColor.primary:
                        AppColor.unSelectColor,
                      ),
                      Text(icon[index]['text'],
                          style: GoogleFonts.dmSans(
                              textStyle:  TextStyle(
                                  fontSize: 8.00.sp,
                                  color: controller.tabSelected.value==index || index==4? AppColor.primary:
                                  AppColor.unSelectColor,
                                  fontWeight: FontWeight.w400))),
                      //const Gap(4)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
