import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/controller/home_controller.dart';

class Coupon extends StatefulWidget {
  const Coupon({super.key, required this.callBack});
final Function(String) callBack;
  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      await HomeController.to.getCouponList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(
            100,
            8.0.hp,
          ),
          child: const CommonAppBar(
            title: 'Coupon',
          ),
        ),
        body: Obx(
          () => Column(children: [
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
                    vertical: screenHeight * 0.022),
                alignment: Alignment.centerLeft,
                child: Text('Coupon',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.00.sp,
                        color: AppColor.textColor))),
            HomeController.to.couponListLoading.value
                ? const CommonLoading()
                : HomeController.to.couponList.value.isEmpty
                    ? const CommonEmpty(title: 'coupon')
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.066),
                        itemCount: HomeController.to.couponList.value.length,
                        itemBuilder: (context, index) {
                          var data = HomeController.to.couponList.value[index];

                          return  Text('test');
                            // TicketWidget(
                            //   margin: EdgeInsets.symmetric(
                            //       vertical: screenHeight * 0.018),
                            //   width: screenWidth,
                            //   height: screenHeight * 0.18,
                            //   color: AppColor.couponBorder.withOpacity(0.2),
                            //   isCornerRounded: true,
                            //   child: Column(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         ListTile(
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 horizontal: screenWidth * 0.1,
                            //                 vertical: 0),
                            //             title: Text(data.title ?? '',
                            //                 style: GoogleFonts.dmSans(
                            //                     fontWeight: FontWeight.w700,
                            //                     fontSize: 12.00.sp,
                            //                     color: AppColor.textColor)),
                            //             subtitle: Text(data.description ?? '',
                            //                 style: GoogleFonts.dmSans(
                            //                     fontWeight: FontWeight.w700,
                            //                     fontSize: 8.00.sp,
                            //                     color: AppColor.primary))),
                            //         Padding(
                            //             padding: EdgeInsets.symmetric(
                            //                 horizontal: screenWidth * 0.1),
                            //             child: Row(children: [
                            //               Image.asset(
                            //                   'assets/images/discount.png',
                            //                   height: screenHeight * 0.03),
                            //               SizedBox(width: screenWidth * 0.03),
                            //               Text(data.couponCode ?? '',
                            //                   style: GoogleFonts.dmSans(
                            //                       fontWeight: FontWeight.w700,
                            //                       fontSize: 12.00.sp,
                            //                       color: AppColor.textColor))
                            //             ])),
                            //         InkWell(
                            //           onTap:(){
                            //             widget.callBack(data.couponCode??'');
                            //             Get.back();
                            //           },
                            //           child: Container(
                            //               margin: EdgeInsets.only(
                            //                   top: screenHeight * 0.01),
                            //               height: screenHeight * 0.045,
                            //               color: AppColor.primary,
                            //               width: double.infinity,
                            //               alignment: Alignment.center,
                            //               child: Text('Copy Code',
                            //                   style: GoogleFonts.dmSans(
                            //                       fontWeight: FontWeight.w400,
                            //                       fontSize: 12.00.sp,
                            //                       color: Colors.white))),
                            //         )
                            //       ]));
                        })
          ]),
        ));
  }
}
