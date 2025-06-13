import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/utils.dart';
import 'controller/consulting_controller.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConsultingController.to.getAppointments(status: 'completed');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today',
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              fontSize: 14.00.sp,
              color: AppColor.primary,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            height: screenHeight * 0.72,
            child: Obx(
              () =>
                  ConsultingController.to.appointmentLoading.value
                      ? CommonLoading()
                      : ConsultingController.to.appointmentList.isEmpty
                      ? CommonEmpty(title: 'appointments')
                      : ListView.builder(
                        itemCount:
                            ConsultingController.to.appointmentList.length,
                        itemBuilder: (context, index) {
                          var data =
                              ConsultingController.to.appointmentList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.033,
                              vertical: screenHeight * 0.018,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.scheduledContainerColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.containerShadowColor
                                      .withOpacity(0.3),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                            child: ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              shape: const Border(),
                              visualDensity: const VisualDensity(vertical: -3),
                              leading:
                                  data.profileImage != null
                                      ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          errorWidget:
                                              (context, url, error) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColor.primary,
                                                    ),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: AppColor.white,
                                                      size: screenWidth * 0.1,
                                                    ),
                                                  ),
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
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
                                          imageUrl: (data.profileImage!),
                                        ),
                                      )
                                      : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.primary,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColor.white,
                                          size: screenWidth * 0.1,
                                        ),
                                      ),
                              title: Row(
                                children: [
                                  Text(
                                    'Mr.${data.designerName ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.00.sp,
                                      color: AppColor.black,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Designer',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 9.00.sp,
                                      color: AppColor.black,
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                Divider(color: AppColor.black.withOpacity(0.2)),
                                Text(
                                  'Meeting Was Ended',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.00.sp,
                                    color: AppColor.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/ic_calendar.svg',
                                    ),
                                    SizedBox(width: screenWidth * 0.018),
                                    Text(
                                      '${data.date ?? ''}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset('assets/svg/ic_clock.svg'),
                                    SizedBox(width: screenWidth * 0.018),
                                    Text(
                                      '${data.time ?? ''}',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '45 Min',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                  ),
                                  height: screenHeight / 2.8,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      alignment: Alignment.bottomCenter,
                                      image: AssetImage(
                                        'assets/images/consulting/container_overlay.png',
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        'assets/images/consulting/see_design.png',
                                      ),
                                      SizedBox(height: screenHeight * 0.022),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.primary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            width: screenWidth * 0.38,
                                            height: screenHeight * 0.06,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/ic_download.svg',
                                                  width: screenWidth * 0.05,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.03,
                                                ),
                                                Text(
                                                  'Your design',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 9.00.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColor.black
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                            width: screenWidth * 0.38,
                                            height: screenHeight * 0.06,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/cube.svg',
                                                  width: screenWidth * 0.05,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.03,
                                                ),
                                                Text(
                                                  'Your design',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 9.00.sp,
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.02),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
