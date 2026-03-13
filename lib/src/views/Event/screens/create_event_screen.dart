import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  EventController controller = Get.find<EventController>();

  String? fileName;

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.getActivityScreenWidth(context);
    final screenHeight = Utils.getActivityScreenHeight(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: "Create Event",
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
            CommonTextFieldTwo(
              labelName: "Event Name",
              hintName: "Enter Event Name",
              controller: controller.eventNameController,
            ),

            SizedBox(height: screenHeight * 0.02),

            Text(
              "Start",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "Friday, 25 May 2024",
                    controller: controller.startDateController,
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    onTap: () {},
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "02:00 PM",
                    controller: controller.startTimeController,
                    readOnly: true,
                    suffixIcon: const Icon(Icons.access_time, size: 18),
                    onTap: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            Text(
              "End",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "Friday, 25 May 2024",
                    controller: controller.endDateController,
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today, size: 18),
                    onTap: () {},
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                Expanded(
                  child: CommonTextFieldTwo(
                    hintName: "02:00 PM",
                    controller: controller.endTimeController,
                    readOnly: true,
                    suffixIcon: const Icon(Icons.access_time, size: 18),
                    onTap: () {},
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              labelName: "Event Location",
              hintName: "Enter Address Here",
              controller: controller.locationController,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Update Location",
                    style: GoogleFonts.dmSans(
                      fontSize: 10.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              labelName: "Email address",
              hintName: "Your email",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: screenHeight * 0.02),

            CommonTextFieldTwo(
              labelName: "Mobile Number",
              hintName: "Your Mobile Number",
              controller: controller.mobileController,
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: screenHeight * 0.025),

            Text(
              "Upload Attachment ( Event Place )",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.showDialogImage(context, picture: 1);

                      if (controller.image1.value != null) {
                        setState(() {
                          fileName = controller.image1.value!.path.split('/').last;
                        });
                      }
                    },
                    child: Container(
                      width: screenWidth*0.3,
                      height: screenHeight*0.03,

                      decoration: BoxDecoration(
                        color: AppColor.backGroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child:  Text(
                        "Select Files",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  if (controller.image1.value != null)
                  const Divider(color: AppColor.underlineBorderColor,),
                  Obx(() {
                    if (controller.image1.value == null) return const SizedBox();

                    final name = controller.image1.value!.path.split('/').last;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              name,
                              style: GoogleFonts.dmSans(fontSize: 12.sp),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            controller.image1.value = null;
                          },
                          icon: Icon(
                            Icons.delete_sharp,
                            color: AppColor.red,
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            CommonButton(
              press: () {},
              text: 'Create Event',
              borderRadius: 0.0,
              height: screenHeight * 0.045,
            ),
            SizedBox(height: screenHeight * 0.04),
          ],
        ),
      ),
    );
  }
}
