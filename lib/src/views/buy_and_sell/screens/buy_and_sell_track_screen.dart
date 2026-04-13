

import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_track_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyAndSellTrackOrderScreen extends StatelessWidget {
  final dynamic orderId;
  const BuyAndSellTrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BuyAndSellController>();
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          title: 'Track Order',
          leadingclick: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final trackData = controller.trackOrderData.value;

        if (controller.trackOrderLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (trackData == null) {
          return Center(
            child: Text(
              'No tracking data available',
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                color: AppColor.subTitleColor,
              ),
            ),
          );
        }

        final events = trackData.payload ?? [];

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header Info Card ───────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID',
                              style: GoogleFonts.dmSans(
                                fontSize: 11.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '#$orderId',
                              style: GoogleFonts.dmSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'AWB Code',
                              style: GoogleFonts.dmSans(
                                fontSize: 11.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              trackData.awbCode ?? '-',
                              style: GoogleFonts.dmSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 14,
                            color: AppColor.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            trackData.status ?? 'In Transit',
                            style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // ── Timeline Title ─────────────────────────────────────
              Text(
                'Shipment Activity',
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),

              // ── Vertical Timeline ──────────────────────────────────
              events.isEmpty
                  ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'No tracking events yet',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 13.sp,
                    color: AppColor.subTitleColor,
                  ),
                ),
              )
                  : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final bool isFirst = index == 0;
                    final bool isLast = index == events.length - 1;

                    return _buildTimelineItem(
                      event: event,
                      isFirst: isFirst,
                      isLast: isLast,
                      screenWidth: screenWidth,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTimelineItem({
    required TrackingEvent event,
    required bool isFirst,
    required bool isLast,
    required double screenWidth,
  }) {
    final Color dotColor = isFirst ? AppColor.primary : Colors.grey.shade400;
    final Color lineColor = Colors.grey.shade300;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Timeline Dot + Line ──────────────────────────────────
          SizedBox(
            width: 28,
            child: Column(
              children: [
                // Dot
                Container(
                  width: isFirst ? 18 : 13,
                  height: isFirst ? 18 : 13,
                  margin: EdgeInsets.only(top: isFirst ? 0 : 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFirst ? AppColor.primary : Colors.white,
                    border: Border.all(
                      color: dotColor,
                      width: isFirst ? 0 : 2,
                    ),
                    boxShadow: isFirst
                        ? [
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.3),
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ]
                        : [],
                  ),
                  child: isFirst
                      ? const Icon(Icons.check, size: 10, color: Colors.white)
                      : null,
                ),
                // Line going down (hidden for last item)
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // ── Event Content ──────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status
                  Text(
                    event.status ?? '',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      fontWeight:
                      isFirst ? FontWeight.w700 : FontWeight.w500,
                      color: isFirst ? AppColor.primary : AppColor.black,
                    ),
                  ),
                  if ((event.activity ?? '').isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      event.activity ?? '',
                      style: GoogleFonts.dmSans(
                        fontSize: 11.sp,
                        color: AppColor.subTitleColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      if ((event.location ?? '').isNotEmpty) ...[
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColor.greyTitleColor,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            event.location ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 10.sp,
                              color: AppColor.greyTitleColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      if ((event.date ?? '').isNotEmpty) ...[
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: AppColor.greyTitleColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          event.date ?? '',
                          style: GoogleFonts.dmSans(
                            fontSize: 10.sp,
                            color: AppColor.greyTitleColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}