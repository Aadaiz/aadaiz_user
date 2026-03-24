import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
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
  final Function()? onTap;

  const JobsCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.jobs,
    required this.isApplied,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.02,
          left: screenWidth * 0.02,
          right: screenWidth * 0.02,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(30),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),

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
                  style: GoogleFonts.dmSans(
                    fontSize: 11.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
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
                      if (isApplied == true)
                        SizedBox(width: screenWidth * 0.01),
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
      ),
    );
  }
}

class YourJobCard extends StatelessWidget {
  final bool? isLoading;
  final String title;
  final String subTitle;
  final String time;
  final List<String> jobs;
  final String? isApplied;
  final Function()? editOnTap;
  final Function()? deleteOnTap;

  const YourJobCard({
    super.key,
    this.isLoading,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.jobs,
    this.isApplied,
    this.editOnTap,
    this.deleteOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: screenHeight * 0.02,
        left: screenWidth * 0.02,
        right: screenWidth * 0.02,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),

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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.017,
                  vertical: screenHeight * 0.002,
                ),
                decoration: BoxDecoration(
                  color: isApplied == 'approved' ? Colors.green : AppColor.minusColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: screenWidth * 0.25,
                height: screenHeight * 0.035,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isApplied == 'approved')
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
                    if (isApplied == 'approved')
                      SizedBox(width: screenWidth * 0.01),
                    Text(
                      isApplied == 'approved' ? 'Approved' : 'Pending',
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
                style: GoogleFonts.dmSans(
                  fontSize: 11.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),

          Row(
            children: [
              InkWell(
                onTap: editOnTap,
                child: Container(
                  width: screenWidth / 2.5,
                  height: screenHeight * 0.045,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.borderGrey),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Edit',
                    style: GoogleFonts.dmSans(
                      fontSize: 12.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  width: screenWidth / 2.5,
                  height: screenHeight * 0.045,
                  child: CommonButton(
                    loading: isLoading,
                    press: () {
                      deleteOnTap!();
                    },
                    text: 'Delete Post',
                    borderRadius: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppliedJobCard extends StatelessWidget {
  final String title;
  final String company;
  final String time;
  final List<String> jobs;
  final String status; // applied / rejected / shortlisted
  final VoidCallback? onTap;

  const AppliedJobCard({
    super.key,
    required this.title,
    required this.company,
    required this.time,
    required this.jobs,
    required this.status,
    this.onTap,
  });

  Color getStatusColor() {
    switch (status) {
      case 'shortlisted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String getStatusText() {
    switch (status) {
      case 'shortlisted':
        return 'Shortlisted';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Applied';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.getActivityScreenHeight(context);
    final screenWidth = Utils.getActivityScreenWidth(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  width: screenWidth * 0.12,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary.withAlpha(30),
                  ),
                  child: const Icon(Icons.work),
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
                        company,
                        style: GoogleFonts.dmSans(
                          fontSize: 13.sp,
                          color: AppColor.textFieldLabelColor,
                        ),
                      ),
                    ],
                  ),
                ),

                /// STATUS BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    getStatusText(),
                    style: GoogleFonts.dmSans(
                      fontSize: 11.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.01),

            /// JOB TAGS
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children:
                  jobs.map((e) {
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
                        e,
                        style: GoogleFonts.dmSans(fontSize: 12.sp),
                      ),
                    );
                  }).toList(),
            ),

            SizedBox(height: screenHeight * 0.015),

            /// FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: GoogleFonts.dmSans(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),

                /// Optional withdraw
                if (status == 'applied')
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Withdraw",
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
  final String name;
  final String role;
  final String time;
  final List<String> skills;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const ApplicantCard({
    super.key,
    required this.name,
    required this.role,
    required this.time,
    required this.skills,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.getActivityScreenHeight(context);
    final screenWidth = Utils.getActivityScreenWidth(context);

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColor.primary.withAlpha(30),
                child: const Icon(Icons.person),
              ),

              SizedBox(width: screenWidth * 0.02),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.dmSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      role,
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        color: AppColor.textFieldLabelColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.01),

          /// SKILLS
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                skills.map((e) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.jobDetailContainerBg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(e, style: GoogleFonts.dmSans(fontSize: 12.sp)),
                  );
                }).toList(),
          ),

          SizedBox(height: screenHeight * 0.015),

          /// TIME
          Text(
            time,
            style: GoogleFonts.dmSans(fontSize: 11.sp, color: Colors.grey),
          ),

          SizedBox(height: screenHeight * 0.015),

          /// ACTIONS
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onReject,
                  child: Container(
                    height: screenHeight * 0.045,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                    ),
                    child: Text(
                      "Reject",
                      style: GoogleFonts.dmSans(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: screenWidth * 0.03),

              Expanded(
                child: CommonButton(
                  height: screenHeight * 0.045,
                  press: () {
                    onAccept!();
                  },
                  text: "Accept",
                  borderRadius: 0.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
