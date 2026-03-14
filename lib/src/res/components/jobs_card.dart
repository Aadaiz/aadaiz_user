import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String time;
  final List<String> jobs;
  final bool isApplied;

  const JobsCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.jobs,
    required this.isApplied,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: const EdgeInsets.all(12),
      decoration:  BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(2, 2),
        ),
      ],),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary.withAlpha(30),
                ),
                width: screenWidth * 0.12,
                height: screenHeight * 0.06,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.business_sharp),
                ),
              ),

              SizedBox(width: screenWidth * 0.02),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textFieldLabelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.01),

          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                jobs.map((detail) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.jobDetailContainerBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      detail,
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                    ),
                  );
                }).toList(),
          ),

          SizedBox(height: screenHeight * 0.015),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: GoogleFonts.dmSans(fontSize: 11.sp, color: Colors.grey,fontWeight: FontWeight.w500),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.017,
                  vertical: screenHeight * 0.002,
                ),
                decoration: BoxDecoration(
                  color: isApplied == true ? Colors.green : AppColor.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: screenWidth * 0.25,
                height: screenHeight * 0.035,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isApplied == true)
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.green,
                        ),
                      ),
                    if (isApplied == true) SizedBox(width: screenWidth * 0.01),
                    Text(
                      isApplied == true ? 'Applied' : 'Apply Now',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
