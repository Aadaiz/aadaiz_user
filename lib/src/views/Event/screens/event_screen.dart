import 'package:aadaiz_customer_crm/src/res/components/event_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  EventController controller = Get.find<EventController>();

  List<Map<String, dynamic>> eventList = [
    {
      "title": "International Fashion Show",
      "date": "Mar 24, 2024",
      "time": "11:00 AM",
      "image": "https://images.unsplash.com/photo-1509631179647-0177331693ae",
    },
    {
      "title": "International Fashion Show",
      "date": "Mar 24, 2024",
      "time": "11:00 AM",
      "image": 'https://images.unsplash.com/photo-1509631179647-0177331693ae',
    },
    {
      "title": "International Fashion Show",
      "date": "Mar 24, 2024",
      "time": "11:00 AM",
      "image": "https://images.unsplash.com/photo-1521336575822-6da63fb45455",
    },
  ];

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
              suffixWidget: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tune),
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
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                controller.featureSelected.value == true
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
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                controller.featureSelected.value == false
                                    ? Border.all(color: AppColor.primary)
                                    : null,
                          ),
                          child: Text(
                            "Your Events",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value == false
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

            Expanded(
              child: ListView.builder(
                itemCount: eventList.length,
                itemBuilder: (context, index) {
                  var data = eventList[index];

                  return EventCard(
                    title: data['title'],
                    date: data['date'],
                    time: data['time'],
                    image: data['image'],
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
