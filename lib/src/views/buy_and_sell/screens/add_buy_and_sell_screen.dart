import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_textfiled_two.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/add_location.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBuyAndSellScreen extends StatefulWidget {
  final bool isEdit;
  final OurProductsDatum? data;
  const AddBuyAndSellScreen({super.key, this.isEdit = false, this.data});

  @override
  State<AddBuyAndSellScreen> createState() => _AddBuyAndSellScreenState();
}

class _AddBuyAndSellScreenState extends State<AddBuyAndSellScreen> {
  final BuyAndSellController controller = Get.find<BuyAndSellController>();
  bool isClicked = false;
  @override
  void initState() {
    super.initState();

    if (widget.isEdit == true && widget.data != null) {
      final data = widget.data;

      controller.productName.text = data?.productName ?? '';
      controller.subProductName.text = data?.subProductName ?? '';
      controller.categoryController.text = data?.category ?? '';
      controller.priceController.text = data?.price ?? '';
      controller.sizeController.text = data?.size ?? '';
      controller.descriptionController.text = data?.description ?? '';

      controller.urlImage1.value = data?.images?.main ?? '';
      controller.urlImage2.value = data?.images?.front ?? '';
      controller.urlImage3.value = data?.images?.back ?? '';

      controller.country.text = data?.location?.country ?? '';
      controller.state.text = data?.location?.state ?? '';
      controller.st.text = data?.location?.area ?? '';
      controller.pin.text = data?.location?.pincode ?? '';
      controller.city.text = data?.location?.city ?? '';
    } else {
      controller.clearAllFields();
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.getActivityScreenHeight(context);
    final screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () {
            Get.back();
            controller.clearAllFields();
          },
          title: '',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        children: [
          CommonTextFieldTwo(
            labelName: 'Product Name',
            controller: controller.productName,
            hintName: 'Enter Product Name',
            isRequired: true,
          ),

          SizedBox(height: screenHeight * 0.03),

          CommonTextFieldTwo(
            labelName: 'Sub-Product Name',
            controller: controller.subProductName,
            hintName: 'Enter Sub-Product Name',
            isRequired: true,
          ),

          SizedBox(height: screenHeight * 0.03),

          CommonTextFieldTwo(
            readOnly: true,
            controller: controller.categoryController,
            hintName: 'Select Category',
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                });
              },
              child:
                  isClicked
                      ? const Icon(Icons.keyboard_arrow_up, size: 30)
                      : const Icon(Icons.keyboard_arrow_right, size: 30),
            ),

            hintStyle: GoogleFonts.dmSans(
              color: AppColor.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isClicked)
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFieldBorderColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: controller.categoryList.length,
                    itemBuilder: (context, index) {
                      final data = controller.categoryList[index];
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            controller.selectedCategory.value = data;
                            controller.categoryController.text = data;
                            setState(() {
                              isClicked = false;
                            });
                          },
                          child: Text(
                            data,
                            style: GoogleFonts.dmSans(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

          SizedBox(height: screenHeight * 0.03),

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.showDialogImage(context, picture: 1);
                        },
                        child: Obx(
                          () => _imageBox(screenWidth, controller.image1.value,controller.urlImage1.value),
                        ),
                      ),
                    ),

                    SizedBox(width: screenWidth * 0.03),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.showDialogImage(context, picture: 2);
                        },
                        child: Obx(
                          () => _imageBox(screenWidth, controller.image2.value,controller.urlImage2.value),
                        ),
                      ),
                    ),

                    SizedBox(width: screenWidth * 0.03),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.showDialogImage(context, picture: 3);
                        },
                        child: Obx(
                          () => _imageBox(screenWidth, controller.image3.value,controller.urlImage3.value),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextFieldTwo(
                        keyboardType: TextInputType.number,
                        lableStyle: GoogleFonts.dmSans(
                          color: AppColor.unSelectColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        labelName: 'Enter Price',

                        controller: controller.priceController,
                        hintName: 'Enter Sub-Product Name',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    SizedBox(
                      width: screenWidth * 0.25,
                      child: CommonTextFieldTwo(
                        readOnly: true,
                        lableStyle: GoogleFonts.dmSans(
                          color: AppColor.unSelectColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        labelName: 'Select Size',
                        controller: controller.sizeController,
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.projectcolor,
                        ),
                        onTap: () async {
                          final selected = await showMenu<String>(
                            color: AppColors.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            context: context,
                            position: RelativeRect.fromLTRB(
                              screenWidth * 0.1,
                              screenHeight * 0.9,
                              screenWidth * 0.05,
                              screenHeight * 0.05,
                            ),

                            items: [
                              const PopupMenuItem(value: 'S', child: Text('S')),
                              const PopupMenuItem(value: 'M', child: Text('M')),
                              const PopupMenuItem(value: 'L', child: Text('L')),
                              const PopupMenuItem(
                                value: 'XL',
                                child: Text('XL'),
                              ),
                              const PopupMenuItem(
                                value: 'XXL',
                                child: Text('XXL'),
                              ),
                            ],
                          );

                          if (selected != null) {
                            controller.sizeController.text = selected;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          CommonTextFieldTwo(
            labelName: 'Description',
            controller: controller.descriptionController,
            hintName: 'Write Description',
            maxLines: 3,
          ),
          SizedBox(height: screenHeight * 0.03),
          CommonTextFieldTwo(
            isBorderNeed: false,

            readOnly: true,
            hintName: 'Add Location',
            onTap: () {
              Get.to(
                () => const AddLocation(),
                transition: Transition.rightToLeft,
              );
            },
            hintStyle: GoogleFonts.dmSans(
              color: AppColor.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            fillColor: AppColors.textfieldbgcolor,
            suffixIcon: const Icon(Icons.keyboard_arrow_right, size: 30),
          ),
          SizedBox(height: screenHeight * 0.03),
          CommonTextFieldTwo(
            maxLength: 10,
            labelName: 'Phone Number',
            controller: controller.phoneController,
            hintName: 'Enter Phone Number',
            isRequired: true,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: screenHeight * 0.06),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.clearAllFields();
                },
                child: Container(
                  width: screenWidth / 2.3,
                  height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.borderGrey),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.dmSans(
                      fontSize: 12.sp,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth / 2.3,
                height: screenHeight * 0.055,
                child: Obx(
                  () => CommonButton(
                    loading: controller.addBuyAndSellLoading.value,
                    press: () {
                      if (controller.productName.text.isEmpty) {
                        CommonToast.show(msg: "Please enter Product Name");
                        return;
                      }

                      if (controller.subProductName.text.isEmpty) {
                        CommonToast.show(msg: "Please enter Sub Product Name");
                        return;
                      }
                      if (controller.selectedCategory.value.isEmpty) {
                        CommonToast.show(msg: "Please select Category");
                        return;
                      }
                      if (controller.priceController.text.isEmpty) {
                        CommonToast.show(msg: "Please enter Price");
                        return;
                      }
                      if (controller.sizeController.text.isEmpty) {
                        CommonToast.show(msg: "Please select Size");
                        return;
                      }
                      if (controller.descriptionController.text.isEmpty) {
                        CommonToast.show(msg: "Please enter Description");
                        return;
                      }
                      if (controller.phoneController.text.isEmpty) {
                        CommonToast.show(msg: "Please enter Phone Number");
                        return;
                      }
                      if (controller.country.text.isEmpty) {
                        CommonToast.show(msg: "Please Choose Address");
                        return;
                      }
                     widget.isEdit==true?controller.addBuyAndSell(widget.isEdit,id: widget.data?.id): controller.addBuyAndSell(widget.isEdit);
                    },
                    text: 'Post',
                    borderRadius: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageBox(double screenWidth, File? image,String? url) {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          image,
          width: screenWidth * 0.25,
          height: screenWidth * 0.25,
          fit: BoxFit.cover,
        ),
      );
    }
    else if (widget.isEdit) {
      if(url!.isNotEmpty){
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(url));
    }}

    return DottedBorder(
      color: Colors.brown,
      strokeWidth: 1.5,
      dashPattern: const [8, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      child: Container(
        width: screenWidth * 0.25,
        height: screenWidth * 0.25,
        color: Colors.grey.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_download_rounded,
              color: AppColors.projectcolor,
            ),
            Text(
              'Picture of Product',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textgrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
