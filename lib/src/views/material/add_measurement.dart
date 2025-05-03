import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMeasurement extends StatefulWidget {
  const AddMeasurement({super.key});

  @override
  State<AddMeasurement> createState() => _AddMeasurementState();
}

class _AddMeasurementState extends State<AddMeasurement> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.016
                ),
                child: Image.asset(
                    'assets/images/back.png'
                )
            ),
          ),
          title: Text(
              'Add Measurement',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: screenHeight * 0.055
              ),
              Text(
                'Update Your Measurements',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.00.sp,
                      color: AppColor.primary
                  )
              ),
              SizedBox(
                height: screenHeight * 0.025
              ),
              CustomWidgets.fullWidthTextField(
                  label: RichText(
                      text: TextSpan(
                          text: 'Length',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              color: AppColor.black,
                            fontWeight: FontWeight.w400
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: ' ( inches )',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12.00.sp,
                                    color: AppColor.requiredTextColor
                                )
                            )
                          ]
                      )
                  ),
                  child: TextFormField(
                    controller: HomeController.to.length,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          )
                      )
                  )
              ),
              // SizedBox(
              //     height: screenHeight * 0.0001
              // ),
              CustomWidgets.fullWidthTextField(
                  label: RichText(
                      text: TextSpan(
                          text: 'Shoulder',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: ' ( inches )',
                                style: GoogleFonts.dmSans(
                                    fontSize: 12.00.sp,
                                    color: AppColor.requiredTextColor
                                )
                            )
                          ]
                      )
                  ),
                  child: TextFormField(
                    controller: HomeController.to.shoulder,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          )
                      )
                  )
              ),

              CustomWidgets.fullWidthTextField(
                  label: RichText(
                      text: TextSpan(
                          text: 'Chest',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              color: AppColor.black
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: ' ( inches )',
                                style: GoogleFonts.dmSans(
                                    fontSize: 12.00.sp,
                                    color: AppColor.requiredTextColor,
                                    fontWeight: FontWeight.w400
                                )
                            )
                          ]
                      )
                  ),
                  child: TextFormField(
                      controller: HomeController.to.chest,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.2)
                              )
                          )
                      )
                  )
              ),
                          CustomWidgets.fullWidthTextField(
                  label: RichText(
                      text: TextSpan(
                          text: 'Waist',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: ' ( inches )',
                                style: GoogleFonts.dmSans(
                                    fontSize: 12.00.sp,
                                    color: AppColor.requiredTextColor
                                )
                            )
                          ]
                      )
                  ),
                  child: TextFormField(
                    controller: HomeController.to.waist,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          )
                      )
                  )
              ),

              CustomWidgets.fullWidthTextField(
                  label: RichText(
                      text: TextSpan(
                          text: 'Hip',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                                text: ' ( inches )',
                                style: GoogleFonts.dmSans(
                                    fontSize: 12.00.sp,
                                    color: AppColor.requiredTextColor
                                )
                            )
                          ]
                      )
                  ),
                  child: TextFormField(
                      controller: HomeController.to.hip,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5)
                              )
                          )
                      )
                  )
              ),

            ]
          )
        )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
            width: screenWidth / 1.2,
            child: CommonButton(
                press: (){
                  Get.back();
                },
                text: 'Update',
                loading: false,
                width: screenWidth / 1.2,
                height: screenHeight * 0.7
            )
        )
      )
    );

  }

}