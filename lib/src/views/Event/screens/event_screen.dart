import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/components/event_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/create_event_screen.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_filter.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventController controller = Get.find<EventController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: 'Events'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04),
            SearchField(
              hintText: "Search Events",
              showSuffix: true,
              onChanged: (val) {
                controller.getEventData(true, search: val);
              },
              suffixWidget: InkWell(
                onTap: () {
                  Get.to(
                    () => const EventFilter(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.tune),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.featureSelected.value = true;
                          controller.getEventData(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                controller.featureSelected.value
                                    ? Border.all(color: AppColor.primary)
                                    : null,
                          ),
                          child: Text(
                            "Events",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.07),
                      InkWell(
                        onTap: () {
                          controller.featureSelected.value = false;
                          controller.getEventData(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                !controller.featureSelected.value
                                    ? Border.all(color: AppColor.primary)
                                    : null,
                          ),
                          child: Text(
                            "Your Events",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  !controller.featureSelected.value
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const CreateEventScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColor.primary),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.04,
                          height: screenWidth * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.primary,
                              size: 13,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        Text(
                          'Add Event',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Obx(() {
              if (controller.getEventDataLoading.value) {
                return const Expanded(child: ShimmerList());
              }

              if (controller.eventData.isEmpty) {
                return const Expanded(
                  child: Center(child: Text('No Data Found')),
                );
              }

              final isEventTab = controller.featureSelected.value;

              return Expanded(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: () {
                    controller.getEventData(true);
                  },
                  onLoading: () {
                    controller.getEventData(false);
                  },
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.eventData.length,
                    itemBuilder: (context, index) {
                      final data = controller.eventData[index];

                      if (isEventTab) {
                        return EventCard(
                          title: data.eventName ?? '',
                          date:
                              data.startDate != null
                                  ? DateFormat(
                                    'dd MMM yyyy',
                                  ).format(data.startDate!)
                                  : '',
                          time: data.startTime ?? '',
                          image: data.eventImage ?? '',
                          onTap: () {
                            Get.to(
                              () => EventViewScreen(
                                title: data.eventName ?? '',
                                date:
                                    data.startDate != null
                                        ? DateFormat(
                                          'dd MMM yyyy',
                                        ).format(data.startDate!)
                                        : '',
                                time: data.startTime ?? '',
                                image: data.eventImage ?? '',
                                city: data.eventCity ?? '',
                                area: data.eventArea ?? '',
                                description: data.aboutEvent ?? '',
                                mobile: data.eventMobileNumber ?? '',
                                email: data.eventEmail ?? '',
                              ),
                              transition: Transition.rightToLeft,
                            );
                          },
                        );
                      } else {
                        return Obx((){
                       return YourEventCard(
                         editLoading: controller.eventDeleteLoading.value,
                            title: data.eventName ?? '',
                            date:
                                data.startDate != null
                                    ? DateFormat(
                                      'dd MMM yyyy',
                                    ).format(data.startDate!)
                                    : '',
                            time: data.startTime ?? '',
                            image: data.eventImage ?? '',
                            status: data.eventStatus ?? '',
                            onEdit: () {
                              Get.to(
                                () =>  CreateEventScreen(isEdit: true,data: data),
                                transition: Transition.rightToLeft,
                              );
                            },
                            onDelete: () {
                              controller.deleteEvent(data.id!);
                            },
                            ontap: () {
                              Get.to(
                                () => EventViewScreen(
                                  title: data.eventName ?? '',
                                  date:
                                      data.startDate != null
                                          ? DateFormat(
                                            'dd MMM yyyy',
                                          ).format(data.startDate!)
                                          : '',
                                  time: data.startTime ?? '',
                                  image: data.eventImage ?? '',
                                  city: data.eventCity ?? '',
                                  area: data.eventArea ?? '',
                                  description: data.aboutEvent ?? '',
                                  mobile: data.eventMobileNumber ?? '',
                                  email: data.eventEmail ?? '',
                                ),
                                transition: Transition.rightToLeft,
                              );
                            },
                          );}
                        );
                      }
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
