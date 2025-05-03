import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/utils.dart';

class Scheduled extends StatefulWidget {
  const Scheduled({super.key});

  @override
  State<Scheduled> createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Today',
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              fontSize: 14.00.sp,
              color: AppColor.primary)),
      SizedBox(height: screenHeight * 0.03),
      SizedBox(
        height: screenHeight * 0.7,
        //color: Colors.white,
        child: SmartRefresher(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: refreshController,
          enablePullUp: true,
          onRefresh: () async {
            final result = await ConsultingController.to
                .getAppointments(isRefresh: true, status: 'scheduled');
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await ConsultingController.to
                .getAppointments(status: 'scheduled');
            if (ConsultingController.to.currentPage.value >=
                ConsultingController.to.totalPages.value) {
              refreshController.loadNoData();
            } else {
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            }
          },
          child: Obx(
            () => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ConsultingController.to.appointmentList.length,
                itemBuilder: (context, index) {
                  var data = ConsultingController.to.appointmentList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.018),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.033,
                            vertical: screenHeight * 0.018),
                        width: screenWidth,
                        // height: screenHeight*0.3,
                        decoration: BoxDecoration(
                            color: AppColor.scheduledContainerColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomRight: Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.containerShadowColor
                                      .withOpacity(0.3),
                                  blurRadius: 18)
                            ]),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  data.profileImage != null
                                      ? Container(
                                          height: screenWidth * 0.15,
                                          width: screenWidth * 0.15,
                                          decoration: const BoxDecoration(),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.primary),
                                                child: Icon(Icons.person,
                                                    color: AppColor.white,
                                                    size: screenWidth * 0.1),
                                              ),
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              imageUrl: (data.profileImage),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.primary),
                                          child: Icon(Icons.person,
                                              color: AppColor.white,
                                              size: screenWidth * 0.1),
                                        ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Mr.${data.designerName ?? ''}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.00.sp,
                                              color: AppColor.black)),
                                      Text('${data.category ?? ''}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.00.sp,
                                              color: AppColor.black))
                                    ],
                                  ),
                                  Gap(screenWidth * 0.3),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColor.customGreen,
                                          borderRadius:
                                              BorderRadius.circular(33)),
                                      width: screenWidth * 0.22,
                                      height: screenHeight * 0.033,
                                      alignment: Alignment.center,
                                      child: Text('Scheduled ',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8.00.sp,
                                              color: AppColor.black)))
                                ],
                              ),
                              // ListTile(
                              //     visualDensity:
                              //         const VisualDensity(vertical: 0),
                              //     contentPadding: EdgeInsets.zero,
                              //     leading:
                              //     data.profileImage != null
                              //         ? ClipRRect(
                              //       borderRadius: BorderRadius.circular(50),
                              //           child: CachedNetworkImage(
                              //               fit: BoxFit.cover,
                              //               errorWidget: (context, url, error) =>
                              //                   Container(
                              //                 decoration: BoxDecoration(
                              //                     color: AppColor.primary),
                              //                 child: Icon(Icons.person,
                              //                     color: AppColor.white,
                              //                     size: screenWidth*0.1),
                              //               ),
                              //               progressIndicatorBuilder:
                              //                   (context, url, progress) =>
                              //                       Shimmer.fromColors(
                              //                 baseColor: Colors.grey[300]!,
                              //                 highlightColor: Colors.grey[100]!,
                              //                 child: Container(
                              //                   decoration: const BoxDecoration(
                              //                     color: Colors.white,
                              //                   ),
                              //                 ),
                              //               ),
                              //               imageUrl: (data.profileImage),
                              //             ),
                              //         ) :
                              //     Container(
                              //             decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //                 color: AppColor.primary),
                              //             child: Icon(Icons.person,
                              //                 color: AppColor.white,
                              //                 size: screenWidth*0.1),
                              //           ),
                              //     title: Row(children: [
                              //       Text('Mr.${data.designerName ?? ''}',
                              //           textAlign: TextAlign.center,
                              //           style: GoogleFonts.dmSans(
                              //               fontWeight: FontWeight.w400,
                              //               fontSize: 13.00.sp,
                              //               color: AppColor.black))
                              //     ]),
                              //     subtitle: Row(children: [
                              //       Text('${data.category ?? ''}',
                              //           textAlign: TextAlign.center,
                              //           style: GoogleFonts.dmSans(
                              //               fontWeight: FontWeight.w400,
                              //               fontSize: 9.00.sp,
                              //               color: AppColor.black))
                              //     ]),
                              //     trailing: Container(
                              //         decoration: BoxDecoration(
                              //             color: AppColor.customGreen,
                              //             borderRadius:
                              //                 BorderRadius.circular(33)),
                              //         width: screenWidth * 0.22,
                              //         height: screenHeight * 0.033,
                              //         alignment: Alignment.center,
                              //         child: Text('Scheduled ',
                              //             textAlign: TextAlign.center,
                              //             style: GoogleFonts.dmSans(
                              //                 fontWeight: FontWeight.w400,
                              //                 fontSize: 8.00.sp,
                              //                 color: AppColor.black)))),
                              Divider(color: AppColor.black.withOpacity(0.2)),
                              Text('Booking Information',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.00.sp,
                                      color: AppColor.black)),
                              SizedBox(height: screenHeight * 0.01),
                              Row(children: [
                                SvgPicture.asset('assets/svg/ic_calendar.svg'),
                                SizedBox(width: screenWidth * 0.018),
                                Text('${data.date ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.black)),
                                const Spacer(),
                                SvgPicture.asset('assets/svg/ic_clock.svg'),
                                SizedBox(width: screenWidth * 0.018),
                                Text('${data.time ?? ''}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.black)),
                                const Spacer()
                              ]),
                              Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: screenHeight * 0.045,
                                      alignment: Alignment.center,
                                      width: screenWidth / 3,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.primary),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text('Cancel',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.00.sp,
                                              color: AppColor.primary))),
                                  CommonButton(
                                    text: 'Join Meeting',
                                    width: Get.width * 0.4,
                                    height: screenHeight * 0.045,
                                    press: () {},
                                    loading: false,
                                    borderRadius: 8.0,
                                  ),
                                ],
                              ),
                            ])),
                  );
                }),
          ),
        ),
      ),
    ]);
  }
}
