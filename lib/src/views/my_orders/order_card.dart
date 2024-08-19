import 'package:aadaiz/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../home/model/my_order_model.dart' as order;
import 'order_tracking/track_order.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, this.data, this.image, this.rating, this.status});
  final order.Datum? data;
  final dynamic image;
  final dynamic rating;
  final dynamic status;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Container(
        //height: screenHeight * 0.14,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: AppColor.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 1))
            ]),
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Row(children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius:BorderRadius.circular(12),
                      child: widget.image != null || widget.image != ''
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: screenHeight * 0.13,
                              width: screenHeight * 0.12,
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
                              progressIndicatorBuilder: (context, url, progress) =>
                                  Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              imageUrl: (widget.image[0]),
                            )
                          : SizedBox(
                        height: screenHeight * 0.13,
                        width: screenHeight * 0.12,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColor.blackBtnColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white, width: 2)),
                            width: screenWidth * 0.122,
                            height: screenHeight * 0.033,
                            alignment: Alignment.center,
                            child: Text('₹${widget.data!.patternDetails!.price??''}',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.00.sp,
                                    color: AppColor.white))))
                  ])),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: screenWidth / 1.8,
                        child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('${widget.data!.patternDetails!.title??''}',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.00.sp,
                                    color: AppColor.black)),
                            subtitle: Text('${widget.data!.patternDetails!.subTitle??''}',
                                style: GoogleFonts.dmSans(
                                    fontSize: 9.24.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.subTitleColor)),
                            trailing: Column(
                              children: [
                                widget.status==0?
                            widget.data!.cancelStatus=='0'?
                            InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const TrackOrder()));
                                    },
                                    child: Container(
                                        width: screenWidth * 0.22,
                                        height: screenHeight * 0.045,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColor.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 4))
                                            ]),
                                        child: Text(widget.status==2?'Re-Order':'Track Order',
                                            style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 8.12.sp,
                                                color: AppColor.black))))
                              :
                            InkWell(
                                  child: Container(
                                      width: screenWidth * 0.22,
                                      height: screenHeight * 0.045,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    AppColor.black.withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: Text('Cancel Order',
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8.12.sp,
                                              color: AppColor.black))),
                                ):
                                InkWell(
                                  child: Container(
                                      width: screenWidth * 0.22,
                                      height: screenHeight * 0.045,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                AppColor.black.withOpacity(0.2),
                                                blurRadius: 4,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: Text(widget.status==2?'Re-Order':'Leave Review',
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8.12.sp,
                                              color: AppColor.black))),
                                ),
                              ],
                            ))),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar(
                              initialRating: widget.rating??0.0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 12,
                              unratedColor: Colors.grey,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star_rounded,
                                      color: Color(0xffFFA800)),
                                  half: const Icon(Icons.star_half_rounded,
                                      color: Color(0xffFFA800)),
                                  empty: const Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFFA800))),
                              onRatingUpdate: (value) {
                                setState(() {
                                  // ratinglist[index] =
                                  //     value;
                                });
                              }),
                          SizedBox(width: screenWidth * 0.1),
                          widget.data!.cancelStatus=='0'&& widget.status==0?
                          Container(
                              alignment: Alignment.centerRight,
                              // width: screenWidth * 0.28,
                              child: Text('2 Hours Left for cancel \nThe order',
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8.12.sp,
                                      color: AppColor.warningColor))):const SizedBox()
                        ]),

                  ])
            ]),
            widget.status==1?
            Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.black.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 1)
                      )
                    ]
                ),
                child: ListTile(
                    visualDensity: const VisualDensity(
                        vertical: -3
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.018,
                        vertical: 0
                    ),
                    leading: Image.asset(
                      'assets/images/ic_invoice.png',
                      height: screenHeight * 0.033,
                    ),
                    title: Text(
                        'Invoice Download',
                        style: GoogleFonts.dmSans(
                            color: AppColor.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.00.sp
                        )
                    ),
                    trailing: Image.asset(
                      'assets/images/ic_download.png',
                      height: screenHeight * 0.033,
                    )
                )
            ):const SizedBox()
          ],
        ));
  }
}
