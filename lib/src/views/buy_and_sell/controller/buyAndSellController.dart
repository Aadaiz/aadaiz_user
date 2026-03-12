import 'dart:io';

import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class BuyAndSellController extends GetxController {

  TextEditingController productName = TextEditingController();

  TextEditingController subProductName = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TextEditingController phoneController = TextEditingController();






  Rx<File?> image1 = Rx<File?>(null);
  Rx<File?> image2 = Rx<File?>(null);
  Rx<File?> image3 = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> showDialogImage(context, {required int picture}) {
    return showDialog(
      context: context,
      builder: (context) {
        var sel = 0;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 95.0.wp,
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Please Choose',
                          style: GoogleFonts.dmSans(
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(Icons.cancel,color: Colors.blueAccent),
                        )
                      ],
                    ),
                    SizedBox(height: 3.0.hp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 1;
                              openCamera(camera: false, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(Icons.image,
                                  size: 50,
                                  color: sel == 1
                                      ? AppColors.projectcolor
                                      : Colors.grey),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Gallery',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              sel = 2;
                              openCamera(camera: true, picture: picture);
                            });
                          },
                          child: Column(
                            children: [
                              Icon(Icons.camera_alt_rounded,
                                  size: 50,
                                  color: sel == 2
                                      ? AppColors.projectcolor
                                      : Colors.grey),
                              SizedBox(height: 1.0.hp),
                              Text(
                                'Camera',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.0.hp),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> openCamera({required bool camera, required int picture}) async {

    Get.back();

    final pickedFile = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile == null) return;

    File file = File(pickedFile.path);

    if (picture == 1) {
      image1.value = file;
    } else if (picture == 2) {
      image2.value = file;
    } else if (picture == 3) {
      image3.value = file;
    }
  }
}