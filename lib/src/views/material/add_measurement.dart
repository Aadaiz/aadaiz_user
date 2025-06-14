import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class AddMeasurement extends StatefulWidget {
  const AddMeasurement({super.key, this.id, this.price});
final dynamic id;
final dynamic price;
  @override
  State<AddMeasurement> createState() => _AddMeasurementState();
}

class _AddMeasurementState extends State<AddMeasurement> {
  HomeController controller = Get.put(HomeController());

  String fabricLength = 'Choose here';
  void _showImageFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: Icon(Icons.close, color: AppColor.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: PhotoView(
                imageProvider: const AssetImage(
                  'assets/images/measurement.jpg',
                ), // Replace with your image path
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2.5,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuItem<int> buildMenuItem(int value, String text, Color textColor) {
      return PopupMenuItem<int>(
        value: value,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 5.5.hp),
        child: CommonAppBar(
          title: "",
          isCheck: true,
          actionButton: GestureDetector(
            onTap: () {
              _showImageFullScreen(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 16, 2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Text(
                  'Guide',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How Many Meters Fabric You Have?',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.00.sp,
                        color: AppColor.primary,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 24),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.borderGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fabricLength,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.00.sp,
                              color: AppColor.primary,
                            ),
                          ),
                          PopupMenuButton<int>(
                            color: AppColor.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            itemBuilder:
                                (context) => List.generate(10, (i) {
                                  return buildMenuItem(
                                    i + 1,
                                    '${i + 1}',
                                    AppColor.primary,
                                  );
                                }),
                            onSelected: (value) {
                              setState(() {
                                fabricLength = value.toString();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColor.primary,
                                  size: Get.width * 0.06,
                                ),
                              ),
                            ), // Replace with your desired icon
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Update Your Measurements',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.00.sp,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                backgroundColor: Colors.transparent,
                shape: Border.all(color: Colors.transparent),
                title: Text(
                  "Top Measurements",
                  maxLines: 2,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: [
                  orderMeasurementTextField(
                    "Neck Circumference (A)",
                    "(inches)",
                    controller.neckCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Single Shoulder Width (B)",
                    "(inches)",
                    controller.singleShoulderWidthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Across Shoulder Width (C)",
                    "(inches)",

                    controller.acrossShoulderWidthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Front Width (D1)",
                    "(inches)",

                    controller.frontWidthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Back Width (D2)",
                    "(inches)",

                    controller.backWidthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Upper Bust Circumference (E)",
                    "(inches)",

                    controller.upperBustCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Bust Circumference (F)",
                    "(inches)",

                    controller.bustCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Under Bust Circumference (G)",
                    "(inches)",

                    controller.underBustCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Saree Blouse/Choli Hemline Circumference (H)",
                    "(inches)",

                    controller.sareeBlouseHemlineCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Waist Circumference (I)",
                    "(inches)",

                    controller.waistCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Low Waist Circumference (J)",
                    "(inches)",

                    controller.lowWaistCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Bust Length (Q)",
                    "(inches)",

                    controller.bustLengthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Apex/High Bust Point Difference (R)",
                    "(inches)",

                    controller.apexHighBustPointDifferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Saree Blouse/Choli Length (S)",
                    "(inches)",

                    controller.sareeBlouseLengthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Required Top Length (T)",
                    "(inches)",

                    controller.requiredTopLengthController,
                  ),
                ],
              ),
              // Sleeve Measurements
              ExpansionTile(
                backgroundColor: Colors.transparent,
                shape: Border.all(color: Colors.transparent),
                title: Text(
                  "Sleeve Measurements",
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: [
                  orderMeasurementTextField(
                    "Arm Hole Round (W)",
                    "(inches)",

                    controller.armHoleRoundController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Upper Arm Circumference (X)",
                    "(inches)",

                    controller.upperArmCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Required Sleeve Length (Y1, Y2, Y3)",
                    "(inches)",

                    controller.requiredSleeveLengthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Sleeve Hemline Circumference (Z1, Z2, Z3)",
                    "(inches)",

                    controller.sleeveHemlineCircumferenceController,
                  ),
                ],
              ),
              // Bottom Measurements
              ExpansionTile(
                backgroundColor: Colors.transparent,
                shape: Border.all(color: Colors.transparent),
                title: Text(
                  "Bottom Measurements",
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: [
                  orderMeasurementTextField(
                    "High Hip Circumference (K)",
                    "(inches)",

                    controller.highHipCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Hip Circumference (L)",
                    "(inches)",

                    controller.hipCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Thigh Circumference (M)",
                    "(inches)",

                    controller.thighCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Knee Circumference (N)",
                    "(inches)",

                    controller.kneeCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Calf Circumference (O)",
                    "(inches)",

                    controller.calfCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Ankle/Bottom Hemline Circumference (P)",
                    "(inches)",

                    controller.ankleBottomHemlineCircumferenceController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Required Bottom Length (V1)",
                    "(inches)",

                    controller.requiredBottomLengthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Inseam Length (V2)",
                    "(inches)",

                    controller.inseamLengthController,
                  ),
                  SizedBox(height: Get.height * 0.015),
                  orderMeasurementTextField(
                    "Crotch Length (V3)",
                    "(inches)",

                    controller.crotchLengthController,
                  ),
                ],
              ),
              // Full Length Measurements
              ExpansionTile(
                backgroundColor: Colors.transparent,
                shape: Border.all(color: Colors.transparent),
                title: Text(
                  "Full Length Measurements",
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                children: [
                  orderMeasurementTextField(
                    "Required Full Length (U)",
                    "(inches)",

                    controller.requiredFullLengthController,
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ), // Adjusted height since we removed one button
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CommonButton(
          text: 'Add To Cart',
          press: () {
            if(fabricLength!=''){
              HomeController.to.cart(
                action: 'add',
                id: widget.id,
                price: widget.price,
                quantity: 1,
              );
            }else{
              Get.snackbar('Add', 'Please Choose the fabric length');
            }
          },
          borderRadius: 0.0,
        ),
      ),
    );
  }

  Widget orderMeasurementTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: GoogleFonts.dmSans(color: AppColor.primary)),
              SizedBox(width: Get.width * 0.01),
              Text(hint, style: GoogleFonts.dmSans(color: AppColor.red)),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.black.withOpacity(0.4),
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.black.withOpacity(0.4),
                  width: 0.0,
                ),
              ),
              hintText: "Enter Here",
              hintStyle: GoogleFonts.dmSans(
                color: AppColor.black.withOpacity(0.3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
