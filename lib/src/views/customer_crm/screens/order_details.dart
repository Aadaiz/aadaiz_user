import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';

import '../app_components/aadaiz_button.dart';
import '../app_components/expandInfo.dart';
import '../chat/screens/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  final String order_name;
  final String order_no;
  final String status;
  final String order_date;
  final String order_shop;
  final String order_item_count;
  final String delivery_date;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String shopId;
  final bool productStatus;
  final dynamic adminId;
  final bool isCompleted;
  final dynamic free;
  final String shopAddress;
  final String adminName;
  final String adminProfile;
  OrderDetails({
    super.key,
    required this.order_name,
    required this.status,
    required this.order_no,
    required this.order_shop,
    required this.order_item_count,
    required this.delivery_date,
    required this.order_date,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.shopId,
    required this.productStatus,
    required this.adminId,
    required this.isCompleted,
    required this.free,
    required this.shopAddress,
    required this.adminName,
    required this.adminProfile
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final CustomerController con = Get.find<CustomerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              "assets/images/bac1.png",
              height: 39.h,
              width: 39.w,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Order details",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14.0.sp,
            color: AppColors.blackColor,
          ),
        ),
        actions: [
          Obx(
                () => InkWell(
              onTap: con.fileLoading.value
                  ? null
                  : () async {
                final file =
                await con.invoiceData(widget.order_no);

                if (file != null) {
                  await OpenFilex.open(file.path);
                }
              },
              child: CommonWidgets.exportButton(
                title: con.fileLoading.value ? 'Exporting...' : 'Export',
              ),
            ),
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(Get.width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.width * 0.025),
                      border: Border.all(color: AppColors.blackColor.withAlpha(20)),
                    ),
                    child: Icon(
                     Icons.person,
                      color: AppColors.orangeColor,
                      size: Get.width * 0.06,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order_name,
                          style: GoogleFonts.inter(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0.sp,
                          ),
                        ),
                        Text(
                          "Ord ID ${widget.order_no}",
                          style: GoogleFonts.inter(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.status != 'pending'
                              ? const Color(0xFFC8FFF4)
                              : const Color(0xffFFEBB2), // Light yellow
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      widget.status,
                      style: GoogleFonts.inter(
                        fontSize: 12.0.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),


            ExpandInfo(
              freeServiceDays:widget.free,
              orderNumber: widget.order_no,
              date: widget.order_date,
              itemCount: int.parse(widget.order_item_count),
              shopName: widget.order_shop,
              shopAddress: widget.shopAddress,
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Due Date",
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    formatDateDDMMYYYY(widget.delivery_date),
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Rating Section
            if (widget.isCompleted == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate This Product",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Please rate your experience below",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => RatingBar.builder(
                        initialRating: con.rating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 35,
                        unratedColor: Colors.grey.shade300,
                        itemBuilder:
                            (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (r) {
                          con.rating.value = r;
                        },
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "Additional feedback",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    TextFormField(
                      controller: con.feedbackController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Your feedback",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Obx(
                      () => CommonButton(
                        height: Get.height * 0.04,
                        text: 'Submit Ratings',

                        press: () {
                          con.ratings(
                            widget.order_no,
                            con.rating,
                            con.feedbackController.text,
                          );
                        },
                        loading: con.isLoading.value,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 62.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16),
        child: AadaizButton(
          title: "Chat with team",
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token');
            await prefs.reload();
            final userId = prefs.getString('user_id');
            log('User Id $userId');
            if (userId != null && userId.isNotEmpty) {
              await Get.to(
                ChatScreen(
                  token: token ?? '',
                  userId: userId,
                  senderType: 'customer',
                  orderId: widget.order_no,
                  customerId: widget.adminId.toString(),
                  adminName:widget.adminName,
                  adminProfile:widget.adminProfile
                ),
              );
            } else {}
          },
        ),
      ),
    );
  }

  String formatDateDDMMYYYY(String date) {
    if (date.isEmpty) return '--';

    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date; // fallback if parsing fails
    }
  }
}
