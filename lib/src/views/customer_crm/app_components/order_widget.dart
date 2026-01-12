import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/order_details.dart';
import '../screens/ordered_items.dart';
import 'app_colors.dart';

class OrderWidget extends StatefulWidget {
  final String orderStatus,
      orderName,
      orderNo,
      orderShop,
      orderItemCount,
      orderDate,
      deliveryDate,
      name,
      phone,
      email,
      address,
      shopId;
  final bool productStatus;
  final bool isCompleted;
  final dynamic adminId;
  final dynamic free;
  final String shopAddress;

  final List<OrderProduct> products;
  final String adminName;
  final dynamic adminProfile;

  const OrderWidget({
    super.key,
    required this.orderStatus,
    required this.productStatus,
    required this.orderName,
    required this.orderNo,
    required this.products,
    required this.orderShop,
    required this.orderItemCount,
    required this.deliveryDate,
    required this.orderDate,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.shopId,
    required this.adminId,
    required this.isCompleted,
    required this.free,
    required this.shopAddress,
    required this.adminName,
    required this.adminProfile,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool expand = false;
  //bool

  @override
  Widget build(BuildContext context) {
    final isPending = widget.orderStatus.toLowerCase() == 'pending';

    return GestureDetector(
      onTap:
          () => Get.to(
            () => OrderDetails(
              status: widget.orderStatus,
              order_name: widget.orderName,
              order_no: widget.orderNo,
              order_shop: widget.orderShop,
              order_item_count: widget.orderItemCount,
              delivery_date: widget.deliveryDate,
              order_date: widget.orderDate,
              name: widget.name,
              email: widget.email,
              address: widget.address,
              phone: widget.phone,
              shopId: widget.shopId,
              productStatus: widget.productStatus,
              adminId: widget.adminId,
              isCompleted: widget.isCompleted,
              free: widget.free,
              shopAddress: widget.shopAddress,
              adminName: widget.adminName,
            ),
          ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Header Row ---
            Row(
              children: [
                Image.asset(
                  "assets/images/appvan.png",
                  height: 46.h,
                  width: 46.w,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.orderName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        "Ord ID ${widget.orderNo}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.blackColor,
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
                        isPending
                            ? const Color(0xffFFEBB2)
                            : const Color(0xFFC8FFF4),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    widget.orderStatus,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                InkWell(
                  onTap: () => setState(() => expand = !expand),
                  child: Image.asset(
                    expand
                        ? "assets/images/up.png"
                        : "assets/images/downarr.png",
                    height: 14.h,
                    width: 14.w,
                  ),
                ),
              ],
            ),

            /// --- Expanded Product Section ---
            if (expand) ...[
              SizedBox(height: 16.h),
              const Divider(color: Color(0xffD9D9D9)),
              SizedBox(height: 8.h),
              Text(
                "Products",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),

              /// --- Dynamic Product List ---
              ...widget.products.map(
                (p) => buildStatusCard(
                  title: p.styleName!.categoryName,
                  status: p.productStatus.toString(),
                  quantity: p.quantity,
                  price: p.price,

                  materialImages:
                      [
                        p.materialImage1,
                        p.materialImage2,
                        p.materialImage3,
                      ].whereType<String>().toList(),

                  referenceImages:
                      [
                        p.addImage1,
                        p.addImage2,
                        p.addImage3,
                      ].whereType<String>().toList(),
                  drawnImages:
                      [
                        p.productImage1,
                        p.productImage2,
                        p.productImage3,
                      ].whereType<String>().toList(),
                  shopName: widget.orderShop,
                  shopId: widget.shopId,
                  orderId: p.id,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget inProgress({required bool completed}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    decoration: BoxDecoration(
      color:
          completed
              ? const Color(0xFFC8FFF4)
              : const Color(0xffFFEBB2), // Light yellow
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      completed ? "Completed" : 'In Progress',
      style: GoogleFonts.inter(fontSize: 12.0.sp, color: Colors.black),
    ),
  );
}

Widget buildStatusCard({
  required String title,
  required List<String> materialImages,
  required List<String> referenceImages,
  required List<String> drawnImages,
  required String status,
  required dynamic quantity,
  required dynamic price,
  required dynamic shopName,
  required dynamic shopId,
  required dynamic orderId,
}) {
  final Color statusBgColor =
      status == 'completed'
          ? const Color(0xFFC8FFF4) // Completed - teal
          : const Color(0xFFFFE2AD); // In progress - light orange
  final Color outline =
      status == 'completed'
          ? const Color(0xFF3BFF98) // Completed - teal
          : const Color(0xFFFFCB85); // In progress - light orange

  return GestureDetector(
    onTap: () {
      Get.to(
        OrderedItems(
          product_name: title,
          materialImages: materialImages,
          referenceImages: referenceImages,
          drawnImages: drawnImages,
          shopId: shopId,
          shopName: shopName,
          orderId: orderId,
          price: price,
          quantity: quantity,
        ),
      );
    },
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.tab_bar_bg, // Card background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.0.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                quantity,
                style: GoogleFonts.inter(
                  fontSize: 12.0.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            "₹$price",
            style: GoogleFonts.inter(
              fontSize: 16.0.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
          //   decoration: BoxDecoration(
          //     color: statusBgColor,
          //     borderRadius: BorderRadius.circular(20.r),
          //     border: Border.all(color: outline),
          //   ),
          //   child: Text(
          //     status,
          //     style: GoogleFonts.inter(fontSize: 12.0.sp, color: Colors.black),
          //   ),
          // ),
        ],
      ),
    ),
  );
}
