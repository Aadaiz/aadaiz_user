import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/last_step_create_jobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({super.key});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController openingsController = TextEditingController(
    text: "1",
  );
  final TextEditingController localityController = TextEditingController();

  int genderIndex = -1;
  int qualificationIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedValues = List.generate(jobTypes.length, (index) => false);
  }

  List<String> genders = ["Any", "Male", "Female"];

  List<String> qualifications = [
    "Any",
    "10th Pass",
    "12th Pass",
    "Diploma",
    "Graduate",
    "Post Graduate",
  ];
  List<String> jobTypes = ['Full Time', 'Part Time', 'Internship', 'Remote'];
  List<String> jobTitles = [
    "UI UX Designer",
    "Flutter Developer",
    "Backend Developer",
    'UI UX Designer',
    'Flutter Developer',
    'Backend Developer'
        'UI UX Designer',
    'Flutter Developer',
    'Backend Developer',
  ];
  List<String> jobLocalities = ['Chennai', "Coimbatore"];
  bool isJobTitleSelected = false;
  bool isJobCategorySelected = false;
  bool isJobLocalitySelected = false;

  List<bool> selectedValues = [];
  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: "Jobs"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Your Job posts !",
              style: GoogleFonts.dmSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              labelName: "Job Title",
              hintName: "UI UX Designer",
              controller: jobTitleController,
              suffixIcon:
                  jobTitleController.text.isNotEmpty
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            jobTitleController.text = '';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(color: AppColor.red, width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            color: AppColor.red,
                            size: 12,
                          ),
                        ),
                      )
                      : const Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () {
                setState(() {
                  isJobTitleSelected = !isJobTitleSelected;
                });
              },
            ),
            if (isJobTitleSelected)
              Column(
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.textFieldBorderColor),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      separatorBuilder:
                          (context, index) => const Divider(height: 0),
                      itemCount: jobTitles.length,
                      itemBuilder: (context, index) {
                        final jobTitle = jobTitles[index];
                        return ListTile(
                          title: Text(jobTitle),
                          onTap: () {
                            jobTitleController.text = jobTitle;
                            setState(() {
                              isJobTitleSelected = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

            SizedBox(height: screenHeight * 0.01),

            CommonTextFieldTwo(
              labelName: "Job Category",
              hintName: "Selected Option",
              controller: categoryController,
              suffixIcon:
                  categoryController.text.isNotEmpty
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            categoryController.text = '';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(color: AppColor.red, width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            color: AppColor.red,
                            size: 12,
                          ),
                        ),
                      )
                      : const Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () {
                setState(() {
                  isJobCategorySelected = !isJobCategorySelected;
                });
              },
            ),
            if (isJobCategorySelected)
              Column(
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.textFieldBorderColor),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      separatorBuilder:
                          (context, index) => const Divider(height: 0),
                      itemCount: jobTitles.length,
                      itemBuilder: (context, index) {
                        final jobTitle = jobTitles[index];
                        return ListTile(
                          title: Text(jobTitle),
                          onTap: () {
                            categoryController.text = jobTitle;
                            setState(() {
                              isJobCategorySelected = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

            SizedBox(height: screenHeight * 0.01),

            Text(
              "Number Of Openings *",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            SizedBox(
              width: screenWidth * 0.15,
              child: CommonTextFieldTwo(
                controller: openingsController,
                keyboardType: TextInputType.number,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Text(
              "Job Type",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: jobTypes.length,
                  itemBuilder: (context, index) {
                    final jobType = jobTypes[index];

                    return _jobTypeItem(jobType, selectedValues[index], () {
                      setState(() {
                        selectedValues[index] = !selectedValues[index];
                      });
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.01),

            CommonTextFieldTwo(
              labelName: "Job Locality",
              hintName: "Locality",
              controller: localityController,
              suffixIcon:
                  localityController.text.isNotEmpty
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            localityController.text = '';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            border: Border.all(color: AppColor.red, width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            color: AppColor.red,
                            size: 12,
                          ),
                        ),
                      )
                      : const Icon(Icons.keyboard_arrow_down),
              readOnly: true,
              onTap: () {
                setState(() {
                  isJobLocalitySelected = !isJobLocalitySelected;
                });
              },
            ),
            if (isJobLocalitySelected)
              Column(
                children: [
                  Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.textFieldBorderColor),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      separatorBuilder:
                          (context, index) => const Divider(height: 0),
                      itemCount: jobLocalities.length,
                      itemBuilder: (context, index) {
                        final jobLocalitiesData = jobLocalities[index];
                        return ListTile(
                          title: Text(jobLocalitiesData),
                          onTap: () {
                            localityController.text = jobLocalitiesData;
                            setState(() {
                              isJobLocalitySelected = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            SizedBox(height: screenHeight * 0.01),

            Text(
              "Gender",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            Wrap(
              spacing: 8,
              children: List.generate(
                genders.length,
                (index) => _selectionChip(
                  'gender',
                  genders[index],
                  genderIndex == index,
                  () {
                    setState(() {
                      genderIndex = index;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            Text(
              "Qualification Required *",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                qualifications.length,
                (index) => _selectionChip(
                  'qualification',
                  qualifications[index],
                  qualificationIndex == index,
                  () {
                    setState(() {
                      qualificationIndex = index;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            CommonButton(
              press: () {

                Get.to(()=>LastStepCreateJob(),transition: Transition.rightToLeft);
              },
              text: "Next",
              borderRadius: 0.0,
              height: screenHeight * 0.045,
            ),

            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _jobTypeItem(String title, bool value, VoidCallback? onTap) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColor.minusColor,
          value: value,
          onChanged: (val) {
            onTap?.call();
          },
        ),
        Text(title, style: GoogleFonts.dmSans(fontSize: 13.sp)),
      ],
    );
  }

  Widget _selectionChip(
    String type,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.grey.shade300 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(fontSize: 12.sp, color: Colors.black),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  setState(() {
                  type=='gender'?genderIndex=-1:qualificationIndex=-1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.red, width: 2),
                  ),
                  child: const Icon(Icons.close, size: 12),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
