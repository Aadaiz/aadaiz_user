import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_type_model.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/last_step_create_jobs.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart'
    as edit;

class CreateJobScreen extends StatefulWidget {
  final bool? isEdit;
  final edit.Datum? data;
  const CreateJobScreen({super.key, this.isEdit = false, this.data});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final TextEditingController localityController = TextEditingController();
  JobsController controller = Get.find();

  int genderIndex = -1;
  int qualificationIndex = -1;
  List<Subjob> selectedSubJobs = [];
  int selectedJobIndex = -1;
  final jobTypeMap = {
    'full_time': 'Full Time',
    'part_time': 'Part Time',
    'internship': 'Internship',
    'remote': 'Remote',
  };
  final jobModeMap = {'work_from_home': 'Work From Home', 'office': 'Office'};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      countries = await csc.getAllCountries();
    });
    selectedValues = List.generate(
      controller.jobTypes.length,
      (index) => false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isEdit == true) {
        controller.jobTitleController.text = widget.data?.jobTitle ?? "";
        controller.categoryController.text = widget.data?.jobCategory ?? "";
        controller.openingsController.text =
            widget.data?.numberOfOpenings ?? "";
        controller.jobDescriptionController.text =
            widget.data?.jobDescription ?? "";


        final selectedType = jobTypeMap[widget.data?.jobType] ?? '';

        controller.selectedJobType.value = selectedType;

        for (int i = 0; i < controller.jobTypes.length; i++) {
          selectedValues[i] = controller.jobTypes[i] == selectedType;
        }
        setState(() {});
        final selectedMode = jobModeMap[widget.data?.jobMode] ?? '';

        controller.selectedJobMode.value = selectedMode;

        for (int i = 0; i < controller.jobMode.length; i++) {
          selectedValues[i] = controller.jobMode[i] == selectedMode;
        }
        setState(() {});
        controller.countryController.text = widget.data?.jobCountry ?? "";
        controller.stateController.text = widget.data?.jobState ?? "";
        controller.cityController.text = widget.data?.jobCity ?? "";
        controller.areaController.text = widget.data?.jobArea ?? "";
        controller.pincodeController.text = widget.data?.jobPincode ?? "";

        controller.selectedGender.value = widget.data?.gender ?? "";
        controller.selectedQualification.value =
            widget.data?.qualification ?? "";
        widget.data?.companyName != null
            ? controller.companyNameController.text = widget.data!.companyName!
            : controller.companyNameController.text = '';
      } else {
        controller.clearAllFields();
      }
    });
  }

  List<String> jobLocalities = ['Chennai', "Coimbatore"];
  bool isJobTitleSelected = false;
  bool isJobCategorySelected = false;
  bool isJobLocalitySelected = false;
  String countryCode = '';
  List<csc.Country> countries = [];
  List<csc.State> states = [];
  List<csc.City> cities = [];

  List<bool> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () {
            controller.selectedJobType.value = 'our_jobs';
            controller.getJobData(false);
            Get.back();
          },
          title: "Jobs",
        ),
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
              labelName: 'Company Name',
              hintName: 'Company Name',
              controller: controller.companyNameController,
            ),
            CommonTextFieldTwo(
              labelName: "Job Title",
              hintName: "UI UX Designer",
              controller: controller.jobTitleController,
              suffixIcon:
                  controller.jobTitleController.text.isNotEmpty
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            controller.jobTitleController.clear();
                            controller.categoryController.clear();
                            selectedSubJobs.clear();
                            selectedJobIndex = -1;

                            isJobTitleSelected = false;
                            isJobCategorySelected = false;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(14),
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
                  isJobCategorySelected = false;
                });
              },
            ),

            if (isJobTitleSelected)
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColor.textFieldBorderColor),
                ),
                child: Obx(() {
                  if (controller.jobListLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder:
                        (context, index) => const Divider(height: 0),
                    itemCount: controller.jobData.length,
                    itemBuilder: (context, index) {
                      final job = controller.jobData[index];

                      return ListTile(
                        title: Text(job.jobTitle ?? ''),
                        onTap: () {
                          setState(() {
                            selectedJobIndex = index;
                            selectedSubJobs = List.from(job.subjobs ?? []);

                            controller.jobTitleController.text =
                                job.jobTitle ?? '';

                            controller.categoryController.clear();

                            isJobTitleSelected = false;
                            isJobCategorySelected = false;
                          });
                        },
                      );
                    },
                  );
                }),
              ),

            SizedBox(height: screenHeight * 0.015),

            CommonTextFieldTwo(
              labelName: "Job Category",
              hintName: "Selected Option",
              controller: controller.categoryController,
              suffixIcon:
                  controller.categoryController.text.isNotEmpty
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            controller.categoryController.clear();
                            isJobCategorySelected = false;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(14),
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
                if (selectedJobIndex == -1) {
                  CommonToast.show(msg: "Please select job title first");
                  return;
                }

                setState(() {
                  selectedSubJobs = List.from(
                    controller.jobData[selectedJobIndex].subjobs ?? [],
                  );

                  isJobCategorySelected = !isJobCategorySelected;
                  isJobTitleSelected = false;
                });
              },
            ),

            if (isJobCategorySelected)
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
                  itemCount: selectedSubJobs.length,
                  itemBuilder: (context, index) {
                    final subJob = selectedSubJobs[index];

                    return ListTile(
                      title: Text(subJob.jobCategory ?? ''),
                      onTap: () {
                        setState(() {
                          controller.categoryController.text =
                              subJob.jobCategory ?? '';
                          isJobCategorySelected = false;
                        });
                      },
                    );
                  },
                ),
              ),
            SizedBox(height: screenHeight * 0.01),

            Text(
              "Job Description",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            CommonTextFieldTwo(
              controller: controller.jobDescriptionController,
              maxLines: 4,
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
                controller: controller.openingsController,
                keyboardType: TextInputType.number,
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

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
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.jobTypes.length,
                    itemBuilder: (context, index) {
                      final jobType = controller.jobTypes[index];

                      return _jobTypeItem(
                        jobType,
                        controller.selectedJobType.value == jobType,
                        () {
                          setState(() {
                            controller.selectedJobType.value = jobType;
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
              "Job Mode",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Column(
              children: [
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.jobMode.length,
                    itemBuilder: (context, index) {
                      final jobMode = controller.jobMode[index];

                      return _jobTypeItem(
                        jobMode,
                        controller.selectedJobMode.value == jobMode,
                        () {
                          setState(() {
                            controller.selectedJobMode.value = jobMode;
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
              labelName: 'Job Location',
              readOnly: true,
              hintName: "Choose Country",
              controller: controller.countryController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.location_on),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: AppColor.white,

                      insetPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 16,
                      child: SizedBox(
                        height: Get.width * 0.85,
                        width: Get.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                'Country',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.greyTitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                height: Get.width * 0.68,
                                child:
                                    countries.isEmpty
                                        ? const Text('No countries found')
                                        : Expanded(
                                          child: ListView.separated(
                                            itemCount: countries.length,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                            itemBuilder: (context, index) {
                                              final data = countries[index];

                                              return InkWell(
                                                onTap: () async {
                                                  Get.back();
                                                  controller
                                                      .countryController
                                                      .text = data.name ?? '';
                                                  countryCode = data.isoCode;

                                                  states.clear();
                                                  cities.clear();
                                                  controller.stateController
                                                      .clear();
                                                  controller.cityController
                                                      .clear();

                                                  states = await csc
                                                      .getStatesOfCountry(
                                                        data.isoCode,
                                                      );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 16,
                                                        bottom: 8,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.name,
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                color:
                                                                    AppColor
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: screenHeight * 0.01),
            CommonTextFieldTwo(
              readOnly: true,
              hintName: "Choose State",
              controller: controller.stateController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.location_on),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: AppColor.white,

                      insetPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 16,
                      child: SizedBox(
                        height: Get.width * 0.85,
                        width: Get.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                'States',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.greyTitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                height: Get.width * 0.68,
                                child:
                                    states.isEmpty
                                        ? const Text('No cities found')
                                        : ListView.separated(
                                          separatorBuilder:
                                              (context, index) =>
                                                  const Divider(),
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: states.length,
                                          itemBuilder: (context, index) {
                                            final data = states[index];

                                            return InkWell(
                                              onTap: () async {
                                                debugPrint(
                                                  'State code :${data.isoCode}',
                                                );
                                                Get.back();
                                                controller
                                                    .stateController
                                                    .text = data.name ?? '';
                                                cities.clear();
                                                controller.cityController
                                                    .clear();

                                                cities = await csc
                                                    .getStateCities(
                                                      countryCode,
                                                      data.isoCode,
                                                    );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  bottom: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        data.name,
                                                        style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: screenHeight * 0.01),
            CommonTextFieldTwo(
              hintName: "Choose City",
              controller: controller.cityController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(Icons.location_on),
              readOnly: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: AppColor.white,

                      insetPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 16,
                      child: SizedBox(
                        height: Get.width * 0.85,
                        width: Get.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                'States',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.greyTitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                height: Get.width * 0.68,
                                child:
                                    cities.isEmpty
                                        ? const Text('No cities found')
                                        : ListView.separated(
                                          separatorBuilder:
                                              (context, index) =>
                                                  const Divider(),
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cities.length,
                                          itemBuilder: (context, index) {
                                            final data = cities[index];
                                            return InkWell(
                                              onTap: () async {
                                                Get.back();
                                                controller.cityController.text =
                                                    data.name ?? '';
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  bottom: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        data.name,
                                                        style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              hintName: "Enter Area",
              controller: controller.areaController,
            ),
            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              hintName: "Enter Pincode ",
              controller: controller.pincodeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: screenHeight * 0.02),

            Text(
              "Gender",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            Obx(
              () => Wrap(
                spacing: 8,
                children: List.generate(controller.genders.length, (index) {
                  final gender = controller.genders[index];

                  return _selectionChip(
                    'gender',
                    gender,
                    controller.selectedGender.value == gender,
                    () {
                      setState(() {
                        controller.selectedGender.value = gender;
                      });
                    },
                  );
                }),
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

            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(controller.qualifications.length, (
                  index,
                ) {
                  final qualification = controller.qualifications[index];

                  return _selectionChip(
                    'qualification',
                    qualification,
                    controller.selectedQualification.value == qualification,
                    () {
                      setState(() {
                        controller.selectedQualification.value = qualification;
                      });
                    },
                  );
                }),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            CommonButton(
              press: () {
                FocusScope.of(context).unfocus();
                if (controller.companyNameController.text.isEmpty) {
                  CommonToast.show(msg: "Please enter company name");
                  return;
                }
                if (controller.jobTitleController.text.isEmpty) {
                  CommonToast.show(msg: "Please select job title");
                  return;
                }
                if (controller.categoryController.text.isEmpty) {
                  CommonToast.show(msg: "Please select job category");
                  return;
                }
                if (controller.jobDescriptionController.text.isEmpty) {
                  CommonToast.show(msg: "Please enter job description");
                  return;
                }
                if (controller.openingsController.text.isEmpty) {
                  CommonToast.show(msg: "Please enter openings");
                  return;
                }
                if (controller.selectedJobType.value == '') {
                  CommonToast.show(msg: "Please select job type");
                  return;
                }
                if (controller.selectedJobMode.value == '') {
                  CommonToast.show(msg: "Please select job mode");
                  return;
                }

                if (controller.countryController.text.isEmpty) {
                  CommonToast.show(msg: "Please select country");
                  return;
                }
                if (controller.stateController.text.isEmpty) {
                  CommonToast.show(msg: "Please select state");
                  return;
                }
                if (controller.cityController.text.isEmpty) {
                  CommonToast.show(msg: "Please select city");
                  return;
                }
                if (controller.areaController.text.isEmpty) {
                  CommonToast.show(msg: "Please enter area");
                  return;
                }
                if (controller.pincodeController.text.isEmpty) {
                  CommonToast.show(msg: "Please enter pincode");
                  return;
                }
                if (controller.selectedGender.value == '') {
                  CommonToast.show(msg: "Please select gender");
                  return;
                }
                if (controller.selectedQualification.value == '') {
                  CommonToast.show(msg: "Please select qualification");
                  return;
                }

                Get.to(
                  () => LastStepCreateJob(
                    isEditing: widget.isEdit,
                    data: widget.data,
                  ),
                  transition: Transition.rightToLeft,
                );
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
                    type == 'gender'
                        ? genderIndex = -1
                        : qualificationIndex = -1;
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
