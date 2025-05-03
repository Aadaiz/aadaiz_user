import 'dart:ffi';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/add_measurement.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:aadaiz_customer_crm/src/views/material/model/category_list_model.dart'
    as material;

import '../home/self_customization/order/product_customization.dart';
import '../home/self_customization/product/people_viewed_product_widget.dart';

class MaterialDetails extends StatefulWidget {
  const MaterialDetails({super.key, this.data, required this.rating});
  final dynamic data;
  final double rating;
  @override
  State<MaterialDetails> createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  final List<String> _fabric = ["5", "10"];
  String size = '';
  String displayImage = '';
  int selected = 0;
  List images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.data!.image.split(',');
    displayImage = images[0];
    HomeController.to.cartLoading(false);
    Future.delayed(const Duration(milliseconds: 500), () {
      HomeController.to.getReviewList(
          isRefresh: true, value: 'material_id', id: widget.data!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    final String selectedValue = _fabric.first;

    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
                  child: Image.asset('assets/images/back.png')),
            ),
            shadowColor: AppColor.black,
            forceMaterialTransparency: false,
            elevation: 4),
        body: SingleChildScrollView(
            child: Obx(
          () => Column(children: [
            SizedBox(height: screenHeight * 0.022),
            Center(
                child: Container(
                    height: screenHeight * 0.22,
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                        color: AppColor.productBgColor,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(displayImage),
                            fit: BoxFit.cover)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.03,
                                  top: screenHeight * 0.01),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.favorite_border,
                                      color: AppColor.black))),
                        ]))),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                height: Get.width * 0.15,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      displayImage = images[0];
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.018),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                displayImage = images[index];
                                selected = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selected == index
                                      ? AppColor.primary
                                      : Colors
                                          .transparent, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    10), // Match the border radius with ClipRRect
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  fit: BoxFit.cover,
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
                                  imageUrl: (images[index]),
                                ),
                              ),
                            ),
                          ));
                    })),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                //color: Colors.red,
                width: screenWidth,
                child: ListTile(
                    title: Text(widget.data!.title ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.39.sp,
                            color: AppColor.black)),
                    subtitle: Text(widget.data!.subtitle ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.24.sp,
                            color: AppColor.subTitleColor)),
                    trailing: Column(children: [
                      Text('₹${widget.data!.price ?? ''}',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 22.00.sp,
                              color: AppColor.black))
                    ]))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                      width: screenWidth,
                      child: Row(children: [
                        RatingBar(
                            initialRating: widget.rating,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15,
                            unratedColor: Colors.grey,
                            ratingWidget: RatingWidget(
                                full: const Icon(Icons.star_rounded,
                                    color: Color(0xffFFA800)),
                                half: const Icon(Icons.star_half_rounded,
                                    color: Color(0xffFFA800)),
                                empty: const Icon(Icons.star_outline_rounded,
                                    color: Color(0xffFFA800))),
                            onRatingUpdate: (value) {}),
                        SizedBox(width: screenWidth * 0.01),
                        Text('View Review',
                            style: GoogleFonts.dmSans(
                                fontSize: 14.00.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                                decoration: TextDecoration.underline))
                      ])),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                      width: screenWidth,
                      child: Text('Required Quantity',
                          style: GoogleFonts.dmSans(
                              fontSize: 14.00.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primary))),
                  SizedBox(height: screenHeight * 0.03),
                  TextFormField(
                      controller: MaterialController.to.length,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Enter Here',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.black.withOpacity(0.5),
                              fontSize: 10.00.sp),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: AppColor.black.withOpacity(0.5))))),
                  SizedBox(
                      width: screenWidth,
                      child: ListTile(
                          title: Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.022),
                            child: Text('Description',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.00.sp,
                                    color: AppColor.black)),
                          ),
                          subtitle: Text(widget.data!.description ?? '',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.00.sp,
                                  color: AppColor.subTitleColor)))),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.022,
              color: AppColor.containerDividerColor,
            ),
            Container(
                width: screenHeight,
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.1),
                child: Text('Ratings & Reviews',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.00.sp,
                        color: AppColor.textColor))),
            Obx(
              () => HomeController.to.reviewLoading.value
                  ? const CommonLoading()
              :HomeController.to.reviewList.value.isEmpty?
                  const SizedBox()
                  : Column(
                      children: [
                        RatingsWidget(
                            rating: widget.data!.rating,
                            averageRating:
                                HomeController.to.averageRating.value,
                            totalRatings: HomeController.to.totalRating.value,
                            ratingCounts: HomeController.to.ratingCount
                                .value // Replace with actual rating counts
                            ),

                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: screenWidth / 1.3,
                                        child: ListTile(
                                            title: Text('${HomeController.to.reviewList.value[0].user!.username ?? ''}'.capitalizeFirst!,
                                                style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.00.sp,
                                                    color: AppColor.textColor)),
                                            subtitle: RatingBar(
                                                initialRating: double.parse(HomeController
                                                    .to.reviewList.value[0].rating),
                                                direction: Axis.horizontal,
                                                ignoreGestures: true,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 15,
                                                unratedColor: Colors.grey,
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(Icons.star_rounded,
                                                        color: Color(0xffFFA800)),
                                                    half: const Icon(Icons.star_half_rounded,
                                                        color: Color(0xffFFA800)),
                                                    empty: const Icon(
                                                        Icons.star_outline_rounded,
                                                        color: Color(0xffFFA800))),
                                                onRatingUpdate: (value) {}),
                                            trailing: Text('${HomeController.to.reviewList.value[0].date ?? ""} ${HomeController.to.reviewList.value[0].time ?? ""}', style: GoogleFonts.dmSans(fontWeight: FontWeight.w400, fontSize: 11.00.sp, color: AppColor.borderGrey)))),
                                    Text(
                                        '''
                                              ${HomeController.to.reviewList.value[0].comment ?? ''}'''
                                            .capitalizeFirst!,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 10.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.textColor)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.033,
                                            bottom: screenHeight * 0.03),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('Helpful',
                                                  style: GoogleFonts.dmSans(
                                                      fontSize: 10.00.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColor.borderGrey)),
                                              Image.asset('assets/images/like.png',
                                                  height: screenHeight * 0.045)
                                            ])),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${HomeController.to.reviewList.value[0].user!.username}')),
                            ),
                          ],
                        ),
                        HomeController.to.reviewList.length > 1
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colors.white,//AppColor.white,
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: ListTile(
                                      title: Text(
                                          'All ${HomeController.to.reviewList.length} review',
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.00.sp,
                                              color: AppColor.textColor)),
                                      trailing: Image.asset(
                                          'assets/images/arrow_right_orange.png',
                                          height: screenHeight * 0.022))),
                            )
                            : const SizedBox(),
                      ],
                    ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Container(
                  //     width: screenWidth,
                  //     margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                  //     child: ListTile(
                  //         contentPadding: EdgeInsets.zero,
                  //         leading: Image.asset('assets/images/truck.png',
                  //             height: screenHeight * 0.05),
                  //         title: Text('Fast Delivery',
                  //             style: GoogleFonts.dmSans(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 13.00.sp,
                  //                 color: AppColor.black)),
                  //         subtitle: Text('Deliver from 2 Feb',
                  //             style: GoogleFonts.dmSans(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 11.00.sp,
                  //                 color: AppColor.hintTextColor)),
                  //         trailing: Text('Learn more',
                  //             style: GoogleFonts.dmSans(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 11.00.sp,
                  //                 color: AppColor.primary)))),
                  SizedBox(
                      width: screenWidth,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: screenHeight * 0.05,
                                //width: screenWidth * 0.28,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.primary),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset('assets/images/share.png',
                                          width: screenWidth * 0.08),
                                      Gap(8),
                                      Text('Share',
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.00.sp,
                                              color: Colors.white))
                                    ])),
                            Gap(screenWidth * 0.05),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // HomeController.to.cart(
                                  //   action: 'add',
                                  //   id: widget.data!.id,
                                  //   price: widget.data!.price,
                                  //   gst: widget.data!.price,
                                  //   quantity: 1,
                                  //   size: size,
                                  // );
                                },
                                child: Container(
                                    height: screenHeight * 0.05,
                                    // width: screenWidth * 0.45,
                                    // padding: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: AppColor.black, width: 2)),
                                    child: HomeController.to.cartLoading.value
                                        ? SizedBox(
                                            // height: 1.00.hp,
                                            width: 1.00.wp,
                                            child: LoadingAnimationWidget
                                                .horizontalRotatingDots(
                                              color: AppColor.primary,
                                              size: 5.00.hp,
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                                Image.asset(
                                                    'assets/images/bag.png',
                                                    height:
                                                        screenHeight * 0.025),
                                                SizedBox(
                                                  width: screenWidth * 0.05,
                                                ),
                                                Text('Add to cart',
                                                    style: GoogleFonts.dmSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.00.sp,
                                                        color: Colors.black))
                                              ])),
                              ),
                            )
                          ])),
                  Gap(screenWidth * 0.05),
                  Container(
                      width: screenWidth,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                      child: Text('People Also Viewed',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.00.sp,
                              color: Colors.black))),
                  MaterialController.to.peopleMostViewList.value.isEmpty
                      ? const SizedBox()
                      : Row(
                    children: [
                      SizedBox(
                          height: screenHeight * 0.45,
                          width: screenWidth*0.92,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: MaterialController
                                  .to.peopleMostViewList.value.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = MaterialController
                                    .to.peopleMostViewList.value[index];
                                final images = data.image.split(',');
                                double rating;
                                if (data.rating is int) {
                                  rating = data.rating.toDouble();
                                } else if (data.rating is double) {
                                  rating = data.rating;
                                } else {
                                  rating = 1.0;
                                }
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MaterialDetails(
                                                          data: data,
                                                          rating: rating)));
                                        },
                                        child: PeopleViewedProductWidget(
                                            data: data,
                                            images: images,
                                            rating: rating)));
                              })),
                    ],
                  ),
                  // Gap(screenWidth * 0.05),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //       width: screenWidth,
                  //       height: screenHeight * 0.055,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           border: Border.all(color: AppColor.primary)),
                  //       alignment: Alignment.center,
                  //       child: Text('View More',
                  //           style: GoogleFonts.dmSans(
                  //               fontWeight: FontWeight.w400,
                  //               fontSize: 12.00.sp,
                  //               color: AppColor.black))),
                  // ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03)
          ]),
        )));
  }
}

class RatingsWidget extends StatelessWidget {
  final double averageRating;
  final dynamic totalRatings;
  final List<dynamic> ratingCounts;
  final dynamic rating;
  const RatingsWidget({
    Key? key,
    required this.averageRating,
    required this.totalRatings,
    required this.ratingCounts,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(children: [
                Text('${rating}',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 38.00.sp,
                        color: AppColor.textColor)),
                Text('$totalRatings ratings',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.00.sp,
                        color: AppColor.borderGrey))
              ]),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i <= 4; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                  5 - i,
                                  (index) => Icon(Icons.star,
                                      color: AppColor.starColor,
                                      size: Get.height * 0.022)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: (150 *
                                          ratingCounts[4 - i] /
                                          int.parse(totalRatings))
                                      .clamp(0, 200),
                                  height: Get.height * 0.022,
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(19))),
                              const SizedBox(width: 8),
                              Text(ratingCounts[4 - i].toString(),
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12.00.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.ratingTextColor))
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
