import 'dart:ui';

import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String image;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
      height: screenHeight * 0.23,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withAlpha(100), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),

          Positioned(
            left: 10,
            bottom: 10,
            right: 20,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(50),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(1),
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white.withAlpha(51),
                    border: Border.all(
                      color: Colors.white.withAlpha(17),

                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white, size: 14),

                              const SizedBox(width: 5),

                              Text(
                                date,
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),

                              const SizedBox(width: 10),

                              const Icon(Icons.access_time,
                                  color: Colors.white, size: 14),

                              const SizedBox(width: 5),

                              Text(
                                time,
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      InkWell(
                        onTap: onTap,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                size: 18,
                                color: AppColor.primary,
                              ),
                              Text(
                                "View",
                                style: GoogleFonts.dmSans(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
