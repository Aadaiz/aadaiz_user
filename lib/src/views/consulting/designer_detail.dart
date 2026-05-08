import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/book_designer.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/contact.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_designer_model.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/models/consulting_details_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class _AvailableDate {
  final Availability availability;
  final DateTime date;

  _AvailableDate({required this.availability, required this.date});
}

class DesignerDetail extends StatefulWidget {
  final isOnline;

  const DesignerDetail({super.key, required this.data, this.isOnline = false});

  final Designer data;

  @override
  State<DesignerDetail> createState() => _DesignerDetailState();
}

class _DesignerDetailState extends State<DesignerDetail> {
  final controller = ConsultingController.to;

  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  dynamic selectedSlotId;

  static const Map<String, int> _dayNameToWeekday = {
    'mon': 1,
    'tue': 2,
    'wed': 3,
    'thu': 4,
    'fri': 5,
    'sat': 6,
    'sun': 7,
  };

  List<_AvailableDate> _buildAvailableDates(List<Availability> availability) {
    final today = DateTime.now();
    final result = <_AvailableDate>[];

    for (int offset = 0; offset < 15; offset++) {
      final candidate = DateTime(today.year, today.month, today.day + offset);
      final candidateWeekday = candidate.weekday;

      for (final avail in availability) {
        final dayKey = (avail.day?.toString() ?? '').toLowerCase().trim();
        final String shortKey =
        dayKey.length >= 3 ? dayKey.substring(0, 3) : dayKey;
        final weekday = _dayNameToWeekday[shortKey];

        if (weekday == candidateWeekday) {
          result.add(_AvailableDate(availability: avail, date: candidate));
          break;
        }
      }
    }

    return result;
  }

  String _formatTime(String time) {
    final date = DateFormat("HH:mm").parse(time);
    return DateFormat("h:mm a").format(date);
  }

  String _formatApiDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

  @override
  void initState() {
    super.initState();
    controller.getDesignerDetails(widget.data.id);
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
      body: Obx(() {
        if (controller.designerDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final detail = controller.designerDetail.value;

        if (detail == null) {
          return const SizedBox();
        }

        final availableDates = _buildAvailableDates(detail.availability ?? []);

        if (availableDates.isEmpty) {
          return Center(
            child: Text(
              'No available slots',
              style: GoogleFonts.dmSans(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        }

        if (selectedDateIndex >= availableDates.length) {
          selectedDateIndex = 0;
        }

        final currentSlots =
            availableDates[selectedDateIndex].availability.slots ?? [];

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.sp),
                decoration: BoxDecoration(
                  color: const Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        detail.profilePic != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: detail.profilePic,
                            height: 70.sp,
                            width: 70.sp,
                            fit: BoxFit.cover,
                          ),
                        )
                            : CircleAvatar(
                          radius: 35.sp,
                          backgroundColor: AppColor.primary,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35.sp,
                          ),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            height: 12.sp,
                            width: 12.sp,
                            decoration: BoxDecoration(
                              color: const Color(0xff4C6FFF),
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15.sp),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${detail.name ?? ''}".capitalizeFirst ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                          ),
                          SizedBox(height: 4.sp),
                          Text(
                            "${detail.designation ?? ''}",
                            style: GoogleFonts.dmSans(
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 6.sp),
                          Text(
                            "⭐ 4.5 (135 reviews)",
                            style: GoogleFonts.dmSans(
                              fontSize: 11.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.sp),
              Text(
                'About',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 12.sp),
              Text(
                "${detail.specialization ?? ''}",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: Colors.grey,
                  height: 1.7,
                ),
              ),
              SizedBox(height: 28.sp),
              Text(
                'Select Date',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 16.sp),
              SizedBox(
                height: 75.sp,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: availableDates.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.sp),
                  itemBuilder: (_, index) {
                    final entry = availableDates[index];
                    final isSelected = selectedDateIndex == index;
                    final dayLabel = DateFormat('EEE').format(entry.date);
                    final dayNum = DateFormat('d').format(entry.date);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                          selectedTimeIndex = 0;
                          selectedSlotId = null;
                        });
                      },
                      child: Container(
                        width: 58.sp,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dayLabel,
                              style: GoogleFonts.dmSans(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : Colors.grey,
                              ),
                            ),
                            SizedBox(height: 4.sp),
                            Text(
                              dayNum,
                              style: GoogleFonts.dmSans(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color:
                                isSelected ? Colors.white : AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 28.sp),
              Text(
                'Available Time',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 16.sp),
              currentSlots.isEmpty
                  ? Text(
                'No slots available for this day',
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              )
                  : Wrap(
                spacing: 10.sp,
                runSpacing: 10.sp,
                children: List.generate(currentSlots.length, (index) {
                  final slot = currentSlots[index];
                  final isSelected = selectedTimeIndex == index;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTimeIndex = index;
                        selectedSlotId = slot.slotId;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.sp,
                        vertical: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border:
                        Border.all(color: Colors.grey.shade400),
                      ),
                      child: Text(
                        _formatTime(slot.startTime.toString()),
                        style: GoogleFonts.dmSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : AppColor.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 55.sp),
              Obx(
                    () => CommonButton(
                  height: screenHeight * 0.045,
                  text: 'Continue',
                  loading: controller.bookingLoading.value,
                  press:
                () async {
                    final entry = availableDates[selectedDateIndex];
                    final String apiDate = _formatApiDate(entry.date);
                    final dynamic slotId = selectedSlotId ??
                        (currentSlots.isNotEmpty
                            ? currentSlots[0].slotId
                            : 1);

                    if (widget.isOnline == true) {
                      final bookRes =
                      await controller.bookAppointment(
                        designerId: widget.data.id,
                        date: apiDate,
                        slotId: slotId,
                        isOnline: true,
                      );

                      if (bookRes == null ||
                          bookRes['status'] != true) {
                        Get.snackbar(
                          'Error',
                          bookRes?['message'] ?? 'Booking failed',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      final dynamic bookingId =
                      bookRes['data']?['id'];
                      final int amount = int.parse( bookRes['data']?['amount']);


                      Get.to(
                            () => BookDesigner(
                          designerId: widget.data.id,
                          date: apiDate,
                          slotId: slotId,
                          isOnline: true,
                          bookingId: bookingId,
                          amount: amount,
                        ),
                      );
                    } else {
                      Get.to(
                            () => Contact(
                          designerId: widget.data.id,
                          date: apiDate,
                          slotId: slotId,
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        );
      }),
    );
  }
}