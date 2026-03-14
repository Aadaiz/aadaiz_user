import 'dart:math' as math;

import 'package:aadaiz_customer_crm/src/res/components/event_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/jobs_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/create_event_screen.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_filter.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_view_screen.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  JobsController controller = Get.find<JobsController>();

  List<Map<String, dynamic>> jobList = [
    {
      "title": "UiUx Designer",
      "subTitle": 'Aadaiz',
      "jobDetails": ["Full Time", "Senior Level", "Remote"],
      "time": "1 hours ago",
      'isApplied':true
    },
    {
      "title": "Flutter Developer",
      "subTitle": 'infosis',

      "jobDetails": ["Full Time", "Mid Level", "Hybrid"],
      "time": "3 hours ago",
      'isApplied':false
    },
    {
      "title": "Backend Developer",
      'subTitle': 'infosis',

      "jobDetails": ["Part Time", "Senior Level", "Remote"],
      "time": "5 hours ago",
      'isApplied':true
    },
  ];

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
              suffixWidget: InkWell(
                onTap: () {
                  Get.to(
                    () => const EventFilter(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.featureSelected.value = true;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                controller.featureSelected.value == true
                                    ? Border.all(color: AppColor.primary)
                                    : null,
                          ),
                          child: Text(
                            "Recent Jobs",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.07),
                      InkWell(
                        onTap: () {
                          controller.featureSelected.value = false;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                controller.featureSelected.value == false
                                    ? Border.all(color: AppColor.primary)
                                    : null,
                          ),
                          child: Text(
                            "Your Jobs",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value == false
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const CreateEventScreen(),
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
            SizedBox(height: screenHeight * 0.03),
            if (controller.featureSelected.value == true)
              Expanded(
                child: ListView.builder(
                  itemCount: jobList.length,
                  itemBuilder: (context, index) {
                    final data = jobList[index];
                    return JobsCard(
                      title: data['title'],
                      subTitle: data['subTitle'],
                      time: data['time'],
                      jobs: data['jobDetails'],
                      isApplied: data['isApplied'],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
