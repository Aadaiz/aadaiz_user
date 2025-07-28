import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/utils.dart';
import '../home/controller/home_controller.dart';
import '../home/self_customization/order/product_customization.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key, required this.id, required this.value});
  final int id;
  final String value;
  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      HomeController.to.getReviewList(isRefresh: true, id: widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(
          100,
          5.5.hp,
        ),
        child: const CommonAppBar(
          title: 'Ratings & Reviews',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(()=>
          !HomeController.to.reviewLoading.value?
              RatingsWidget(
                  rating: HomeController.to.averageRating.value,
                  totalRatings:
                  HomeController.to.totalRating.value,
                  ratingCounts: HomeController.to.ratingCount
                       // Replace with actual rating counts
              ):const SizedBox.shrink(),
            ),
            SizedBox(
              height: Get.height*0.78,
              child: SmartRefresher(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: refreshController,
                enablePullUp: true,
                onRefresh: () async {
                  final result = await HomeController.to.getReviewList(
                      isRefresh: true, value: '${widget.value}', id: widget.id);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await HomeController.to
                      .getReviewList(value: '${widget.value}', id: widget.id);
                  if (HomeController.to.reviewCurrentPage.value >=
                      HomeController.to.reviewTotalPages.value) {
                    refreshController.loadNoData();
                  } else {
                    if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadFailed();
                    }
                  }
                },
                child: Obx(()=>
                   ListView.builder(
                     physics: const NeverScrollableScrollPhysics(),
                      itemCount: HomeController.to.reviewList.value.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = HomeController.to.reviewList.value[index];
                        List images = data.images.split(',');
                        return Container(
                          child: Stack(
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
                                              title: Text('${data.user!.username ?? ''}'.capitalizeFirst!,
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
                                              trailing: Text('${data.date ?? ""} ${data.time ?? ""}', style: GoogleFonts.dmSans(fontWeight: FontWeight.w400, fontSize: 11.00.sp, color: AppColor.borderGrey)))),
                                      Text(
                                          '''
                                              ${data.comment ?? ''}'''
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
                                        '${data.user!.profile}')),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
