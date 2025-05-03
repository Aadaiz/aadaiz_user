import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandInfo extends StatelessWidget {
  final String orderNumber;
  final String date;
  final int itemCount;
  final String shopName;

  const ExpandInfo({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.itemCount,
    required this.shopName,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

      child: ExpansionTile(
        title: Text(
          'Order Details',
          style: GoogleFonts.montserrat(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w500,
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
          _buildDetailRow('Date', date),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Items', itemCount.toString()),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Shop Name', shopName??""),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 12.0.sp,
            color: Colors.grey[600],
          ),
        ),
        Text(
          "${value??""}",
          style: GoogleFonts.montserrat(
            fontSize: 12.0.sp,
            color: Colors.black,
          ),
        ),
      ],
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
