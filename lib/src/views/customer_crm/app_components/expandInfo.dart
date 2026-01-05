import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandInfo extends StatelessWidget {
  final String orderNumber;
  final String date;
  final int itemCount;
  final String shopName;
  final String shopAddress;


  const ExpandInfo({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.itemCount,
    required this.shopName,
    required this.shopAddress,
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
          _buildDetailRow('Order date', date),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Items', itemCount.toString()),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Shop Name', shopName??""),  SizedBox(height: 20.h),
          _buildDetailRow('Shop Address', shopAddress??""),
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
            fontSize: 12.0.sp,
            color: Colors.grey[600],
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
                fontSize: 12.0.sp,
                color: Colors.black,
              ),
            ),
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
