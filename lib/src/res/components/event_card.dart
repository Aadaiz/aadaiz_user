import 'dart:ui';

import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

    return InkWell(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
class YourEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String image;
  final String status;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback ontap;
  final bool editLoading;


  const YourEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.image,
    required this.status,
    required this.onEdit,
    required this.onDelete,
    required this.ontap,
    required this.editLoading,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);

    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.025),
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withAlpha(30),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child:CachedNetworkImage(
                  imageUrl:   image,
                    width: double.infinity,
                    height: screenHeight * 0.18,
                    fit: BoxFit.cover,
                  ),
                ),


                Positioned(
                  left: 10,
                  bottom: 10,
                  child: ClipRRect(

                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColor.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white.withAlpha(70)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              status.capitalizeFirst!,
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            CircleAvatar(
                              radius: 3,
                              backgroundColor:status=='approved'?Colors.green: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: screenHeight * 0.015),


            Text(
              title,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: screenHeight * 0.008),


            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
                const SizedBox(width: 18),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 6),
                Text(
                  time,
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.018),


            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onEdit,
                    child: Container(
                      height: screenHeight*0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:Text(
                        "Edit",
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                Expanded(
                  child: InkWell(
                    onTap: onDelete,
                    child: Container(
                      height: screenHeight*0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:editLoading? SizedBox(
                        height: 03.00.hp,
                        width: 5.00.hp,
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: AppColor.primary,
                          size: 5.00.hp,
                        ),
                      )
                          : Text(
                        "Delete Event",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}