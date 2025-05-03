import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/order_card.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/order_tracking/track_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActiveOrders extends StatefulWidget {
  const ActiveOrders({super.key});

  @override
  State<ActiveOrders> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  final bool _isConfirmed = true;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      //  await HomeController.to.getMyOrdersList('active');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Container(
      width: screenWidth,
      height: screenHeight * 0.69,
      color: AppColor.white,
      child: SmartRefresher(
        controller: refreshController,
        physics: const AlwaysScrollableScrollPhysics(),
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () async {
          final result = await HomeController.to
              .getMyOrdersList(isRefresh: true, status: 'Active');
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await HomeController.to.getMyOrdersList(status: 'Active');
          if (HomeController.to.orderCurrentPage.value >=
              HomeController.to.orderTotalPages.value) {
            refreshController.loadNoData();
          } else {
            if (result) {
              refreshController.loadComplete();
            } else {
              refreshController.loadFailed();
            }
          }
        },
        child: Obx(
          () => HomeController.to.myOrderList.isEmpty?
          const CommonEmpty(title: 'Active Orders'):
              ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.04),
              itemCount: HomeController.to.myOrderList.value.length,
              itemBuilder: (context, index) {
                var data = HomeController.to.myOrderList.value[0];
                List images = data.patternDetails!.imageUrl.split(',');
                double rating;
                if (data.rating is int) {
                  rating = data.rating.toDouble();
                } else if (data.rating is double) {
                  rating = data.rating;
                } else {
                  rating = 1.0;
                }
                return OrderCard(data: data, image: images, rating: rating,status: 0,);
              }),
        ),
      ),
    );
  }
}
