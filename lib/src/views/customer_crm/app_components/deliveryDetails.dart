import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryDetails extends StatelessWidget {
  final String address;
  final String name;
  final String email;
  final String phone;

  const DeliveryDetails({
    super.key,
    required this.address,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          'Delivery Details',
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
          _buildMultilineRow('Address', address),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Name', name),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Email', email),
          SizedBox(height: 20.h),
          _divider(),
          SizedBox(height: 20.h),
          _buildDetailRow('Phone', phone),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 12.0.sp,
            color: Colors.grey[600],
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.montserrat(
              fontSize: 12.0.sp,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultilineRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 12.0.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.montserrat(
              fontSize: 12.0.sp,
              color: Colors.black,
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
