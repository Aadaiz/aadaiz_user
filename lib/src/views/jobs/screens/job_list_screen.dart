import 'dart:math' as math;

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/components/jobs_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/create_jobs.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/job_detail_screen.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/job_filter.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/my_applicant_view_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  JobsController controller = Get.find<JobsController>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: 'Jobs'),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04),

            SearchField(
              hintText: "Search Jobs",
              showSuffix: true,
              onChanged: (val) {
                controller.getJobData(false, search: val);
              },
              suffixWidget: InkWell(
                onTap: () {
                  Get.to(
                    () => const JobFilter(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.tune),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 5,

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => SizedBox(
                      width: screenWidth * 0.7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTab("Recent Jobs", "recent_jobs"),

                            const SizedBox(width: 12),
                            _buildTab("Our Jobs", "our_jobs"),
                            const SizedBox(width: 12),
                            _buildTab("Applied Jobs", "applied_jobs"),
                            const SizedBox(width: 12),
                            _buildTab("My Applicants", "my_job_applicants"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(
                        () => const CreateJobScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(7, 2, 3, 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColor.primary),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Hire',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColor.primary,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Container(
                            width: screenWidth * 0.06,
                            height: screenWidth * 0.06,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primary,
                            ),
                            child: Center(
                              child: Transform.rotate(
                                angle: 160 * math.pi / 72,

                                child: Icon(
                                  Icons.arrow_upward,
                                  color: AppColor.white,
                                  size: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            Obx(() {
              final isApplicantsTab =
                  controller.selectedJobType.value == 'my_job_applicants';
              final isLoading = controller.getJobListDataLoading.value;
              final bool isEmpty =
                  isApplicantsTab
                      ? controller.applicantsData.isEmpty
                      : controller.jobListData.isEmpty;

              if (isLoading) {
                return const Expanded(child: ShimmerList());
              }

              if (isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No Data Found')),
                );
              }

              return Expanded(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  onRefresh: () => controller.getJobData(true),
                  onLoading: () => controller.getJobData(false),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 2),
                    itemCount:
                        isApplicantsTab
                            ? controller.applicantsData.length
                            : controller.jobListData.length,
                    itemBuilder: (context, index) {
                      if (isApplicantsTab) {
                        final applicant = controller.applicantsData[index];
                        return ApplicantCard(
                          name: applicant.user?.username ?? 'User',
                          role: applicant.job?.jobTitle ?? '',
                          time: applicant.timeAgo ?? '',
                          skills: [],
                          onAccept: () {},
                          onReject: () {},
                          onTap: () {
                            Get.to(
                              () => MyApplicantViewDetail(data: applicant),
                              transition: Transition.rightToLeft,
                            );
                          },
                        );
                      } else {
                        final data = controller.jobListData[index];

                        if (controller.selectedJobType.value == 'our_jobs') {
                          return Obx(
                            () => YourJobCard(
                              title: data.jobTitle ?? '',
                              subTitle: data.companyName ?? '',
                              time: data.timeNow ?? '',
                              jobs: [
                                _getJobType(data.jobType),
                                data.qualification ?? '',
                              ],
                              isApplied: data.jobStatus ?? '',
                              deleteOnTap: () {
                                controller.deleteJob(data.id);
                              },
                              editOnTap: () {
                                Get.to(
                                  CreateJobScreen(isEdit: true, data: data),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              isLoading:
                                  controller.deletingJobId.value == data.id,
                            ),
                          );
                        } else if (controller.selectedJobType.value ==
                            'recent_jobs') {
                          return JobsCard(
                            onTap: () {
                              Get.to(
                                () => JobDetailScreen(data: data),
                                transition: Transition.rightToLeft,
                              );
                            },
                            title: data.jobTitle ?? '',
                            subTitle: data.companyName ?? '',
                            time: data.timeNow ?? '',
                            jobs: [
                              _getJobType(data.jobType),
                              data.qualification ?? '',
                            ],
                            isApplied: false,
                          );
                        } else if (controller.selectedJobType.value ==
                            'applied_jobs') {
                          return AppliedJobCard(
                            title: data.jobTitle ?? '',
                            company: data.companyName ?? '',
                            time: data.timeNow ?? '',
                            jobs: [
                              _getJobType(data.jobType),
                              data.qualification ?? '',
                            ],
                            status: data.jobStatus ?? 'applied',
                            onTap: () {

                            },
                          );
                        }
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getJobType(String? type) {
    switch (type) {
      case 'full_time':
        return 'Full Time';
      case 'part_time':
        return 'Part Time';
      case 'internship':
        return 'Internship';
      case 'remote':
        return 'Remote';
      default:
        return '';
    }
  }

  Widget _buildTab(String title, String value) {
    return InkWell(
      onTap: () {
        controller.selectedJobType.value = value;
        controller.getJobData(true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border:
              controller.selectedJobType.value == value
                  ? Border.all(color: AppColor.primary)
                  : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color:
                controller.selectedJobType.value == value
                    ? AppColor.black
                    : AppColor.textFieldLabelColor,
          ),
        ),
      ),
    );
  }
}
