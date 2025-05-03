import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../profile/controller/profile_controller.dart';
import '../../profile/profile_screen.dart';
import '../../profile/user_notification.dart';
import '../app_components/order_widget.dart';
import '../app_components/search_field.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CustomerDashboard extends StatefulWidget {
  CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final CustomerController con = Get.put(CustomerController());

  zegoInit() async {
    await profileController.getProfile();
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 752441908,
      appSign:
          "05518f2f576c1b4cbd8bd3df35ff4487477c45e89fc8f9654244442ba42551c0",
      userID: '123',
      //"${ProfileController.to.profileData.value.id??''}",
      userName: 'customer',
      //"${ProfileController.to.profileData.value.username??''}",
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    zegoInit();
    con.getOrders(filter: "today");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: Get.height * 0.01,
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //spacing: 16.w,
                  children: [
                    Image.asset("assets/images/Brandname.png", height: 34.h),
                    const Spacer(),
                    // ZegoSendCallInvitationButton(
                    //   isVideoCall: false,
                    //   buttonSize: const Size(100, 100),
                    //   iconSize: const Size(40, 40),
                    //   icon: ButtonIcon(
                    //     icon: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Image.asset(
                    //         "assets/images/call.png", // Path to your image
                    //         width: 20,
                    //         height: 20,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //   ),
                    //   resourceID: "aadaiz_call",
                    //   invitees: [ZegoUIKitUser(id: "456", name: "surya")],
                    // ),
                    InkWell(
                      onTap: () {
                        Get.to(() => UserNotification());
                      },
                      child: Image.asset(
                        "assets/images/notification.png",
                        width: 16.h,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: Image.asset(
                        "assets/dashboard/profile.png",
                        width: 18.h,
                        color: AppColors.projectcolor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SearchOrdersField(
                  onChanged: (val) {
                    Future.delayed(Duration(), () {
                      con.getOrders();
                    });
                  },
                ),
                const SizedBox(height: 34),
                Container(
                  width: Get.width,
                  height: 41.h,
                  decoration: BoxDecoration(
                    color: AppColors.tab_bar_bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8,
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.projectcolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: AppColors.whiteColor,
                      unselectedLabelColor: AppColors.blackColor,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      tabs: const [
                        Tab(text: "New orders"),
                        Tab(text: "Existing orders"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      color: AppColors.whiteColor,
                      onSelected: (value) {},
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              onTap: () {
                                con.getOrders(filter: "today");
                              },
                              value: 'New order',
                              child: Text(
                                'New order',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                con.getOrders(filter: "progress");
                              },
                              value: 'In progress',
                              child: Text(
                                'In progress',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Last week',
                              onTap: () {
                                con.getOrders(filter: "last_week");
                              },
                              child: Text(
                                'Last week',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'Last month',
                              onTap: () {
                                con.getOrders(filter: "last_month");
                              },
                              child: Text(
                                'Last month',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                      child: Row(
                        //spacing: 4.w,
                        children: [
                          Text(
                            'Filters',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Image.asset("assets/images/fil.png", width: 20.w),
                        ],
                      ), // Or any widget you want to tap
                    ),
                  ],
                ),
                Obx(
                  () => SizedBox(
                    height: Get.height * 0.5,
                    child: TabBarView(
                      children: [
                        con.isLoading.value
                            ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.projectcolor,
                              ),
                            )
                            : SizedBox(
                              height: Get.height * 0.5,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var productsStatus =
                                      con
                                          .orderDatas
                                          .value
                                          .data!
                                          .newOrders!
                                          .data![index]
                                          .newOrdersProduct ??
                                      [];

                                  return OrderWidget(
                                    is_completed: productsStatus.every(
                                      (element) => element == true,
                                    ),
                                    order_name:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .customerName ??
                                        "",
                                    order_no:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .id
                                            .toString(),
                                    products:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .newOrdersProduct ??
                                        [],
                                    order_shop:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .shopName ??
                                        "",
                                    order_item_count:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .newOrdersProduct!
                                            .length
                                            .toString(),
                                    delivery_date:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .deliveryDate ??
                                        "null",
                                    order_date:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .createdAt ??
                                        "null",
                                    name:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .customerName ??
                                        "null",
                                    email:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .customerMail ??
                                        "null",
                                    address:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .shippingAddress ??
                                        "null",
                                    phone:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .contactNumber ??
                                        "null",
                                    shopId:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .newOrders!
                                            .data![index]
                                            .createdSubadminId!,
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 8.h),
                                itemCount:
                                    con
                                        .orderDatas
                                        .value
                                        .data!
                                        .newOrders!
                                        .data!
                                        .length,
                              ),
                            ),
                        con.isLoading.value
                            ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.projectcolor,
                              ),
                            )
                            : SizedBox(
                              height: Get.height * 0.5,
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var products_status =
                                      con
                                          .orderDatas
                                          .value
                                          .data!
                                          .existingOrders!
                                          .data![index]
                                          .newOrdersProduct ??
                                      [];

                                  return OrderWidget(
                                    is_completed: products_status.every(
                                      (element) => element == true,
                                    ),
                                    order_name:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .customerName ??
                                        "",
                                    order_no:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .id
                                            .toString(),
                                    products:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .newOrdersProduct ??
                                        [],
                                    order_shop:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .shopName ??
                                        "",
                                    order_item_count:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .newOrdersProduct!
                                            .length
                                            .toString(),
                                    delivery_date:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .deliveryDate ??
                                        "null",
                                    order_date:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .createdAt ??
                                        "null",
                                    name:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .customerName ??
                                        "null",
                                    email:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .customerMail ??
                                        "null",
                                    address:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .shippingAddress ??
                                        "null",
                                    phone:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .contactNumber ??
                                        "null",
                                    shopId:
                                        con
                                            .orderDatas
                                            .value
                                            .data!
                                            .existingOrders!
                                            .data![index]
                                            .createdSubadminId!,
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 8.h),
                                itemCount:
                                    con
                                        .orderDatas
                                        .value
                                        .data!
                                        .existingOrders!
                                        .data!
                                        .length,
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
