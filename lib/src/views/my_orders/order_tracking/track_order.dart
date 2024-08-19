import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/my_orders/order_tracking/timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.016
              ),
              child: Image.asset(
                  'assets/images/back.png'
              )
          ),
          title: Text(
              'Track Order',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
            vertical: screenHeight * 0.066
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primary,
                  border: Border.all(
                    color: AppColor.trackBorderColor
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth / 2.8,
                      height: screenHeight * 0.05,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'Order Details',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.00.sp,
                          color: AppColor.trackTextColor
                        )
                      )
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Expected Delivery Date',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.00.sp,
                                  color: AppColor.containerDividerColor
                              )
                          ),
                          Text(
                              '02 Mar 2024',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.00.sp,
                                  color: AppColor.containerDividerColor
                              )
                          )
                        ]
                      )
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Tracking ID',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.containerDividerColor
                                )
                            ),
                            Text(
                                'MRJ123456',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.containerDividerColor
                                )
                            )
                          ]
                      )
                    ),
                    const Spacer()
                  ]
                )
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.03
                ),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                padding: const EdgeInsets.all(8),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                  width: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.036
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      TimelineWidget(
                          isFirst: true,
                          isPast: true,
                          isLast: false,
                          eventCard: ListTile(
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                              vertical: -3
                            ),
                            leading: SvgPicture.asset(
                              'assets/svg/timeline_pickup.svg'
                            ),
                            title: Text(
                              'Pick Up',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            ),
                            subtitle: Text(
                                '03 Mar 2024, 04:25 PM',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.00.sp,
                                    color: AppColor.borderGrey
                                )
                            )
                          )
                      ),
                      TimelineWidget(
                          isFirst: false,
                          isPast: false,
                          isLast: false,
                          eventCard: ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  vertical: -3
                              ),
                            leading: SvgPicture.asset(
                                'assets/svg/timeline_inprogress.svg'
                            ),
                            title: Text(
                                'In Progress',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            ),
                            subtitle: Text(
                                '03 Mar 2024, 04:25 PM',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.00.sp,
                                    color: AppColor.borderGrey
                                )
                            )
                          )
                      ),
                      TimelineWidget(
                          isFirst: false,
                          isPast: false,
                          isLast: false,
                          eventCard: ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  vertical: -3
                              ),
                            leading: SvgPicture.asset(
                                'assets/svg/timeline_shipped.svg'
                            ),
                            title: Text(
                                'Shipped',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            ),
                            subtitle: Text(
                                'Expected 06 Mar 2024',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.00.sp,
                                    color: AppColor.borderGrey
                                )
                            )
                          )
                      ),
                      TimelineWidget(
                          isFirst: false,
                          isPast: false,
                          isLast: true,
                          eventCard: ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  vertical: -3
                              ),
                            leading: SvgPicture.asset(
                                'assets/svg/timeline_delivered.svg'
                            ),
                            title: Text(
                                'Delivered',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            ),
                            subtitle: Text(
                                '07 Mar 2024',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.00.sp,
                                    color: AppColor.borderGrey
                                )
                            )
                          )
                      )
                    ]
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.03
                ),
                child: Text(
                    'Deliver address',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: AppColor.black
                    )
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.03,
                  horizontal: screenWidth * 0.022
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 1)
                    )
                  ]
                ),
                child: ListTile(
                  title: Text(
                    'Josh',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 12.00.sp,
                          color: AppColor.textColor
                      )
                  ),
                  subtitle: Text(
                    'No 123, Vj street\nChennai - 600 028, Tamilnadu',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.borderGrey
                      )
                  )
                ),
              )
            ]
          )
        )
      )
    );

  }

}