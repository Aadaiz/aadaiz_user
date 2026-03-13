import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class YourAdsItemCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String size;
  final String price;
  final String status;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;


  const YourAdsItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.size,
    required this.price,
    required this.status,
    this.onEdit,
    this.onDelete,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    final List<String> imageUrls =
    image.split(',').map((url) => url.trim()).toList();

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.035),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: screenWidth * 0.22,
                    height: screenHeight * 0.12,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.12,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: imageUrls.map((imageUrl) {
                        return CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: screenWidth * 0.22,
                          height: screenHeight * 0.12,
                          progressIndicatorBuilder: (_, __, ___) =>
                              CustomWidgets.shimmerPlaceholder(),
                          errorWidget: (_, __, ___) =>
                              CustomWidgets.shimmerPlaceholder(),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.03),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.dmSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03,
                              vertical: screenHeight * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              status,
                              style: GoogleFonts.dmSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.005),

                      Text(
                        subtitle,
                        style: GoogleFonts.dmSans(
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.012),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Size : $size",
                            style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "₹$price",
                            style: GoogleFonts.dmSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            Row(
              children: [
                InkWell(
                  onTap: onEdit,
                  child: Container(
                    height: screenHeight * 0.045,
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderGrey),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Edit',
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CommonButton(
                  height: screenHeight * 0.045,
                  width: screenWidth * 0.4,
                  press: (){},
                  text: 'Delete Ad',
                  borderRadius: 0.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}