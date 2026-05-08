// import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
// import 'package:aadaiz_customer_crm/src/utils/colors.dart';
// import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
// import 'package:aadaiz_customer_crm/src/utils/utils.dart';
// import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';
//
// class Completed extends StatefulWidget {
//   const Completed({super.key});
//
//   @override
//   State<Completed> createState() => _CompletedState();
// }
//
// class _CompletedState extends State<Completed> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // ConsultingController.to.getAppointments(status: 'completed');
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = Utils.getActivityScreenHeight(context);
//     final double screenWidth = Utils.getActivityScreenWidth(context);
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Today',
//             textAlign: TextAlign.center,
//             style: GoogleFonts.dmSans(
//               fontWeight: FontWeight.w500,
//               fontSize: 14.00.sp,
//               color: AppColor.primary,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.03),
//           SizedBox(
//             height: screenHeight * 0.72,
//             // child: Obx(
//             //   () =>
//             //       ConsultingController.to.appointmentLoading.value
//             //           ? const CommonLoading()
//             //           : ConsultingController.to.appointmentList.isEmpty
//             //           ? const CommonEmpty(title: 'appointments')
//             //           : ListView.builder(
//             //             itemCount:
//             //                 ConsultingController.to.appointmentList.length,
//             //             itemBuilder: (context, index) {
//             //               final data =
//             //                   ConsultingController.to.appointmentList[index];
//             //               return Container(
//             //                 padding: EdgeInsets.symmetric(
//             //                   horizontal: screenWidth * 0.033,
//             //                   vertical: screenHeight * 0.018,
//             //                 ),
//             //                 width: double.infinity,
//             //                 decoration: BoxDecoration(
//             //                   color: AppColor.scheduledContainerColor,
//             //                   borderRadius: const BorderRadius.only(
//             //                     topLeft: Radius.circular(18),
//             //                     topRight: Radius.circular(18),
//             //                     bottomRight: Radius.circular(18),
//             //                   ),
//             //                   boxShadow: [
//             //                     BoxShadow(
//             //                       color: AppColor.containerShadowColor
//             //                           .withOpacity(0.3),
//             //                       blurRadius: 18,
//             //                     ),
//             //                   ],
//             //                 ),
//             //                 child: ExpansionTile(
//             //                   expandedCrossAxisAlignment:
//             //                       CrossAxisAlignment.start,
//             //                   shape: const Border(),
//             //                   visualDensity: const VisualDensity(vertical: -3),
//             //                   leading:
//             //                       data.profileImage != null
//             //                           ? ClipRRect(
//             //                             borderRadius: BorderRadius.circular(50),
//             //                             child: CachedNetworkImage(
//             //                               fit: BoxFit.cover,
//             //                               errorWidget:
//             //                                   (context, url, error) =>
//             //                                       Container(
//             //                                         decoration: BoxDecoration(
//             //                                           color: AppColor.primary,
//             //                                         ),
//             //                                         child: Icon(
//             //                                           Icons.person,
//             //                                           color: AppColor.white,
//             //                                           size: screenWidth * 0.1,
//             //                                         ),
//             //                                       ),
//             //                               progressIndicatorBuilder:
//             //                                   (context, url, progress) =>
//             //                                       Shimmer.fromColors(
//             //                                         baseColor:
//             //                                             Colors.grey[300]!,
//             //                                         highlightColor:
//             //                                             Colors.grey[100]!,
//             //                                         child: Container(
//             //                                           decoration:
//             //                                               const BoxDecoration(
//             //                                                 color: Colors.white,
//             //                                               ),
//             //                                         ),
//             //                                       ),
//             //                               imageUrl: data.profileImage!,
//             //                             ),
//             //                           )
//             //                           : Container(
//             //                             decoration: BoxDecoration(
//             //                               shape: BoxShape.circle,
//             //                               color: AppColor.primary,
//             //                             ),
//             //                             child: Icon(
//             //                               Icons.person,
//             //                               color: AppColor.white,
//             //                               size: screenWidth * 0.1,
//             //                             ),
//             //                           ),
//             //                   title: Row(
//             //                     children: [
//             //                       Text(
//             //                         'Mr.${data.designerName ?? ''}',
//             //                         textAlign: TextAlign.center,
//             //                         style: GoogleFonts.dmSans(
//             //                           fontWeight: FontWeight.w400,
//             //                           fontSize: 13.00.sp,
//             //                           color: AppColor.black,
//             //                         ),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                   subtitle: Row(
//             //                     children: [
//             //                       Text(
//             //                         'Designer',
//             //                         textAlign: TextAlign.center,
//             //                         style: GoogleFonts.dmSans(
//             //                           fontWeight: FontWeight.w400,
//             //                           fontSize: 9.00.sp,
//             //                           color: AppColor.black,
//             //                         ),
//             //                       ),
//             //                     ],
//             //                   ),
//             //                   children: [
//             //                     Divider(color: AppColor.black.withOpacity(0.2)),
//             //                     Text(
//             //                       'Meeting Was Ended',
//             //                       textAlign: TextAlign.center,
//             //                       style: GoogleFonts.dmSans(
//             //                         fontWeight: FontWeight.w400,
//             //                         fontSize: 10.00.sp,
//             //                         color: AppColor.black,
//             //                       ),
//             //                     ),
//             //                     SizedBox(height: screenHeight * 0.01),
//             //                     Row(
//             //                       children: [
//             //                         SvgPicture.asset(
//             //                           'assets/svg/ic_calendar.svg',
//             //                         ),
//             //                         SizedBox(width: screenWidth * 0.018),
//             //                         Text(
//             //                           '${data.date ?? ''}',
//             //                           textAlign: TextAlign.center,
//             //                           style: GoogleFonts.dmSans(
//             //                             fontWeight: FontWeight.w400,
//             //                             fontSize: 10.00.sp,
//             //                             color: AppColor.black,
//             //                           ),
//             //                         ),
//             //                         const Spacer(),
//             //                         SvgPicture.asset('assets/svg/ic_clock.svg'),
//             //                         SizedBox(width: screenWidth * 0.018),
//             //                         Text(
//             //                           '${data.time ?? ''}',
//             //                           textAlign: TextAlign.center,
//             //                           style: GoogleFonts.dmSans(
//             //                             fontWeight: FontWeight.w400,
//             //                             fontSize: 10.00.sp,
//             //                             color: AppColor.black,
//             //                           ),
//             //                         ),
//             //                         const Spacer(),
//             //                         Text(
//             //                           '45 Min',
//             //                           textAlign: TextAlign.center,
//             //                           style: GoogleFonts.dmSans(
//             //                             fontWeight: FontWeight.w400,
//             //                             fontSize: 10.00.sp,
//             //                             color: AppColor.black,
//             //                           ),
//             //                         ),
//             //                         SizedBox(width: screenWidth * 0.03),
//             //                       ],
//             //                     ),
//             //                     Container(
//             //                       padding: EdgeInsets.symmetric(
//             //                         horizontal: screenWidth * 0.03,
//             //                       ),
//             //                       height: screenHeight / 2.8,
//             //                       decoration: const BoxDecoration(
//             //                         image: DecorationImage(
//             //                           alignment: Alignment.bottomCenter,
//             //                           image: AssetImage(
//             //                             'assets/images/consulting/container_overlay.png',
//             //                           ),
//             //                         ),
//             //                       ),
//             //                       child: Column(
//             //                         mainAxisAlignment: MainAxisAlignment.end,
//             //                         children: [
//             //                           Image.asset(
//             //                             'assets/images/consulting/see_design.png',
//             //                           ),
//             //                           SizedBox(height: screenHeight * 0.022),
//             //                           Row(
//             //                             mainAxisAlignment:
//             //                                 MainAxisAlignment.spaceBetween,
//             //                             children: [
//             //                               Container(
//             //                                 decoration: BoxDecoration(
//             //                                   color: AppColor.primary,
//             //                                   borderRadius:
//             //                                       BorderRadius.circular(8),
//             //                                 ),
//             //                                 width: screenWidth * 0.38,
//             //                                 height: screenHeight * 0.06,
//             //                                 child: Row(
//             //                                   mainAxisAlignment:
//             //                                       MainAxisAlignment.center,
//             //                                   children: [
//             //                                     SvgPicture.asset(
//             //                                       'assets/svg/ic_download.svg',
//             //                                       width: screenWidth * 0.05,
//             //                                     ),
//             //                                     SizedBox(
//             //                                       width: screenWidth * 0.03,
//             //                                     ),
//             //                                     Text(
//             //                                       'Your design',
//             //                                       textAlign: TextAlign.center,
//             //                                       style: GoogleFonts.dmSans(
//             //                                         fontWeight: FontWeight.w400,
//             //                                         fontSize: 9.00.sp,
//             //                                         color: Colors.white,
//             //                                       ),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ),
//             //                               Container(
//             //                                 decoration: BoxDecoration(
//             //                                   color: Colors.transparent,
//             //                                   borderRadius:
//             //                                       BorderRadius.circular(8),
//             //                                   border: Border.all(
//             //                                     color: AppColor.black
//             //                                         .withOpacity(0.2),
//             //                                   ),
//             //                                 ),
//             //                                 width: screenWidth * 0.38,
//             //                                 height: screenHeight * 0.06,
//             //                                 child: Row(
//             //                                   mainAxisAlignment:
//             //                                       MainAxisAlignment.center,
//             //                                   children: [
//             //                                     SvgPicture.asset(
//             //                                       'assets/svg/cube.svg',
//             //                                       width: screenWidth * 0.05,
//             //                                     ),
//             //                                     SizedBox(
//             //                                       width: screenWidth * 0.03,
//             //                                     ),
//             //                                     Text(
//             //                                       'Place Order',
//             //                                       textAlign: TextAlign.center,
//             //                                       style: GoogleFonts.dmSans(
//             //                                         fontWeight: FontWeight.w400,
//             //                                         fontSize: 9.00.sp,
//             //                                         color: AppColor.black,
//             //                                       ),
//             //                                     ),
//             //                                   ],
//             //                                 ),
//             //                               ),
//             //                             ],
//             //                           ),
//             //                           SizedBox(height: screenHeight * 0.02),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 ),
//             //               );
//             //             },
//             //           ),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/appointment_list_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConsultingController.to.getCompletedAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Column(
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
        Expanded(
          child: Obx(
                () => ConsultingController.to.completedLoading.value
                ? const CommonLoading()
                : ConsultingController.to.completedList.isEmpty
                ? const CommonEmpty(title: 'appointments')
                : ListView.builder(
              itemCount:
              ConsultingController.to.completedList.length,
              itemBuilder: (context, index) {
                final data =
                ConsultingController.to.completedList[index];
                return Padding(
                  padding:
                  EdgeInsets.only(bottom: screenHeight * 0.018),
                  child: _CompletedCard(
                    data: data,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CompletedCard extends StatelessWidget {
  final AppointmentData data;
  final double screenHeight;
  final double screenWidth;

  const _CompletedCard({
    required this.data,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
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
            color: AppColor.containerShadowColor.withOpacity(0.3),
            blurRadius: 18,
          ),
        ],
      ),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: const Border(),
        visualDensity: const VisualDensity(vertical: -3),
        leading: data.designer?.profilePhoto != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(color: AppColor.primary),
              child: Icon(Icons.person,
                  color: AppColor.white, size: screenWidth * 0.1),
            ),
            progressIndicatorBuilder: (context, url, progress) =>
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration:
                    const BoxDecoration(color: Colors.white),
                  ),
                ),
            imageUrl: data.designer!.profilePhoto!,
          ),
        )
            : Container(
          height: screenWidth * 0.12,
          width: screenWidth * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primary,
          ),
          child: Icon(Icons.person,
              color: AppColor.white, size: screenWidth * 0.1),
        ),
        title: Text(
          'Mr.${data.designer?.name ?? ''}',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 13.00.sp,
            color: AppColor.black,
          ),
        ),
        subtitle: Text(
          'Designer',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 9.00.sp,
            color: AppColor.black,
          ),
        ),
        children: [
          Divider(color: AppColor.black.withOpacity(0.2)),
          Text(
            'Meeting Was Ended',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 10.00.sp,
              color: AppColor.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              SvgPicture.asset('assets/svg/ic_calendar.svg'),
              SizedBox(width: screenWidth * 0.018),
              Text(
                data.date ?? '',
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
                data.time ?? '',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.00.sp,
                  color: AppColor.black,
                ),
              ),
              const Spacer(),
              Text(
                data.duration != null ? '${data.duration} Min' : '25 Min',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.00.sp,
                  color: AppColor.black,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          if (data.designerbookingImage.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: data.designerbookingImage.first.image ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported),
                        ),
                        progressIndicatorBuilder:
                            (context, url, progress) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01),
                    child: Text(
                      "Let's See Your Final Design",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 12.00.sp,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openImageSlider(
                            data.designerbookingImage
                                .map((e) => e.image ?? '')
                                .where((e) => e.isNotEmpty)
                                .toList(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: screenWidth * 0.38,
                          height: screenHeight * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/ic_download.svg',
                                width: screenWidth * 0.05,
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Text(
                                'Your design',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 9.00.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColor.black.withOpacity(0.2),
                          ),
                        ),
                        width: screenWidth * 0.38,
                        height: screenHeight * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/cube.svg',
                              width: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Text(
                              'Place Order',
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
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              child: Center(
                child: Text(
                  'No design uploaded yet',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.00.sp,
                    color: AppColor.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openImageSlider(List<String> images) {
    if (images.isEmpty) return;

    Get.to(() => ImageSliderScreen(images: images));
  }
}


class ImageSliderScreen extends StatefulWidget {
  final List<String> images;

  const ImageSliderScreen({
    super.key,
    required this.images,
  });

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${currentIndex + 1}/${widget.images.length}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return InteractiveViewer(
                  child: Center(
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.images.length > 1)
            SizedBox(
              height: 90,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final selected = currentIndex == index;

                  return GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 65,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selected ? Colors.white : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          widget.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}