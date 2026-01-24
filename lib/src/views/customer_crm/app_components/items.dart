import 'package:aadaiz_customer_crm/src/res/components/image_preview.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetails extends StatelessWidget {
  final String title;

  final List<String> materialImages;
  final List<String> referenceImages;
  final List<String> drawnImages;
  final dynamic price;
  final dynamic quantity;

  const ProductDetails({
    super.key,
    required this.title,

    required this.materialImages,
    required this.referenceImages,
    required this.drawnImages,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Product Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.capitalizeFirst??'',
                    style: GoogleFonts.inter(
                        fontSize: 16.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    quantity,
                    style: GoogleFonts.inter(
                        fontSize: 14.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Text(
                "₹$price",
                style: GoogleFonts.inter(
                    fontSize: 16.0.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                ),
              ),


            ],
          ),

          SizedBox(height: 14.h),

          /// 🔹 Images Header
          Center(
            child: Text(
              'Design Specification',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.orangeColor,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          /// 🔹 Fabric Material Images
          if (materialImages.isNotEmpty) ...[
            sectionTitle("Fabric Material"),
            SizedBox(height: 8.h),
            imageSlider(materialImages),
            SizedBox(height: 24.h),
          ],

          /// 🔹 Reference Images
          if (referenceImages.isNotEmpty) ...[
            sectionTitle("Reference Images"),
            SizedBox(height: 8.h),
            imageSlider(referenceImages),
            SizedBox(height: 24.h),
          ],

          /// 🔹 Drawn Images
          if (drawnImages.isNotEmpty) ...[
            sectionTitle("Drawn Images"),
            SizedBox(height: 8.h),
            imageSlider(drawnImages),
          ],
        ],
      ),
    );
  }

  /// 🔹 Section Title
  Widget sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  /// 🔹 Image Slider
  Widget imageSlider(List<String> images) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final imageUrl = images[index];

          return ZoomableImageWrapper(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 210.w,
                height: 120.h,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 1.5),
                ),
                errorWidget: (_, __, ___) =>
                const Icon(Icons.error, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }

}
