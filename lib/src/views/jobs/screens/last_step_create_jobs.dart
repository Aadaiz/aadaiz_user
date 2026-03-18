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
class LastStepCreateJob extends StatefulWidget {

  LastStepCreateJob({super.key});

  @override
  State<LastStepCreateJob> createState() => _LastStepCreateJobState();
}

class _LastStepCreateJobState extends State<LastStepCreateJob> {
  final JobsController controller = Get.find<JobsController>();

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
                          hintName: "Min Exp",
                          controller: controller.minExpController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CommonTextFieldTwo(
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
                        () => controller.toggleBenefit(index),
                  ),
                ),
              ),
            ),
            if(controller.benefits.isNotEmpty)
            SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                              if (controller.benefitsController.text.isEmpty) {
                                CommonToast.show(msg: 'Add Something');
                                return;
                              }
                              controller.benefits.add(
                                controller.benefitsController.text,
                              );
                              controller.benefitSelected.add(false);
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
                    },
                  ),
                ),
              ),
            ),
            if(controller.skills.isNotEmpty)
            SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                              if (controller.skillsController.text.isEmpty) {
                                CommonToast.show(msg: 'Add Something');
                                return;
                              }
                              controller.skills.add(
                                controller.skillsController.text,
                              );
                              controller.skillSelected.add(false);
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
                    padding: EdgeInsets.only(top: 0),
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
                      controller.otherRequirementSelected[index] = value!;
                      controller.otherRequirementSelected.refresh();
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
                        () => controller.setWorkingDay(index),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                              if (controller.workingDaysController.text.isEmpty) {
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
                      Text(
                        controller.hrNumber.text.isEmpty
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
            CommonButton(
              press: () {},
              text: "Post This Job",
              borderRadius: 0.0,
              height: height * .045,
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
      initialTime: controller.toTime.value ?? controller.fromTime.value ?? TimeOfDay.now(),
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
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                  setState(() {

                  });
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
      initialTime: controller.contactToTime.value ??
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
