import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CallScreen extends StatelessWidget {
  final String name;
  final String status;
  final String imageUrl;

  const CallScreen({
    super.key,
    required this.name,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              status,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.h),
            CircleAvatar(
              radius: 70.r,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ],
        ),
      );

  }
}
