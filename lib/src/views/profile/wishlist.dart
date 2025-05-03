import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';
import '../home/controller/home_controller.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final RefreshController refreshController =
  RefreshController(initialRefresh: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeController.to.cartLoading(false);
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(
            100,
            8.0.hp,
          ),
          child: const CommonAppBar(
            title: 'My Wishlist',
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                    horizontal: screenWidth * 0.033),
                child: Column(children: [
                  Container(
                      height: screenHeight,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.05),
                      child: SmartRefresher(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: refreshController,
                        enablePullUp: true,
                        onRefresh: () async {
                          final result = await HomeController.to
                              .getFavouriteList(isRefresh: true);
                          if (result) {
                            refreshController.refreshCompleted();
                          } else {
                            refreshController.refreshFailed();
                          }
                        },
                        onLoading: () async {
                          final result = await HomeController.to
                              .getFavouriteList();
                          if (HomeController.to.favoriteCurrentPage.value >=
                              HomeController.to.favoriteTotalPages.value) {
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
                          GridView.builder(
                              shrinkWrap: true,
                              itemCount: HomeController.to.favoriteList.value.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.47,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                              itemBuilder: (context, index) {
                                final data = HomeController.to.favoriteList.value[index];
                                final currentData =data!.patern;
                                List images =[];
                                double rating=0.0;
                                if(data.patern!=null){
                                  images = data.patern!.imageUrl.split(',');
                                  if (data.patern!.rating is int) {
                                    rating = data.patern!.rating.toDouble();
                                  } else if (data.patern! is double) {
                                    rating = data.patern!.rating;
                                  } else {
                                    rating = 1.0;
                                  }
                                }


                                return Padding(
                                    padding:
                                        EdgeInsets.only(right: screenWidth * 0.016),
                                    child: SizedBox(
                                        // height: screenHeight / 3.8,
                                        width: screenWidth / 2.2,
                                        child: Column(children: [
                                          Stack(children: [
                                            ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(12)),
                                              child:data.patern!.imageUrl!=null||data.patern!.imageUrl!=''?
                                              CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 25.0.hp,
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
                                                imageUrl: images[0],
                                              ):
                                              SizedBox(
                                                height: 25.0.hp,
                                                child:          Shimmer.fromColors(
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
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        shape: BoxShape.circle),
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 8,
                                                        child: Image.asset(
                                                            'assets/images/trash_white.png',
                                                            color: AppColor
                                                                .trashColor)))),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColor.black,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                            border: Border.all(
                                                                color:
                                                                    AppColor.white,
                                                                width: 3)),
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 8),
                                                        child: Center(
                                                            child: Text('₹${currentData!.price??''}',
                                                                style: GoogleFonts.dmSans(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            10.00.sp,
                                                                        color: AppColor.white,
                                                                        fontWeight: FontWeight.w500)))))))
                                          ]),
                                          ListTile(
                                              title: Text('${currentData!.title??''}',
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16.00.sp,
                                                      color: AppColor.black)),
                                              subtitle: Text('${currentData!.subTitle??''}',
                                                  style: GoogleFonts.dmSans(
                                                      fontSize: 10.00.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color:
                                                          AppColor.subTitleColor))),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RatingBar(
                                                    initialRating: rating,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 15,
                                                    ignoreGestures: true,
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
                                                SizedBox(width: screenWidth * 0.01),
                                                Text('View Review',
                                                    style: GoogleFonts.dmSans(
                                                        fontSize: 9.00.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.black,
                                                        decoration: TextDecoration
                                                            .underline))
                                              ]),
                                          const Gap(8),
                                          InkWell(
                                            onTap: () {
                                              HomeController.to.cart(
                                                action: 'add',
                                                id: currentData.id,
                                                price: currentData.price,
                                                gst: currentData.gstPercentage,
                                                quantity: 1,
                                              );
                                            },
                                            child: Container(
                                                width: double.infinity,
                                              //  height: screenHeight * 0.055,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: AppColor.black)),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                  child: HomeController.to.cartLoading.value
                                                      ? SizedBox(
                                                    // height: 1.00.hp,
                                                    width: 1.00.wp,
                                                    child: LoadingAnimationWidget
                                                        .horizontalRotatingDots(
                                                      color: AppColor.primary,
                                                      size: 2.00.hp,
                                                    ),
                                                  )
                                                      :Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                            'assets/images/bag.png',
                                                            height:
                                                                screenHeight * 0.02),
                                                        SizedBox(
                                                            width: screenWidth * 0.023),
                                                        Text('Add to cart',
                                                            style: GoogleFonts.dmSans(
                                                                fontSize: 11.11.sp,
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                color: AppColor.black))
                                                      ]),
                                                )),
                                          )
                                        ])));
                              }),
                        ),
                      )),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('Buy And Sell',
                  //           style: GoogleFonts.dmSans(
                  //               fontSize: 16.00.sp,
                  //               color: AppColor.textColor,
                  //               fontWeight: FontWeight.w400)),
                  //       Image.asset('assets/images/arrow_up.png',
                  //           height: screenHeight * 0.045)
                  //     ]),
                  // Container(
                  //     height: screenHeight / 2,
                  //     alignment: Alignment.center,
                  //     margin:
                  //         EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                  //     child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         shrinkWrap: true,
                  //         itemCount: 2,
                  //         itemBuilder: (context, index) {
                  //           return Padding(
                  //               padding:
                  //                   EdgeInsets.only(right: screenWidth * 0.016),
                  //               child: SizedBox(
                  //                   // height: screenHeight / 3.8,
                  //                   width: screenWidth / 2.2,
                  //                   child: Column(children: [
                  //                     Stack(children: [
                  //                       SizedBox(
                  //                           child: Image.asset(
                  //                               'assets/images/ethinic.png',
                  //                               fit: BoxFit.cover)),
                  //                       Positioned(
                  //                           top: 5,
                  //                           right: 5,
                  //                           child: Container(
                  //                               decoration: BoxDecoration(
                  //                                   color: AppColor.white,
                  //                                   shape: BoxShape.circle),
                  //                               padding:
                  //                                   const EdgeInsets.all(6),
                  //                               child: CircleAvatar(
                  //                                   backgroundColor:
                  //                                       Colors.white,
                  //                                   radius: 8,
                  //                                   child: Image.asset(
                  //                                       'assets/images/trash_white.png',
                  //                                       color: AppColor
                  //                                           .trashColor)))),
                  //                       Positioned(
                  //                           bottom: 0,
                  //                           left: 0,
                  //                           child: InkWell(
                  //                               onTap: () {},
                  //                               child: Container(
                  //                                   decoration: BoxDecoration(
                  //                                       color: AppColor.black,
                  //                                       borderRadius:
                  //                                           BorderRadius.circular(
                  //                                               8),
                  //                                       border: Border.all(
                  //                                           color:
                  //                                               AppColor.white,
                  //                                           width: 3)),
                  //                                   padding: const EdgeInsets.symmetric(
                  //                                       vertical: 4,
                  //                                       horizontal: 8),
                  //                                   child: Center(
                  //                                       child: Text('₹145',
                  //                                           style: GoogleFonts.dmSans(
                  //                                               textStyle: TextStyle(
                  //                                                   fontSize:
                  //                                                       10.00.sp,
                  //                                                   color: AppColor.white,
                  //                                                   fontWeight: FontWeight.w500)))))))
                  //                     ]),
                  //                     ListTile(
                  //                         title: Text('Mini',
                  //                             style: GoogleFonts.dmSans(
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontSize: 16.00.sp,
                  //                                 color: AppColor.black)),
                  //                         subtitle: Text('Vado Odelle Dress',
                  //                             style: GoogleFonts.dmSans(
                  //                                 fontSize: 10.00.sp,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 color:
                  //                                     AppColor.subTitleColor))),
                  //                     Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Row(
                  //                               children:
                  //                                   List.generate(5, (index) {
                  //                             return Icon(Icons.star,
                  //                                 color: AppColor.starColor,
                  //                                 size: screenHeight * 0.016);
                  //                           })),
                  //                           SizedBox(width: screenWidth * 0.01),
                  //                           Text('View Review',
                  //                               style: GoogleFonts.dmSans(
                  //                                   fontSize: 9.00.sp,
                  //                                   fontWeight: FontWeight.w400,
                  //                                   color: AppColor.black,
                  //                                   decoration: TextDecoration
                  //                                       .underline))
                  //                         ]),
                  //                     Container(
                  //                         width: double.infinity,
                  //                         height: screenHeight * 0.055,
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             border: Border.all(
                  //                                 color: AppColor.black)),
                  //                         alignment: Alignment.center,
                  //                         child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment.center,
                  //                             children: [
                  //                               Image.asset(
                  //                                   'assets/images/bag.png',
                  //                                   height:
                  //                                       screenHeight * 0.03),
                  //                               SizedBox(
                  //                                   width: screenWidth * 0.013),
                  //                               Text('Add to cart',
                  //                                   style: GoogleFonts.dmSans(
                  //                                       fontSize: 11.11.sp,
                  //                                       fontWeight:
                  //                                           FontWeight.w400,
                  //                                       color: AppColor.black))
                  //                             ]))
                  //                   ])));
                  //         }))
                ]))));
  }
}
