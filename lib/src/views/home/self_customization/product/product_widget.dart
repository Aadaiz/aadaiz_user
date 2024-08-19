import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../order/product_customization.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, this.type, this.id});
  final dynamic type;
  final dynamic id;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final RefreshController refreshController =
  RefreshController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),()async{
      await HomeController.to
          .getProductList(isRefresh: true,id: widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  SizedBox(
        height: Get.height * 0.7,
        child: SmartRefresher(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            final result = await HomeController.to
                .getProductList(isRefresh: true,id: widget.id );
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result = await HomeController.to
                .getProductList(id: widget.id);
            if (HomeController.to.currentPage.value >=
                HomeController.to.totalPages.value) {
              refreshController.loadNoData();
            } else {
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            }
          },
          child:Obx(()=> HomeController.to.productList.value.isEmpty?
              const CommonEmpty(title: 'Products'):
         widget.type == 0 ?
         ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: HomeController.to.productList.value.length,
             itemBuilder: (context, index) {
               final data = HomeController.to.productList.value[0];
               List images = data.imageUrl.split(',');
               double rating;
               if (data.rating is int) {
                 rating = data.rating.toDouble();
               } else if (data.rating is double) {
                 rating = data.rating;
               } else {
                 rating = 1.0;
               }
               return InkWell(
                 onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => ProductDetails(
                               data: data,
                               rating:rating
                           )));
                 },
                 child: Column(
                   children: [
                     Container(
                         width: Get.width,
                         padding: const EdgeInsets.symmetric(
                             vertical: 8, horizontal: 8),
                         decoration: BoxDecoration(
                             color: AppColor.borderGrey.withOpacity(0.1),
                             borderRadius: BorderRadius.circular(8)),
                         child: Row(
                           children: [
                             Stack(
                               children: [
                                 Container(
                                   decoration: BoxDecoration(
                                       borderRadius:
                                       BorderRadius.circular(16),
                                       border: Border.all(
                                           color: AppColor.white, width: 3)),
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(16),
                                     child: data.imageUrl!=null||data.imageUrl!=''?
                                     CachedNetworkImage(
                                       fit: BoxFit.cover,
                                       height: Get.width * 0.3,
                                       width: Get.width * 0.25,
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
                                       height: Get.width * 0.3,
                                       width: Get.width * 0.25,
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
                                 ),
                                 Positioned(
                                   bottom: 0,
                                   left: 0,
                                   child: InkWell(
                                       onTap: () {},
                                       child: Container(
                                         decoration: BoxDecoration(
                                             color: AppColor.black,
                                             borderRadius:
                                             BorderRadius.circular(8),
                                             border: Border.all(
                                                 color: AppColor.white,
                                                 width: 3)),
                                         padding: const EdgeInsets.symmetric(
                                             vertical: 4, horizontal: 8),
                                         child: Center(
                                           child: Text(
                                             '₹${data.price ?? ''}',
                                             style: GoogleFonts.dmSans(
                                                 textStyle: TextStyle(
                                                     fontSize: 10.00.sp,
                                                     color: AppColor.white,
                                                     fontWeight:
                                                     FontWeight.w500)),
                                           ),
                                         ),
                                       )),
                                 ),
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 8),
                               child: Column(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       SizedBox(
                                         width: Get.width * 0.5,
                                         child: Text(
                                           data.title ?? '',
                                           maxLines: 1,
                                           overflow: TextOverflow.ellipsis,
                                           style: GoogleFonts.dmSans(
                                               textStyle: TextStyle(
                                                   fontSize: 15.00.sp,
                                                   color: AppColor.black,
                                                   fontWeight:
                                                   FontWeight.w500)),
                                         ),
                                       ),
                                       InkWell(
                                         onTap: (){
                                           setState(
                                                   () {
                                                     HomeController
                                                     .to
                                                     .likeList[index] = !HomeController
                                                     .to.likeList[index];
                                               });
                                           HomeController.to.addFavorite(data.id);
                                         },
                                         child:  Container(
                                           decoration: BoxDecoration(
                                               color: AppColor.white,
                                               shape: BoxShape.circle),
                                           padding: const EdgeInsets.all(6),
                                           child: HomeController
                                               .to
                                               .likeList[index]
                                               ? Icon(
                                             Icons.favorite,
                                             size: 2.0.hp,
                                             color: AppColor.red,
                                           )
                                               : Icon(
                                             Icons
                                                 .favorite_border_rounded,
                                             size: 2.0.hp,
                                             color:
                                             AppColor.greyTitleColor,
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                   Text(
                                     data.subTitle ?? '',
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: GoogleFonts.dmSans(
                                         textStyle: TextStyle(
                                             fontSize: 10.00.sp,
                                             color: AppColor.greyTitleColor,
                                             fontWeight: FontWeight.w400)),
                                   ),
                                   Gap(2.0.hp),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
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
                                       Gap(2.0.wp),
                                       Text(
                                         'View Review',
                                         style: GoogleFonts.dmSans(
                                             textStyle: TextStyle(
                                                 decoration: TextDecoration
                                                     .underline,
                                                 decorationColor:
                                                 AppColor.black,
                                                 fontSize: 10.00.sp,
                                                 color: AppColor.black,
                                                 fontWeight:
                                                 FontWeight.w400)),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         )),
                     Gap(1.5.hp),
                   ],
                 ),
               );
             }):
                 GridView.builder(
                   physics: const NeverScrollableScrollPhysics(),
                   padding: const EdgeInsets.only(top: 0),
                    itemCount: HomeController.to.productList.value.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.48,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final data = HomeController.to.productList.value[0];
                      List images = data.imageUrl.split(',');
                      double rating;
                      if (data.rating is int) {
                        rating = data.rating.toDouble();
                      } else if (data.rating is double) {
                        rating = data.rating;
                      } else {
                        rating = 1.0;
                      }
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                        data: data, rating: rating,
                                      )));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12)),
                                  child:data.imageUrl!=null||data.imageUrl!=''?
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
                                    imageUrl: (images[0]),
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
                                      padding: const EdgeInsets.all(6),
                                      child: data.isLiked??false
                                          ? Icon(
                                              Icons.favorite,
                                              size: 2.0.hp,
                                              color: AppColor.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border_rounded,
                                              size: 2.0.hp,
                                              color: AppColor.greyTitleColor,
                                            ),
                                    )),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColor.black,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: AppColor.white, width: 3)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Center(
                                          child: Text(
                                            '₹${data.price ?? ''}',
                                            style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    fontSize: 10.00.sp,
                                                    color: AppColor.white,
                                                    fontWeight: FontWeight.w500)),
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            Text(
                              data.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 15.00.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Gap(0.5.hp),
                            Text(
                              data.subTitle ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontSize: 10.00.sp,
                                      color: AppColor.greyTitleColor,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text(
                                  'View Review',
                                  style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColor.black,
                                          fontSize: 10.00.sp,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
