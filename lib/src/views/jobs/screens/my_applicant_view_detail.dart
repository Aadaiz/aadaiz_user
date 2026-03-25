import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApplicantViewDetail extends StatefulWidget {
  final Applicant? data;
  const MyApplicantViewDetail({super.key, this.data});

  @override
  State<MyApplicantViewDetail> createState() => _MyApplicantViewDetailState();
}

class _MyApplicantViewDetailState extends State<MyApplicantViewDetail> {
  bool _isDownloading = false;

  Future<void> _openResume(String url) async {
    if (_isDownloading) return;
    _isDownloading = true;
    setState(() {});

    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File(
          '${dir.path}/resume_${DateTime.now().millisecondsSinceEpoch}.pdf',
        );
        await file.writeAsBytes(response.data);
        await OpenFilex.open(file.path);
      } else {
        Get.snackbar('Error', 'Failed to download resume');
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not open resume');
    } finally {
      _isDownloading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final applicant = widget.data;
    final resumeUrl = applicant?.resume ?? '';
    final fileName = resumeUrl.split('/').last;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: 'Applicant Details',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32.r,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.person,
                    size: 32.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicant?.user?.username ?? 'Unknown User',
                        style: GoogleFonts.dmSans(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        applicant?.job?.jobTitle ?? 'No job title',
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _getStatusColor(applicant?.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                _getStatusText(applicant?.status),
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(applicant?.status),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14.sp,
                  color: Colors.grey.shade600,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Applied: ${applicant?.timeAgo ?? 'Unknown'}',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            if (applicant?.information?.isNotEmpty == true) ...[
              Text(
                'Message',
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  applicant?.information ?? '',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],

            if (resumeUrl.isNotEmpty) ...[
              Text(
                'Resume',
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _isDownloading ? null : () => _openResume(resumeUrl),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.picture_as_pdf,
                          color: AppColor.primary,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fileName,
                              style: GoogleFonts.dmSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Tap to view',
                              style: GoogleFonts.dmSans(
                                fontSize: 10.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _isDownloading
                          ? SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColor.primary,
                            ),
                          )
                          : Icon(
                            Icons.open_in_new,
                            color: Colors.grey.shade500,
                            size: 18.sp,
                          ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'applied':
        return Colors.orange;
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'applied':
        return 'Applied';
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      default:
        return status?.toUpperCase() ?? 'Unknown';
    }
  }
}
