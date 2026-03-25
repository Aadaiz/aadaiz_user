import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/model/job_list_data_model.dart';

class LastStepCreateJob extends StatefulWidget {
  final bool? isEditing;
  final Datum? data;
  const LastStepCreateJob({super.key, this.isEditing = false, this.data});

  @override
  State<LastStepCreateJob> createState() => _LastStepCreateJobState();
}

class _LastStepCreateJobState extends State<LastStepCreateJob> {
  final JobsController controller = Get.find<JobsController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isEditing == true) {
        final fromTime = DateFormat('HH:mm').parse(widget.data?.startTime);
        final toTime = DateFormat('HH:mm').parse(widget.data?.endTime);

        widget.data?.isFresher == '1'
            ? controller.onlyFreshers.value = true
            : controller.onlyFreshers.value = false;
        widget.data?.minExp != null
            ? controller.minExpController.text =
                widget.data?.minExp.toString() ?? ''
            : controller.minExpController.text = '';
        widget.data?.maxExp != null
            ? controller.maxExpController.text =
                widget.data?.maxExp.toString() ?? ''
            : controller.maxExpController.text = '';
        widget.data?.salaryFrom != null
            ? controller.minSalaryController.text =
                widget.data?.salaryFrom.toString() ?? ''
            : controller.minSalaryController.text = '';
        widget.data?.salaryTo != null
            ? controller.maxSalaryController.text =
                widget.data?.salaryTo.toString() ?? ''
            : controller.maxSalaryController.text = '';
        final apiBenefits =
            widget.data?.jobBenefit
                ?.map((e) => e.name)
                .whereType<String>()
                .toList() ??
            [];

        controller.benefits.clear();
        controller.benefits.addAll(apiBenefits);

        controller.benefitSelected.value = List.generate(
          apiBenefits.length,
          (_) => true,
        );

        controller.selectedJobBenefits.value = apiBenefits;
        final apiSkills =
            widget.data?.jobSkill
                ?.map((e) => e.name)
                .whereType<String>()
                .toList() ??
            [];

        controller.skills.clear();
        controller.skills.addAll(apiSkills);

        controller.skillSelected.value = List.generate(
          apiSkills.length,
          (_) => true,
        );

        controller.selectedJobSkills.value = apiSkills;
        final apiWorkingDay = widget.data?.workingDays ?? '';

        controller.workingDaySelected.value = List.generate(
          controller.workingDays.length,
          (_) => false,
        );

        for (int i = 0; i < controller.workingDays.length; i++) {
          if (controller.workingDays[i] == apiWorkingDay) {
            controller.workingDaySelected[i] = true;
            controller.workingDayIndex.value = i;
          }
        }

        controller.selectedWorkingDays.value =
            apiWorkingDay.isNotEmpty ? [apiWorkingDay] : [];
        final apiRequirements =
            widget.data?.jobRequirement
                ?.map((e) => e.requirements)
                .whereType<String>()
                .toList() ??
            [];

        if (controller.otherRequirement.isEmpty) {
          controller.otherRequirement.addAll(apiRequirements);

          controller.otherRequirementSelected.value = List.generate(
            controller.otherRequirement.length,
            (_) => true,
          );
        } else {
          if (controller.otherRequirementSelected.length !=
              controller.otherRequirement.length) {
            controller.otherRequirementSelected.value = List.generate(
              controller.otherRequirement.length,
              (_) => false,
            );
          }

          for (int i = 0; i < controller.otherRequirement.length; i++) {
            controller.otherRequirementSelected[i] = apiRequirements.contains(
              controller.otherRequirement[i],
            );
          }
        }

        controller.from.text = DateFormat('hh:mm a').format(fromTime);
        controller.to.text = DateFormat('hh:mm a').format(toTime);
        controller.communicationPref.value =
            widget.data?.communication != '' ? true : false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = Utils.getActivityScreenWidth(context);
    final height = Utils.getActivityScreenHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: "Jobs"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * .05,
          vertical: height * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Step",
              style: GoogleFonts.dmSans(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: height * .02),
            Obx(
              () => CheckboxListTile(
                activeColor: AppColor.minusColor,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                value: controller.onlyFreshers.value,
                onChanged: (v) => controller.onlyFreshers.value = v!,
                title: Text(
                  "Only Freshers Should Apply",
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
              ),
            ),
            SizedBox(height: height * .02),
            Obx(
              () => AbsorbPointer(
                absorbing: controller.onlyFreshers.value,
                child: Opacity(
                  opacity: controller.onlyFreshers.value ? 0.3 : 1.0,
                  child: Text(
                    "Required Experience",
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            Obx(
              () => AbsorbPointer(
                absorbing: controller.onlyFreshers.value,
                child: Opacity(
                  opacity: controller.onlyFreshers.value ? 0.3 : 1.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: CommonTextFieldTwo(
                          keyboardType: TextInputType.number,
                          hintName: "Min Exp",
                          controller: controller.minExpController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonTextFieldTwo(
                          keyboardType: TextInputType.number,
                          hintName: "Max Exp",
                          controller: controller.maxExpController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            Text(
              "Salary",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * .01),
            Row(
              children: [
                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "₹10,000",
                    controller: controller.minSalaryController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("To"),
                ),
                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "₹15,000",
                    controller: controller.maxSalaryController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .01),
            Text(
              "Job Benefits",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * .018),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  controller.benefits.length,
                  (index) => _chip(
                    controller.benefits[index],
                    controller.benefitSelected[index],
                    () {
                      controller.toggleBenefit(index);
                      controller.selectedJobBenefits.value =
                          controller.benefits
                              .where(
                                (element) =>
                                    controller.benefitSelected[controller
                                        .benefits
                                        .indexOf(element)],
                              )
                              .toList();
                    },
                  ),
                ),
              ),
            ),
            if (controller.benefits.isNotEmpty) SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        backgroundColor: Colors.white,
                        content: SizedBox(
                          height: height * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextFieldTwo(
                                hintName: "Add Other Benefits That You Expect",
                                controller: controller.benefitsController,
                              ),
                              SizedBox(height: height * .01),
                              CommonButton(
                                press: () {
                                  if (controller
                                      .benefitsController
                                      .text
                                      .isEmpty) {
                                    CommonToast.show(msg: 'Add Something');
                                    return;
                                  }

                                  final newBenefit =
                                      controller.benefitsController.text;

                                  controller.benefits.add(newBenefit);
                                  controller.benefitSelected.add(true);
                                  controller.selectedJobBenefits.add(
                                    newBenefit,
                                  );

                                  controller.benefitsController.clear();
                                  Get.back();
                                },
                                text: "Click to Add",
                                borderRadius: 0.0,
                                height: height * .045,
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Add More +',
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
              ),
            ),
            SizedBox(height: height * .028),
            Text(
              "Job Skill (Optional)",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * .018),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  controller.skills.length,
                  (index) => _chip(
                    controller.skills[index],
                    controller.skillSelected[index],
                    () {
                      controller.skillSelected[index] =
                          !controller.skillSelected[index];

                      controller.skillSelected.refresh();
                      controller.selectedJobSkills.value =
                          controller.skills
                              .where(
                                (element) =>
                                    controller.skillSelected[controller.skills
                                        .indexOf(element)],
                              )
                              .toList();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        backgroundColor: Colors.white,
                        content: SizedBox(
                          height: height * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextFieldTwo(
                                hintName: "Add Other Job Skill That You Expect",
                                controller: controller.skillsController,
                              ),
                              SizedBox(height: height * .01),
                              CommonButton(
                                press: () {
                                  if (controller
                                      .skillsController
                                      .text
                                      .isEmpty) {
                                    CommonToast.show(msg: 'Add Something');
                                    return;
                                  }

                                  final newSkill =
                                      controller.skillsController.text;

                                  controller.skills.add(newSkill);
                                  controller.skillSelected.add(true);
                                  controller.selectedJobSkills.add(newSkill);

                                  controller.skillsController.clear();
                                  Get.back();
                                },
                                text: "Click to Add",
                                borderRadius: 0.0,
                                height: height * .045,
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Add More +',
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
              ),
            ),
            SizedBox(height: height * .025),
            Text(
              "Requirements",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),

            Obx(
              () => ListView.builder(
                padding: const EdgeInsets.only(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.otherRequirement.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: AppColor.minusColor,
                    value: controller.otherRequirementSelected[index],
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    title: Text(controller.otherRequirement[index]),
                    onChanged: (value) {
                      setState(() {
                        controller.otherRequirementSelected[index] = value!;
                        controller.otherRequirementSelected.refresh();
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: height * .01),
            CommonTextFieldTwo(
              hintName: "Add Other Requirements That You Expect",
              controller: controller.requirementController,
              suffixIcon: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  if (controller.requirementController.text.isNotEmpty) {
                    controller.otherRequirement.add(
                      controller.requirementController.text,
                    );
                    controller.otherRequirementSelected.add(false);
                    controller.requirementController.clear();
                  }
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Text(
                      'Add More +',
                      style: GoogleFonts.dmSans(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .025),
            Text(
              "Job Timings",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * .01),
            Row(
              children: [
                Expanded(
                  child: CommonTextFieldTwo(
                    readOnly: true,
                    controller: controller.from,
                    hintName: "09:00 AM",
                    onTap: () => _pickFromTime(context),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("To"),
                ),
                Expanded(
                  child: CommonTextFieldTwo(
                    readOnly: true,
                    controller: controller.to,
                    hintName: "06:00 PM",
                    onTap: () => _pickToTime(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .01),
            Text(
              "Working Days",
              style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * .01),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  controller.workingDays.length,
                  (index) => _chip(
                    controller.workingDays[index],
                    controller.workingDayIndex.value == index,
                    () {
                      controller.setWorkingDay(index);
                      controller.selectedWorkingDays.value =
                          controller.workingDays
                              .where(
                                (element) =>
                                    controller.workingDaySelected[controller
                                        .workingDays
                                        .indexOf(element)],
                              )
                              .toList();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        backgroundColor: Colors.white,
                        content: SizedBox(
                          height: height * .15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextFieldTwo(
                                hintName: "Add Other Working Days",
                                controller: controller.workingDaysController,
                              ),
                              SizedBox(height: height * .01),
                              CommonButton(
                                press: () {
                                  if (controller
                                      .workingDaysController
                                      .text
                                      .isEmpty) {
                                    CommonToast.show(msg: 'Add Something');
                                    return;
                                  }
                                  controller.workingDays.add(
                                    controller.workingDaysController.text,
                                  );
                                  controller.workingDaySelected.add(false);
                                  controller.workingDaysController.clear();
                                  Get.back();
                                },
                                text: "Click to Add",
                                borderRadius: 0.0,
                                height: height * .045,
                              ),
                            ],
                          ),
                        ),
                      ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Add More +',
                  style: GoogleFonts.dmSans(fontSize: 12.sp),
                ),
              ),
            ),
            SizedBox(height: height * .02),
            Obx(
              () => Row(
                children: [
                  Checkbox(
                    activeColor: AppColor.minusColor,
                    value: controller.communicationPref.value,
                    onChanged: (v) => controller.communicationPref.value = v!,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isEditing == true
                          ? Text(
                            (controller.hrNumber.text.isEmpty &&
                                    controller.contactFrom.text.isEmpty &&
                                    controller.contactTo.text.isEmpty)
                                ? "${widget.data?.communication}"
                                : "Allow Candidates To Call Between\n${controller.contactFrom.text} – ${controller.contactTo.text} on ${controller.hrNumber.text}",
                            style: GoogleFonts.dmSans(fontSize: 12.sp),
                          )
                          : Text(
                            (controller.hrNumber.text.isEmpty &&
                                    controller.contactFrom.text.isEmpty &&
                                    controller.contactTo.text.isEmpty)
                                ? "Allow Candidates To Call Between\n10:00 AM – 7:00 PM on +91 0123456789"
                                : "Allow Candidates To Call Between\n${controller.contactFrom.text} – ${controller.contactTo.text} on ${controller.hrNumber.text}",
                            style: GoogleFonts.dmSans(fontSize: 12.sp),
                          ),
                      SizedBox(height: height * .01),
                      InkWell(
                        onTap: () => _showContactDialog(context, height),
                        child: Text(
                          '( Edit )',
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * .03),
            Obx(
              () => CommonButton(
                loading: controller.createJobLoading.value,
                press: () {
                  if (!controller.onlyFreshers.value) {
                    if (controller.minExpController.text.isEmpty ||
                        controller.maxExpController.text.isEmpty) {
                      CommonToast.show(msg: 'Add Experience');
                      return;
                    }

                    final minExp =
                        int.tryParse(controller.minExpController.text) ?? 0;
                    final maxExp =
                        int.tryParse(controller.maxExpController.text) ?? 0;

                    if (minExp > maxExp) {
                      CommonToast.show(
                        msg: 'Min Exp should be less than Max Exp',
                      );
                      return;
                    }
                  }

                  if (controller.minSalaryController.text.isEmpty ||
                      controller.maxSalaryController.text.isEmpty) {
                    CommonToast.show(msg: 'Add Salary');
                    return;
                  }

                  final minSalary =
                      int.tryParse(controller.minSalaryController.text) ?? 0;
                  final maxSalary =
                      int.tryParse(controller.maxSalaryController.text) ?? 0;

                  if (minSalary > maxSalary) {
                    CommonToast.show(
                      msg: 'Min Salary should be less than Max Salary',
                    );
                    return;
                  }
                  if (controller.selectedJobBenefits.isEmpty) {
                    CommonToast.show(msg: 'Add Benefits');
                    return;
                  }
                  if (controller.selectedJobSkills.isEmpty) {
                    CommonToast.show(msg: 'Add Skills');
                    return;
                  }
                  if (controller.otherRequirement.isEmpty) {
                    CommonToast.show(msg: 'Add Requirements');
                    return;
                  }
                  if (controller.from.text.isEmpty ||
                      controller.to.text.isEmpty) {
                    CommonToast.show(msg: 'Add Time');
                    return;
                  }

                  if (controller.workingDayIndex.value == -1) {
                    CommonToast.show(msg: 'Add Working Days');
                    return;
                  }
                  if (controller.communicationPref.value == false) {
                    CommonToast.show(msg: 'Check Communication Pref');
                    return;
                  }

                  controller.createJob(widget.isEditing, widget.data?.id);
                },
                text: "Post This Job",
                borderRadius: 0.0,
                height: height * .045,
              ),
            ),
            SizedBox(height: height * .04),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.fromTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.fromTime.value = picked;
      final now = DateTime.now();
      final formatted = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      controller.from.text = DateFormat('hh:mm a').format(formatted);

      if (controller.toTime.value != null) {
        final toDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          controller.toTime.value!.hour,
          controller.toTime.value!.minute,
        );
        if (toDateTime.isBefore(formatted)) {
          controller.toTime.value = null;
          controller.to.clear();
        }
      }
    }
  }

  Future<void> _pickToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          controller.toTime.value ??
          controller.fromTime.value ??
          TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTo = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      if (controller.fromTime.value != null) {
        final fromDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          controller.fromTime.value!.hour,
          controller.fromTime.value!.minute,
        );
        if (selectedTo.isBefore(fromDateTime)) {
          CommonToast.show(msg: 'Time should be greater than From Time');
          return;
        }
      }

      controller.toTime.value = picked;
      controller.to.text = DateFormat('hh:mm a').format(selectedTo);
    }
  }

  void _showContactDialog(BuildContext context, double height) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            backgroundColor: Colors.white,
            content: SizedBox(
              height: height * .32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Call Between Timings",
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: height * .01),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextFieldTwo(
                          readOnly: true,
                          controller: controller.contactFrom,
                          hintName: "09:00 AM",
                          onTap: () => _contactPickFromTime(context),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("To"),
                      ),
                      Expanded(
                        child: CommonTextFieldTwo(
                          readOnly: true,
                          controller: controller.contactTo,
                          hintName: "06:00 PM",
                          onTap: () => _contactPickToTime(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .01),
                  CommonTextFieldTwo(
                    hintName: "Enter Contact Number",
                    controller: controller.hrNumber,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  SizedBox(height: height * .015),
                  CommonButton(
                    press: () {
                      if (controller.hrNumber.text.isEmpty) {
                        CommonToast.show(msg: 'Add Number');
                        return;
                      }
                      if (controller.contactFrom.text.isEmpty ||
                          controller.contactTo.text.isEmpty) {
                        CommonToast.show(msg: 'Add Time');
                        return;
                      }
                      setState(() {});
                      Get.back();
                    },
                    text: "Click to Add",
                    borderRadius: 0.0,
                    height: height * .045,
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _contactPickFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.contactFromTime.value ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.contactFromTime.value = picked;
      final now = DateTime.now();
      final formatted = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      controller.contactFrom.text = DateFormat('hh:mm a').format(formatted);

      if (controller.contactToTime.value != null) {
        final toDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          controller.contactToTime.value!.hour,
          controller.contactToTime.value!.minute,
        );
        if (toDateTime.isBefore(formatted)) {
          controller.contactToTime.value = null;
          controller.contactTo.clear();
        }
      }
    }
  }

  Future<void> _contactPickToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          controller.contactToTime.value ??
          controller.contactFromTime.value ??
          TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColor.primary),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTo = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      if (controller.contactFromTime.value != null) {
        final fromDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          controller.contactFromTime.value!.hour,
          controller.contactFromTime.value!.minute,
        );
        if (selectedTo.isBefore(fromDateTime)) {
          CommonToast.show(msg: 'Time should be greater than From Time');
          return;
        }
      }

      controller.contactToTime.value = picked;
      controller.contactTo.text = DateFormat('hh:mm a').format(selectedTo);
    }
  }

  Widget _chip(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(title, style: GoogleFonts.dmSans(fontSize: 12.sp)),
      ),
    );
  }
}
