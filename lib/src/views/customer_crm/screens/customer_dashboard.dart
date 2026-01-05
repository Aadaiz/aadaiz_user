

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



import '../app_components/order_widget.dart';
import '../app_components/search_field.dart';


class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final CustomerController con = Get.put(CustomerController());
  final RefreshController _refreshNew = RefreshController();
  final RefreshController _refreshExisting = RefreshController();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    con.getOrders(filter: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() {
        if (con.isLoading.value && (con.orderDatas.value.data == null)) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(16,36,16,16),
            child: ShimmerList(itemCount: 10,),
          );
        }

        final newOrders = con.orderDatas.value.data?.newOrders?.data ?? [];
        final existingOrders =
            con.orderDatas.value.data?.existingOrders?.data ?? [];

        return DefaultTabController(
          length: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 35),
                SearchOrdersField(
                  controller: controller,

                  onChanged: (val) {

                      con.getOrders(search:controller.text );

                  },
                ),
                const SizedBox(height: 25),
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
                      labelStyle: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: AppColors.whiteColor,
                      unselectedLabelColor: AppColors.blackColor,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      tabs: const [
                        Tab(text: "Live orders"),
                        Tab(text: "Completed orders"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    children: [
                      /// --- New Orders ---
                      SmartRefresher(
                        controller: _refreshNew,
                        enablePullUp: true,
                        onRefresh: () async {
                          await con.getOrders(filter: "progress");
                          _refreshNew.refreshCompleted();
                        },
                        onLoading: () async {
                          if (con.hasMoreNew) {
                            await con.getOrders(
                              filter: "progress",
                              page: con.currentPageNew + 1,
                              isLoadMore: true,
                              isNewOrder: true,
                            );
                            _refreshNew.loadComplete();
                          } else {
                            _refreshNew.loadNoData();
                          }
                        },
                        child: ListView.separated(
                          itemCount: newOrders.length,
                          itemBuilder: (context, index) {
                            final item = newOrders[index];
                            return OrderWidget(

                              orderStatus: item.orderStatus ?? "",
                              productStatus: (item.newOrdersProduct ?? [])
                                  .every((e) => e.productStatus == true),
                              orderName: item.customerName ?? "",
                              orderNo: item.id.toString(),
                              products: item.newOrdersProduct ?? [],
                                orderShop: item.subadmin!.admin.shopName??'',
                              orderItemCount:
                                  "${item.newOrdersProduct?.length ?? 0}",
                              deliveryDate: item.deliveryDate ?? "",
                              orderDate: item.createdAt ?? "",
                              name: item.customerName ?? "",
                              phone: item.contactNumber ?? "",
                              email: "",
                              address: item.shippingAddress ?? "",
                              shopId: "",
                              adminId:item.subadminId,
                                isCompleted:item.isCompleted,
                              free:item.freeServiceDays,
                              shopAddress:
                              "${item.subadmin?.admin.city ?? ''}, "
                                  "${item.subadmin?.admin.state ?? ''}, "
                                  "${item.subadmin?.admin.country ?? ''} - "
                                  "${item.subadmin?.admin.pincode ?? ''}, "
                                  "${item.subadmin?.admin.areaStreet ?? ''}",
                              adminName:item.subadmin?.admin.name??'',
                                adminProfile:item.subadmin?.admin.profileImage??''

                            );
                          },
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 10),
                        ),
                      ),

                      /// --- Existing Orders ---
                      SmartRefresher(
                        controller: _refreshExisting,
                        enablePullUp: true,
                        onRefresh: () async {
                          await con.getOrders(filter: "existing");
                          _refreshExisting.refreshCompleted();
                        },
                        onLoading: () async {
                          if (con.hasMoreExisting) {
                            await con.getOrders(
                              filter: "existing",
                              page: con.currentPageExisting + 1,
                              isLoadMore: true,
                              isNewOrder: false,
                            );
                            _refreshExisting.loadComplete();
                          } else {
                            _refreshExisting.loadNoData();
                          }
                        },
                        child: ListView.separated(
                          itemCount: existingOrders.length,
                          itemBuilder: (context, index) {
                            final item = existingOrders[index];
                            return OrderWidget(
                              orderStatus: item.orderStatus ?? "",
                              productStatus: (item.existingOrdersProduct ?? [])
                                  .every((e) => e.productStatus == true),
                              orderName: item.customerName ?? "",
                              orderNo: item.id.toString(),
                              products: item.existingOrdersProduct ?? [],
                              orderShop: item.subadmin!.admin.shopName??'',
                              orderItemCount:
                                  "${item.existingOrdersProduct?.length ?? 0}",
                              deliveryDate: item.deliveryDate ?? "",
                              orderDate: item.createdAt ?? "",
                              name: item.customerName ?? "",
                              phone: item.contactNumber ?? "",
                              email: "",
                              address: item.shippingAddress ?? "",
                              shopId: "",
                              adminId:item.subadminId,
                              isCompleted:item.isCompleted,
                              free: item.freeServiceDays,
                              shopAddress:
                              "${item.subadmin?.admin.city ?? ''}, "
                                  "${item.subadmin?.admin.state ?? ''}, "
                                  "${item.subadmin?.admin.country ?? ''} - "
                                  "${item.subadmin?.admin.pincode ?? ''}, "
                                  "${item.subadmin?.admin.areaStreet ?? ''}",
                                adminName:item.subadmin?.admin.name??'',
                                adminProfile:item.subadmin?.admin.profileImage??''

                        );
                          },
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
