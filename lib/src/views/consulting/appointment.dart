import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz/src/views/consulting/designers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/utils.dart';

class Appointment extends StatefulWidget {
  const Appointment({
    super.key,
  });

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  int _pickedCategoryIndex = -1;
  int _pickedDesignerIndex = -1;
  var categoryId;
  var designer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      ConsultingController.to.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Select Category',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black)),
            Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                height: screenHeight * 0.15,
                child: Obx(
                  () => ConsultingController.to.categoryLoading.value
                      ? const CommonLoading()
                      : ConsultingController.to.categoryList.isEmpty
                          ? const CommonEmpty(title: 'category')
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02),
                              itemCount:
                                  ConsultingController.to.categoryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data =
                                    ConsultingController.to.categoryList[index];
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _pickedCategoryIndex = index;
                                        categoryId=data.id;
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColor.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 4))
                                            ],
                                            border: Border.all(
                                                color: _pickedCategoryIndex ==
                                                        index
                                                    ? AppColor.requiredTextColor
                                                    : Colors.white)),
                                        child: Column(children: [
                                          data.imageUrl != null
                                              ? CachedNetworkImage(
                                                  height: screenHeight * 0.088,
                                                  width: screenWidth * 0.22,
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                         Container(
                                                           decoration: BoxDecoration(
                                                             color: AppColor.primary
                                                           ),
                                                           child: Icon(Icons.person,
                                                           color: AppColor.white,
                                                           size: screenHeight * 0.088),
                                                         ),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  imageUrl: (data.imageUrl),
                                                )
                                              :
                                          Container(
                                            decoration: BoxDecoration(
                                                color: AppColor.primary
                                            ),
                                            child: Icon(Icons.person,
                                                color: AppColor.white,
                                                size: screenHeight * 0.088),
                                          ),
                                          Text(
                                              "${data.name ?? ""}"
                                                  .capitalizeFirst!,
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 8.00.sp,
                                                  color: AppColor.black))
                                        ])));
                              }),
                )),
            Text('Designer Preference',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black)),
            Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                height: screenHeight * 0.17,
                child: Obx(
                  () => ConsultingController.to.categoryLoading.value
                      ? const CommonLoading()
                      : ConsultingController.to.designerPrefsList.isEmpty
                          ? const CommonEmpty(title: 'category')
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02),
                              itemCount: ConsultingController
                                  .to.designerPrefsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = ConsultingController
                                    .to.designerPrefsList[index];
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _pickedDesignerIndex = index;
                                        designer=data.name;
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.01),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.0065,
                                            horizontal: screenHeight * 0.0065),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: _pickedDesignerIndex ==
                                                        index
                                                    ? AppColor.requiredTextColor
                                                    : Colors.transparent)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: data.imageUrl != null
                                                    ? CachedNetworkImage(
                                                        height: screenHeight *
                                                            0.088,
                                                        width: screenHeight *
                                                            0.088,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColor.primary
                                                              ),
                                                              child: Icon(Icons.person,
                                                                  color: AppColor.white,
                                                                  size: screenHeight * 0.088),
                                                            ),
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Shimmer
                                                                    .fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        imageUrl:
                                                            (data.imageUrl),
                                                      )
                                                    :      Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColor.primary
                                                  ),
                                                  child: Icon(Icons.person,
                                                      color: AppColor.white,
                                                      size: screenHeight * 0.088),
                                                ),
                                              ),
                                              Text(
                                                  "${data.name ?? ""}"
                                                      .capitalizeFirst!,
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 8.00.sp,
                                                      color: AppColor.black))
                                            ])));
                              }),
                ))
          ]),
          CommonButton(
              press: () {
                if (_pickedDesignerIndex != -1 && _pickedCategoryIndex != -1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                               Designers(id: categoryId, designer: designer,)));
                }
              },
              text: 'Continue')
        ]);
  }
}
