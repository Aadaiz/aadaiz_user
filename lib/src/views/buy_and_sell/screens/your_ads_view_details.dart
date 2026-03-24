import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class YourAdsViewDetails extends StatefulWidget {
  final String title;
  final List<String> imageUrls;
  final String price;
  final String subtitle;
  final String size;
  final String address;
  final String descriptionTitle;
  final String description;

  const   YourAdsViewDetails({
    super.key,
    required this.title,
    required this.imageUrls,
    required this.price,
    required this.subtitle,
    required this.size,
    required this.address,
    required this.descriptionTitle,
    required this.description,
  });

  @override
  State<YourAdsViewDetails> createState() => _YourAdsViewDetailsState();
}

class _YourAdsViewDetailsState extends State<YourAdsViewDetails> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () {
            Get.back();
          },
          title: 'Your Ads',
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.28,
                        viewportFraction: 1,
                      ),
                      items:
                          widget.imageUrls.map((image) {
                            return CachedNetworkImage(
                              imageUrl: image,
                              width: screenWidth,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                              errorWidget:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                            );
                          }).toList(),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.dmSans(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "₹${widget.price}",
                        style: GoogleFonts.dmSans(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  Text(
                    widget.subtitle,
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.012),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: Colors.grey,
                      ),

                      SizedBox(width: screenWidth * 0.01),

                      Text(
                        widget.address,
                        style: GoogleFonts.dmSans(fontSize: 12.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  const Divider(),

                  SizedBox(height: screenHeight * 0.02),


                  Text(
                    "Size : ${widget.size}",
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Text(
                    widget.descriptionTitle,
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Text(
                    widget.description,
                    style: GoogleFonts.dmSans(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.borderGrey),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Edit',
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.04),

                Expanded(
                  child: CommonButton(
                    height: screenHeight * 0.055,
                    press: () {},
                    text: 'Delete Ad',
                    borderRadius: 0.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
