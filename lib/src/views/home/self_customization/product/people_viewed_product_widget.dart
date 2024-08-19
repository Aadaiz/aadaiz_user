import 'package:aadaiz/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/utils.dart';
import '../../model/productlist_model.dart';

class PeopleViewedProductWidget extends StatelessWidget {
  const PeopleViewedProductWidget({super.key, required this.data, this.images, this.rating});
final PatternListDatum data;
final dynamic images;
final dynamic rating;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Column(
        children: [
          Container(
            height: screenHeight * 0.27,
            width: screenWidth*0.4,
            decoration: BoxDecoration(
                color: AppColor.backGroundColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8)),
                    child: data.imageUrl!=null||data.imageUrl!=''?
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: screenHeight * 0.27,
                      width: screenWidth*0.4,
                      errorWidget: (context, url, error) =>
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      progressIndicatorBuilder:
                          (context, url, progress) =>
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      imageUrl: (images[0]),
                    )
                        : SizedBox(
                      height: screenHeight * 0.27,
                      width: screenWidth*0.4,
                      child:        Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   'assets/images/ethinic.png',
                    //   fit: BoxFit.cover,
                    //   height: Get.width * 0.3,
                    //   width: Get.width * 0.25,
                    // ),
                  ),
                  Positioned(
                      top: 7,
                      right: 5,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Icon(
                              Icons.favorite_border,
                              color: AppColor.black
                          )
                      )
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0.1,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.blackBtnColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          width: screenWidth * 0.13,
                          height: screenHeight * 0.04,
                          alignment: Alignment.center,
                          child: Text(
                              '₹${data.price??''}',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11.00.sp,
                                  color: AppColor.white
                              )
                          )
                      ),
                    ),
                  )
                ]
            ),
          ),
          SizedBox(
            width: screenWidth / 2.5,
            child: ListTile(
              title: Text(
                  data.title??'',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.00.sp,
                      color: AppColor.black
                  )
              ),
              subtitle: Text(
                  data.subTitle??'',
                  style: GoogleFonts.dmSans(
                      fontSize: 10.00.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.subTitleColor
                  )
              ),
            ),
          ),
          SizedBox(
              width: screenWidth / 2.5,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar(
                        initialRating: rating,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 12,
                        unratedColor: Colors.grey,
                        ratingWidget: RatingWidget(
                            full: const Icon(
                                Icons.star_rounded,
                                color: Color(0xffFFA800)),
                            half: const Icon(
                                Icons.star_half_rounded,
                                color: Color(0xffFFA800)),
                            empty: const Icon(
                                Icons
                                    .star_outline_rounded,
                                color:
                                Color(0xffFFA800))),
                        onRatingUpdate: (value) {}),
                    SizedBox(
                        width: screenWidth * 0.01
                    ),
                    Text(
                        'View Review',
                        style: GoogleFonts.dmSans(
                            fontSize: 9.00.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                            decoration: TextDecoration.underline
                        )
                    )
                  ]
              )
          )
        ]
    );
  }
}
