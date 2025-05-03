import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetails extends StatelessWidget {
  final String title;
  final double price;
  final List<String> imageUrls;

  const ProductDetails({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(height: 20.h),
          Text(
            'Images',
            style: GoogleFonts.montserrat(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, color: Colors.red),
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
