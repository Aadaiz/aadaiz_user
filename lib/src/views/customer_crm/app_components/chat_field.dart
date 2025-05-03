import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: GoogleFonts.montserrat(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Image.asset("assets/images/cam.png",height: 23.h,width: 24.h,) ,
                  SizedBox(width: 12.w,),
                  Image.asset("assets/images/cam2.png",height: 20.h,width: 24.h,)
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xFF0D174D),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
