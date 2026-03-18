import 'dart:ui';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _descriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showApplyBottomSheet() {
    showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ApplyBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: 'Job Details',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildJobHeader(screenWidth, screenHeight),
                  _buildJobDescriptionTab(screenWidth, screenHeight),
                ],
              ),
            ),
          ),
          _buildApplyButton(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget _buildJobHeader(double screenWidth, double screenHeight) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        screenWidth * 0.04,
        screenHeight * 0.02,
        screenWidth * 0.04,
        screenHeight * 0.00,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildCompanyLogo(),
              SizedBox(width: screenWidth * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fashion Designer',
                    style: GoogleFonts.dmSans(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.002),
                  Text(
                    'Aadaiz',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.018),
          Row(
            children: [
              _buildTag('Fulltime', screenWidth),
              SizedBox(width: screenWidth * 0.02),
              _buildTag('Senior Level', screenWidth),
              SizedBox(width: screenWidth * 0.02),
              _buildTag('Remote', screenWidth),
            ],
          ),
          SizedBox(height: screenHeight * 0.012),
          Text(
            '12 hours ago',
            style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyLogo() {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: AppColor.black,

        shape: BoxShape.circle,
      ),

      alignment: Alignment.center,
      child: const Icon(Icons.business_sharp, color: Colors.white),

    );
  }

  Widget _buildTag(String label, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: 5.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.jobDetailContainerBg,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 12.sp,
         
        ),
      ),
    );
  }

  Widget _buildJobDescriptionTab(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Job Description'),
              SizedBox(height: screenHeight * 0.012),
              AnimatedCrossFade(
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sed ut perspiciatis under omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem ...',
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        color:Colors.grey,
                        fontWeight: FontWeight.w400,

                       
                        height: 1.6,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () => setState(() => _descriptionExpanded = true),
                      child: Text(
                        'Read more..',
                        style: GoogleFonts.dmSans(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione sequi nesciunt.',
                      style: GoogleFonts.dmSans(
                        fontSize: 13.5.sp,
                       
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () => setState(() => _descriptionExpanded = false),
                      child: Text(
                        'Show less',
                        style: GoogleFonts.dmSans(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                crossFadeState:
                    _descriptionExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Requirements'),
              SizedBox(height: screenHeight * 0.012),
              _bulletPoint(
                'Create Visual Designs And Graphics For Print Or Digital Media And Websites',
                screenWidth,
              ),
              SizedBox(height: screenHeight * 0.007),
              _bulletPoint(
                "Provide Creative Ideas As Per Company's Requirements",
                screenWidth,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Skills'),
              SizedBox(height: screenHeight * 0.012),
              Wrap(
                spacing: screenWidth * 0.02,
                runSpacing: screenHeight * 0.01,
                children:
                    [
                      'UI UX',
                      'Product Design',
                      'Web Designing',
                    ].map((s) => _skillChip(s, screenWidth)).toList(),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Working Days'),
              SizedBox(height: screenHeight * 0.012),
              _skillChip('5 Days Working', screenWidth),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle('Call HR'),
              SizedBox(height: screenHeight * 0.012),
              Row(
                children: [
                  Icon(Icons.phone, size: 16.sp, ),
                  SizedBox(width: screenWidth * 0.015),
                  Text(
                    '+91 123 456 7890',
                    style: GoogleFonts.dmSans(
                      color: AppColor.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.035,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      textStyle: GoogleFonts.dmSans(fontSize: 12.sp),
                    ),
                    child: const Text('Connect With HR'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton(double screenWidth, double screenHeight) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        screenWidth * 0.04,
        screenHeight * 0.015,
        screenWidth * 0.04,
        screenHeight * 0.03,
      ),
      child: CommonButton(
        press: _showApplyBottomSheet,
        height: 40.h,
        width: double.infinity,
        text: 'Apply',
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.dmSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        
      ),
    );
  }

  Widget _bulletPoint(String text, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Icon(Icons.circle, size: 6.sp, ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
             
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _skillChip(String label, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.035,
        vertical: 7.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.containerDividerColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 12.sp,
        
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ApplyBottomSheet extends StatefulWidget {
  const ApplyBottomSheet({super.key});

  @override
  State<ApplyBottomSheet> createState() => _ApplyBottomSheetState();
}

class _ApplyBottomSheetState extends State<ApplyBottomSheet> {
  final TextEditingController _infoController = TextEditingController();
  bool _fileUploaded = false;
  final bool _isDragging = false;

  void _simulateUpload() {
    setState(() => _fileUploaded = true);
  }

  void _removeFile() {
    setState(() => _fileUploaded = false);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.70,
      minChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 4.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.05,
                  12.h,
                  screenWidth * 0.02,
                  4.h,
                ),
                child: Row(
                  children: [
                    Text(
                      'Upload Resume',
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColor.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: AppColor.red,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05,
                    4.h,
                    screenWidth * 0.05,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Upload Area
                      _fileUploaded
                          ? _buildFileAttached(screenWidth, screenHeight)
                          : _buildUploadArea(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.03),
                      // Information
                      Text(
                        'Information',
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                         
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      TextField(
                        controller: _infoController,
                        maxLines: 5,
                        style: GoogleFonts.dmSans(fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText:
                              'Explain why you are the right person for this job',
                          hintStyle: GoogleFonts.dmSans(
                            color: Colors.grey.shade400,
                            fontSize: 11.5.sp,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                           
                          ),
                          contentPadding: EdgeInsets.all(14.w),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.035),
                    ],
                  ),
                ),
              ),
              // Apply Button
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: CommonButton(
                  press: () {},
                  height: 40.h,
                  width: double.infinity,
                  text: 'Apply',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUploadArea(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: _simulateUpload,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 140.h,
        decoration: BoxDecoration(
          color: _isDragging ? AppColor.primary.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: AppColor.primary.withOpacity(0.25),
            width: 1.5,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cloud_upload_outlined,
                  size: 30.sp,
                  color: AppColor.primary,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              Text(
                'Upload Your Resume',
                style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                'PDF, DOC up to 10MB',
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileAttached(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.red.withOpacity(0.05),
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.picture_as_pdf, color: AppColor.red, size: 26.sp),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Josh – CV – UI/UX Designer',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  '867 Kb · 14 Feb 2022 at 11:30 am',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColor.primary.withOpacity(0.25)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final radius = Radius.circular(14.r);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      radius,
    );

    final path = Path()..addRRect(rrect);
    final dashPath = Path();
    double distance = 0;

    for (final PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) => false;
}
