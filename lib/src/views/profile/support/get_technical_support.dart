import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class GetTechnicalSupport extends StatefulWidget {
  const GetTechnicalSupport({super.key});

  @override
  State<GetTechnicalSupport> createState() => _GetTechnicalSupportState();
}

class _GetTechnicalSupportState extends State<GetTechnicalSupport> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileController.to.image.value = File('');
  }
  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.016
              ),
              child: Image.asset(
                  'assets/images/back.png'
              )
          ),
          title: Text(
              'Technical Support',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          elevation: 2,
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.033,
          vertical: screenHeight * 0.022
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomWidgets.fullWidthTextField(
                label: Text(
                    'Your Problem',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: AppColor.black
                    )
                ),
                child: TextFormField(
                    controller: title,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColor.dividerColor
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColor.dividerColor
                            )
                        )
                    )
                )
            ),
            SizedBox(
              height: screenHeight * 0.03
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8,
                  right: 5
              ),
              child: Text(
                  'Description',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black
                  )
              )
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(8, screenHeight * 0.022, 5, 0),
              child: TextFormField(
                // expands: true,
                controller: description,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  decoration: InputDecoration(
                    // isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColor.dividerColor
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColor.dividerColor
                          )
                      )
                  )
              )
            ),
            SizedBox(
                height: screenHeight * 0.03
            ),
            CustomWidgets.fullWidthTextField(
                label: Text(
                    'Attachment',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: AppColor.black
                    )
                ),
                child: InkWell(
                  onTap: (){
                    ProfileController.to.showdialog(
                      context
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 4)
                        )
                      ]
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/camera.png',
                        height: screenHeight * 0.033
                      ),
                      title: Text(
                          'Add your photos',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.textColor
                          )
                      )
                    )
                  ),
                )
            )
          ]
        )
      ),
      bottomNavigationBar: BottomAppBar(
        height: screenHeight * 0.2,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColor.primary
                )
              ),
              width: screenWidth / 2.7,
              height: screenHeight * 0.066,
              alignment: Alignment.center,
              child: Text(
                  'Cancel',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.00.sp,
                      color: AppColor.primary
                  )
              )
            ),
            SizedBox(
              width: screenWidth / 2.2,
              child: Obx(()=>
                 CommonButton(
                  loading: ProfileController.to.addSupportLoading.value,
                    press: ()async{
                    await  ProfileController.to.uploadImage();
                    await  ProfileController.to.addSupport(title.text, description.text);
                    ProfileController.to.getSupportList();
                    Get.back();
                    },
                  text: 'Create Ticket'
                ),
              )
            )
          ]
        )
      )
    );

  }

}