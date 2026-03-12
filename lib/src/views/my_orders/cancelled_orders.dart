import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../res/components/common_toast.dart';
import '../home/controller/home_controller.dart';
import 'order_card.dart';

class CancelledOrders extends StatefulWidget {
  const CancelledOrders({super.key});

  @override
  State<CancelledOrders> createState() => _CancelledOrdersState();
}

class _CancelledOrdersState extends State<CancelledOrders> {
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeController.to.getMyOrdersList(status: 'cancelled');
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
        enablePullDown: true,
        enablePullUp: true,
        physics: const AlwaysScrollableScrollPhysics(),

        onRefresh: () async {
          final result = await HomeController.to
              .getMyOrdersList(isRefresh: true, status: 'cancelled');

          result
              ? refreshController.refreshCompleted()
              : refreshController.refreshFailed();
        },

        onLoading: () async {
          final result =
          await HomeController.to.getMyOrdersList(status: 'cancelled');

          if (HomeController.to.orderCurrentPage.value >=
              HomeController.to.orderTotalPages.value) {
            refreshController.loadNoData();
          } else {
            result
                ? refreshController.loadComplete()
                : refreshController.loadFailed();
          }
        },

        child: Obx(() {
          final list = HomeController.to.myOrderList;

          if (list.isEmpty) {
            return const CommonEmpty(title: 'Cancelled Orders');
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.04,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              var data = list[index];
              // List images = data.patternDetails!.imageUrl.split(',');
              //
              // double rating = (data.rating is num)
              //     ? (data.rating as num).toDouble()
              //     : 1.0;
              List images = data.materialImage!.split(',');

              double rating = 5.0;
              // (data.rating is num)
              //     ? (data.rating as num).toDouble()
              //     : 1.0;
              return OrderCard(
                data: data,
                image: images,
                rating: rating,
                status: 2,
              );
            },
          );
        }),
      ),
    );
  }
}