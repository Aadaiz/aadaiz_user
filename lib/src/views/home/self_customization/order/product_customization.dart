import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/add_measurement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../res/widgets/common_app_bar.dart';
import '../../../review/review_list.dart';
import '../../model/productlist_model.dart';
import '../product/people_viewed_product_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, this.data, required this.rating});
  final PatternListDatum? data;
  final double rating;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<String> _fabric = ["5", "10"];
  String displayImage = '';
  int selected = 0;
  List images = [];
  List reviewImages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.data!.imageUrl.split(',');
    displayImage = images[0];
    HomeController.to.cartLoading(false);
    Future.delayed(const Duration(milliseconds: 500), () {
      HomeController.to.getReviewList(isRefresh: true, id: widget.data!.id);
      HomeController.to.getTailors(isRefresh: true,id: widget.data!.id,city: 'Madurai');
    });
    if (HomeController.to.reviewList.isNotEmpty) {
      reviewImages = HomeController.to.reviewList.value[0].images.split(',');
    }
  }

  int currentIndex = 0;
  ScrollController controller = ScrollController();
  // Add a boolean flag to control arrow clickability
  bool _isArrowClickable = true;
  void _handleArrowClick(bool isLeftArrow) async {
    if (_isArrowClickable) {
      setState(() {
        _isArrowClickable = false;
      });
      if (isLeftArrow) {
        await controller.animateTo(
          controller.offset - MediaQuery.of(context).size.width * 0.8,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentIndex--;
        });
      } else {
        await controller.animateTo(
          controller.offset + MediaQuery.of(context).size.width * 0.8,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          currentIndex++;
        });
      }

      // Delay to make arrows clickable after scrolling completes
      await Future.delayed(Duration(milliseconds: 200));

      setState(() {
        _isArrowClickable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    final String selectedValue = _fabric.first;

    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: PreferredSize(
          preferredSize: Size(
            100,
            5.5.hp,
          ),
          child: const CommonAppBar(
            title: 'Product',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: screenHeight * 0.022),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.data!.title ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.39.sp,
                            color: AppColor.black)),
                    Text('Starts from',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.00.sp,
                            color: AppColor.red))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: screenWidth * 0.5,
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
                        InkWell(
                          onTap: () {
                            Get.to(() => ReviewList(
                                  id: widget.data!.id,
                                  value: 'review_id',
                                ));
                          },
                          child: Text('View Review',
                              style: GoogleFonts.dmSans(
                                  fontSize: 14.00.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                  decoration: TextDecoration.underline)),
                        )
                      ])),
                  Text('₹${widget.data!.startsFrom ?? ''}',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 22.00.sp,
                          color: AppColor.black))
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Center(
                child: Container(
                    height: screenHeight * 0.22,
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.favorite_border,
                                        color: AppColor.black)),
                                InkWell(
                                    onTap: () {
                                      if (_isArrowClickable &&
                                          currentIndex > 0) {
                                        _handleArrowClick(true);
                                      }
                                    },
                                    child: Icon(Icons.arrow_back_ios,
                                        size: 24,
                                        color: AppColor.greyTitleColor)),
                              ]),
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: images.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    child: Image.network(
                                      images[i],
                                      width: screenWidth * 0.3,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    backgroundColor: AppColor.primary,
                                    child: Image.asset(
                                      'assets/images/send.png',
                                      color: AppColor.white,
                                    )),
                                InkWell(
                                  onTap: () {
                                    if (_isArrowClickable &&
                                        currentIndex < images.length - 1) {
                                      _handleArrowClick(false);
                                    }
                                  },
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 24, color: AppColor.greyTitleColor),
                                ),
                              ]),
                        ],
                      ),
                    ))),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                width: screenWidth,
                child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.022),
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
            const Gap(18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.6,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Want to Customize this",
                            style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    fontSize: 18.00.sp,
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.w500)),
                          ),
                          TextSpan(
                            text: ' Dress',
                            style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    fontSize: 18.00.sp,
                                    color: AppColor.red,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                color: AppColor.primary,
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Customize',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.white)),
                    Gap(8),
                    Image.asset(
                      'assets/images/custo.png',
                      height: 3.0.hp,
                    ),
                  ],
                )),
              ),
            ),
            const Gap(18),
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
                  : HomeController.to.reviewList.isEmpty
                      ? const SizedBox()
                      : Column(
                          children: [
                            RatingsWidget(
                                rating: widget.data!.rating,
                                totalRatings:
                                    HomeController.to.totalRating.value,
                                ratingCounts: HomeController.to.ratingCount
                                    .value // Replace with actual rating counts
                                ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(32, 8, 8, 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: screenWidth / 1.3,
                                            child: ListTile(
                                                title: Text('${HomeController.to.reviewList.value[0].user!.username ?? ''}'.capitalizeFirst!,
                                                    style: GoogleFonts.dmSans(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13.00.sp,
                                                        color: AppColor
                                                            .textColor)),
                                                subtitle: RatingBar(
                                                    initialRating: double.parse(
                                                        HomeController
                                                            .to
                                                            .reviewList
                                                            .value[0]
                                                            .rating),
                                                    direction: Axis.horizontal,
                                                    ignoreGestures: true,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    unratedColor: Colors.grey,
                                                    ratingWidget: RatingWidget(
                                                        full: const Icon(
                                                            Icons.star_rounded,
                                                            color: Color(0xffFFA800)),
                                                        half: const Icon(Icons.star_half_rounded, color: Color(0xffFFA800)),
                                                        empty: const Icon(Icons.star_outline_rounded, color: Color(0xffFFA800))),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('Helpful',
                                                      style: GoogleFonts.dmSans(
                                                          fontSize: 10.00.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColor
                                                              .borderGrey)),
                                                  Image.asset(
                                                      'assets/images/like.png',
                                                      height:
                                                          screenHeight * 0.045)
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
                                            color:
                                                Colors.white, //AppColor.white,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: ListTile(
                                            title: Text(
                                                'All ${HomeController.to.reviewList.length} review',
                                                style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11.00.sp,
                                                    color: AppColor.textColor)),
                                            trailing:   InkWell(
                                              onTap: () {
                                                Get.to(() => ReviewList(
                                                  id: widget.data!.id,
                                                  value: 'review_id',
                                                ));
                                              },
                                              child: Image.asset(
                                                  'assets/images/arrow_right_orange.png',
                                                  height: screenHeight * 0.022),
                                            ))),
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
                  SizedBox(
                      width: screenWidth,
                      child: Text('Top Sellers',
                          style: GoogleFonts.dmSans(
                              fontSize: 12.00.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black))),
                  const Gap(16),

                  Obx(()=>HomeController.to.tailorLoading.value?
                      CommonLoading():
                     Container(
                        width: screenWidth,
                      //  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 1),
                              blurRadius: 5,
                              spreadRadius: 0)
                        ]),
                        child: Column(children: [
                          ListTile(
                              tileColor: Colors.white,
                              selectedTileColor: Colors.white,
                              leading:  CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${HomeController.to.tailorList.value[0].shopName}')),
                              title: Text(HomeController.to.tailorList.value[0].shopName,
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.00.sp)),
                              subtitle: SizedBox(
                                  width: screenWidth * 0.3,
                                  child: Row(children: [
                                    RatingBar(
                                        initialRating: HomeController.to.tailorList.value[0].avgRate.toDouble(),
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 12,
                                        ignoreGestures: true,
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
                                    SizedBox(width: screenWidth * 0.01),
                                    Text('${HomeController.to.tailorList.value[0].avgRate} star',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 9.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.black))
                                  ])),
                              trailing: Column(children: [
                                Text('₹ ${HomeController.to.tailorList.value[0].category!.price}',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.00.sp,
                                        color: AppColor.black))
                              ])),
                       //   SizedBox(height: screenHeight * 0.01),
                          ExpansionTile(
                              title: Text('About Seller',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 10.00.sp,
                                      fontWeight: FontWeight.w400)),
                              trailing:
                                  Image.asset('assets/images/arrow_down.png'),
                              shape: const Border(),
                              expandedAlignment: Alignment.centerLeft,
                              children: [
                                Text('Reseller',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 10.00.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.hintTextColor))
                              ]),
                        ])),
                  ),
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddMeasurement()));
                      },
                      child: Container(
                        color: AppColor.primary,
                        padding: const EdgeInsets.all(8),
                        child: Center(
                            child: Text('Continue',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.00.sp,
                                    color: AppColor.white))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03)
          ]),
        ));
  }
}

class RatingsWidget extends StatelessWidget {
  final dynamic totalRatings;
  final List<dynamic> ratingCounts;
  final dynamic rating;
  const RatingsWidget({
    Key? key,
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
