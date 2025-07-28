import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
class PendingTechnicalSupport extends StatefulWidget {
  const PendingTechnicalSupport({super.key});

  @override
  State<PendingTechnicalSupport> createState() => _PendingTechnicalSupportState();
}

class _PendingTechnicalSupportState extends State<PendingTechnicalSupport> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ProfileController.to.getSupportList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Obx(
          () =>
      ProfileController.to.supportListLoading.value
          ? CommonLoading()
          : ProfileController.to.supportList.isEmpty
          ? CommonEmpty(title: 'support')
          : ListView.builder(
        shrinkWrap: true,
        itemCount: ProfileController.to.supportList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = ProfileController.to.supportList[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal:screenWidth * 0.01,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical:screenHeight * 0.018,
                horizontal: screenWidth * 0.03,
              ),
              // height: widget.screenHeight * 0.18,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.2),
                    blurRadius: 7,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Ticket Number',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.primary,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.022),
                      Text(
                        '#${data.ticketNumber??""}',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 9.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${data.date??""}',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${data.title??""}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.00.sp,
                        color: AppColor.primary,
                      ),
                    ),
                    subtitle: Text(
                      '${data.description??""}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.00.sp,
                        color: AppColor.hintTextColor,
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.03,
                    width: screenWidth * 0.18,
                    decoration: BoxDecoration(
                      color: AppColor.supportStatusColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${data.status??""}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.00.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }

}