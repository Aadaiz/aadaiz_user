import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/review_designer.dart';
import 'package:aadaiz_customer_crm/src/views/review/review_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';

class DesignerDetail extends StatefulWidget {
  const DesignerDetail({super.key, required this.data});
  final Designer data;
  @override
  State<DesignerDetail> createState() => _DesignerDetailState();
}

class _DesignerDetailState extends State<DesignerDetail> {
  String date = '';
  String time = '';
  int selected = 0;
  dateConvert(dat) {
    var formatter = DateFormat('dd-MM-yyyy');
    setState(() {
      date = formatter.format(dat);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConsultingController.to.createAppointmentLoading(false);
    dateConvert(DateTime.now());
    if (ConsultingController.to.availableSlotsList.isNotEmpty) {
      time = ConsultingController.to.availableSlotsList[0];
    }

    Future.delayed(const Duration(milliseconds: 100), () async {
      ConsultingController.to.getAvailableSlots(1, date);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 5.5.hp),
        child: const CommonAppBar(title: 'Designer Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.022,
          ),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.033,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        spreadRadius: 10,
                        blurRadius: 10,
                      ), //BoxShadow
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.1,
                        child: Stack(
                          children: [
                            widget.data.profileImage != null
                                ? ClipOval(
                                  child: CachedNetworkImage(
                                    height: screenHeight * 0.088,
                                    width: screenHeight * 0.088,
                                    fit: BoxFit.cover,
                                    errorWidget:
                                        (context, url, error) => Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.primary,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: AppColor.white,
                                            size: screenHeight * 0.088,
                                          ),
                                        ),
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                    imageUrl: (widget.data.profileImage),
                                  ),
                                )
                                : Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.primary,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColor.white,
                                    size: screenHeight * 0.088,
                                  ),
                                ),
                            const Positioned(
                              top: 7,
                              right: 7,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: AppColor.circleDotColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) => // ReviewDesigner()
                                      ReviewList(
                                    id: widget.data.id,
                                    value: 'designer_id',
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: screenHeight * 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.name ?? ''}',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.00.sp,
                                  color: AppColor.designerColor,
                                ),
                              ),
                              Text(
                                '${widget.data.category ?? ''}',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.00.sp,
                                  color: AppColor.designerRoleColor,
                                ),
                              ),
                              Text(
                                '⭐️  ${widget.data.avgRate ?? 0} (${widget.data.totalRate ?? 0} reviews)',
                                style: GoogleFonts.dmSans(
                                  fontSize: 9.00.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.designerRoleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'About',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.022),
                Text(
                  '${widget.data.about ?? ''}',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.00.sp,
                    color: AppColor.hintTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Select Date',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.00.sp,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.022),
                CalendarTimeline(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2050),
                  activeDayColor: AppColor.white,
                  activeBackgroundDayColor: AppColor.primary,
                  monthColor: AppColor.black.withOpacity(0.5),
                  onDateSelected: (DateTime val) async {
                    await dateConvert(val);
                    ConsultingController.to.getAvailableSlots(1, date);
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Available Time',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.00.sp,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.022),
                Obx(
                  () =>
                      ConsultingController.to.availableSlotLoading.value
                          ? const CommonLoading()
                          : SizedBox(
                            height: Get.height * 0.04,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  ConsultingController
                                      .to
                                      .availableSlotsList
                                      .length,
                              itemBuilder: (context, index) {
                                var data =
                                    ConsultingController
                                        .to
                                        .availableSlotsList[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = index;
                                      time = data;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selected != index
                                              ? Colors.transparent
                                              : AppColor.primary,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColor.primary,
                                      ),
                                    ),
                                    width: Get.width / 5,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${data}',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color:
                                            selected != index
                                                ? AppColor.primary
                                                : AppColor.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return SizedBox(width: 12);
                              },
                            ),
                          ),
                ),
                SizedBox(height: 50),
                // Container(
                //     width: double.infinity,
                //     height: screenHeight * 0.05,
                //     margin: EdgeInsets.symmetric(
                //         vertical: screenHeight * 0.03
                //     ),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(3),
                //         border: Border.all(
                //             color: AppColor.dropdownBgColor
                //         )
                //     ),
                //     child: DropdownButton<String>(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 20
                //         ),
                //         borderRadius: BorderRadius.circular(3),
                //         underline: const SizedBox(),
                //         value: _selectedValue,
                //         style: GoogleFonts.dmSans(
                //             fontWeight: FontWeight.w400,
                //             fontSize: 11.00.sp,
                //             color: AppColor.black.withOpacity(0.5)
                //         ),
                //         isExpanded: true,
                //         hint: Text(
                //             'Select Duration',
                //             style: GoogleFonts.dmSans(
                //                 fontWeight: FontWeight.w400,
                //                 fontSize: 11.00.sp,
                //                 color: AppColor.black.withOpacity(0.5)
                //             )
                //         ),
                //         items: _duration.map<DropdownMenuItem<String>>((String val){
                //
                //           return DropdownMenuItem<String>(
                //               value: val,
                //               child: Text(
                //                   val
                //               )
                //           );
                //
                //         }).toList(),
                //         onChanged: (String? val) {}
                //     )
                // ),
                CommonButton(
                  borderRadius: 0.0,
                  press: () {
                    ConsultingController.to.createAppointment(
                      widget.data.id,
                      date,
                      time,
                    );
                  },
                  text: 'Continue',
                  loading:
                      ConsultingController.to.createAppointmentLoading.value,
                ),
                SizedBox(height: screenHeight * 0.022),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
