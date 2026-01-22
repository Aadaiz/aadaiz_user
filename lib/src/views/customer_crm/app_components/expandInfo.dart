import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/model/customer_orders.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/screens/ordered_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandInfo extends StatelessWidget {
  final String orderNumber;
  final String date;
  final int itemCount;
  final String shopName;
  final String shopAddress;
  final dynamic freeServiceDays;

  const ExpandInfo({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.itemCount,
    required this.shopName,
    required this.shopAddress,
    required this.freeServiceDays,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

      child: ExpansionTile(
        title: Text(
          'Order Details',
          style: GoogleFonts.montserrat(
            fontSize: 18.0.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          _buildDetailRow('Order Number', orderNumber),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Order date', date),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Items', itemCount.toString()),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Shop Name', shopName ?? ""),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Shop Address', shopAddress ?? ""),
          SizedBox(height: 20.h),
          if(freeServiceDays!='0'||freeServiceDays!=null||freeServiceDays!='')
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Free Service Days', freeServiceDays ?? ""),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.0.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600
          ),
        ),

        const Spacer(),

        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(
                fontSize: 14.0.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey[300], thickness: 1, height: 0);
  }
}

class ExpandItems extends StatelessWidget {
  final List<OrderProduct> products;
  final String shopId;
  final String orderShop;

  const ExpandItems({
    super.key,
    required this.products,
    required this.shopId,
    required this.orderShop
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          'Items',
          style: GoogleFonts.montserrat(
            fontSize: 18.0.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        childrenPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        children: [
          ...products.map(
                (p) => buildStatusCard(
              title: p.styleName!.categoryName ?? '',
              status: p.productStatus.toString(),
              quantity: p.quantity,
              price: p.price,
              materialImages: [
                p.materialImage1,
                p.materialImage2,
                p.materialImage3,
              ].whereType<String>().toList(),
              referenceImages: [
                p.addImage1,
                p.addImage2,
                p.addImage3,
              ].whereType<String>().toList(),
              drawnImages: [
                p.productImage1,
                p.productImage2,
                p.productImage3,
              ].whereType<String>().toList(),
              shopName: orderShop,
              shopId: shopId,
              orderId: p.id,
            ),
          ),
        ],
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
        ? const Color(0xFFC8FFF4)
        : const Color(0xFFFFE2AD);

    final Color outline =
    status == 'completed'
        ? const Color(0xFF3BFF98)
        : const Color(0xFFFFCB85);

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
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 15.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.tab_bar_bg,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.capitalizeFirst??'',
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

            // Status chip (currently unused)
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
            //   decoration: BoxDecoration(
            //     color: statusBgColor,
            //     borderRadius: BorderRadius.circular(20.r),
            //     border: Border.all(color: outline),
            //   ),
            //   child: Text(
            //     status,
            //     style: GoogleFonts.inter(
            //       fontSize: 12.0.sp,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 0,
    );
  }
}

