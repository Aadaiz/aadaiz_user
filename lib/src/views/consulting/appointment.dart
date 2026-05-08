import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/designers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Appointment extends StatefulWidget {
  final bool isOnline;
  const Appointment({super.key, required this.isOnline});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  final ConsultingController controller = Get.find<ConsultingController>();

  final List<Map<String, String>> categoryImages = [
    {
      'label': 'Men',
      'url':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
    },
    {
      'label': 'Women',
      'url':
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
    },
    {
      'label': 'Boy-kid(1-12)',
      'url':
      '',
    },
    {
      'label': 'Girl-kid(1-12)',
      'url':
      '',
    },
  ];

  final List<Map<String, String>> designerPrefImages = [
    {
      'label': 'Male',
      'url':
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80',
    },
    {
      'label': 'Female',
      'url':
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=200&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Obx(
          () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColor.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.018),
            SizedBox(
              height: screenHeight * 0.135,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryImages.length,
                itemBuilder: (context, index) {
                  final item = categoryImages[index];
                  final isSelected =
                      controller.pickedCategoryIndex.value == index;
                  return GestureDetector(
                    onTap: () {
                      controller.pickedCategoryIndex.value = index;
                      controller.categoryId.value =
                      controller.categoryListStatic[index];
                      setState(() {});
                    },
                    child: Container(
                      width: screenWidth * 0.22,
                      margin:
                      EdgeInsets.only(right: screenWidth * 0.028),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(02),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.requiredTextColor
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: item['url']!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                              ),
                              errorWidget: (context, url, error) =>
                                  Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.person,
                                        color: Colors.grey),
                                  ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text(
                                  item['label']!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: AppColor.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.028),
            Text(
              'Designer Preference',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColor.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.018),
            Row(
              children: List.generate(designerPrefImages.length, (index) {
                final item = designerPrefImages[index];
                final isSelected =
                    controller.pickedDesignerIndex.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.pickedDesignerIndex.value = index;
                    controller.designer.value =
                    controller.designerPrefsListStatic[index];
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),

                      border: Border.all(
                        color: isSelected
                            ? AppColor.requiredTextColor
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    
                    ),
                    margin:
                    EdgeInsets.only(right: screenWidth * 0.055),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8,8,8,0),
                      child: Column(
                        children: [
                          Container(
                            width: screenWidth * 0.17,
                            height: screenWidth * 0.2,


                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: item['url']!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.person,
                                          color: Colors.grey),
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['label']!,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.028),
            Text(
              'Select Day',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColor.black,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  controller.dayList.length,
                      (index) => GestureDetector(
                    onTap: () {
                      controller.pickedDayIndex.value = index;
                      controller.selectedDay.value =
                      controller.dayList[index];
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                          controller.pickedDayIndex.value == index
                              ? AppColor.requiredTextColor
                              : AppColor.primary.withOpacity(0.2),
                        ),
                        color: controller.pickedDayIndex.value == index
                            ? AppColor.requiredTextColor.withOpacity(0.08)
                            : Colors.white,
                      ),
                      child: Text(
                        controller.dayList[index],
                        style: GoogleFonts.dmSans(
                          fontSize: 11.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Consultation Mode',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColor.black,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.018),
              padding:
              EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedMode.value.isEmpty
                      ? null
                      : controller.selectedMode.value,
                  isExpanded: true,
                  hint: Text(
                    'Select Mode',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColor.black.withOpacity(0.6),
                    ),
                  ),
                  items: controller.modeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColor.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    controller.selectedMode.value = value ?? '';
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            CommonButton(
              height: screenHeight * 0.055,
              press: () {
                if (controller.pickedDesignerIndex.value != -1 &&
                    controller.pickedCategoryIndex.value != -1 &&
                    controller.pickedDayIndex.value != -1 &&
                    controller.selectedMode.value.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Designers(isOnline: widget.isOnline),
                    ),
                  );
                }
              },
              text: 'Continue',
            ),
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }
}