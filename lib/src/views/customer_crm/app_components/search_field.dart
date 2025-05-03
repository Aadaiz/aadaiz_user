
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class SearchOrdersField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchOrdersField({
    super.key,
    this.hintText = 'Search Orders',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 50,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
           SizedBox(width: 16.w),
          Image.asset(
              "assets/images/search.png",
            height: 17.7.h,
            width: 17.7.h,
          ),
           SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.nunitoSans(
                fontSize: 14.0.sp,
                color: Colors.black,
              ),
            ),
          ),
           SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
