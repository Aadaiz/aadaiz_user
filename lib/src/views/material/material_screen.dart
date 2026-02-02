import 'package:aadaiz_customer_crm/src/res/components/comming_soon.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/order/product_customization.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/filter_screen.dart';
import 'package:aadaiz_customer_crm/src/views/material/filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';
import '../review/review_list.dart';
import 'controller/material_controller.dart';
import 'material_details.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  final RefreshController refreshController =
  RefreshController(initialRefresh: true);
  bool isPrice = false;
  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(
            100,
            6.0.hp,
          ),
          child:  CommonAppBar(
            leadingclick:(){
              Get.back();
            }
            ,
            title: 'Material',
            // isCheck: true,
            //actionButton:
            // Image.asset('assets/dashboard/fabric.png',color: AppColor.primary,
            // ),
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,

          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4)
                    )
                  ]
                ),
                child: SearchField(
                  onChanged: (value) {
                    MaterialController.to
                        .getMaterials(isRefresh: true,search:value);
                  },

                  hinttext: 'Search By Keyword'
                )
              ),
              SizedBox(
                  height: screenHeight * 0.045
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Filter()
                          )
                      );
                    },
                    child: sortWidget(
                      title: 'Filters',
                      image: 'assets/images/sort.png'
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isPrice = !isPrice;
                        if(isPrice){
                          MaterialController.to.price.value='low_to_high';
                        }else{
                          MaterialController.to.price.value='high_to_low';
                        }
                      });
                      await  MaterialController.to
                          .getMaterials(isRefresh: true);
                    },
                    child: sortWidget(
                        title: !isPrice ? 'Price: Low to High' : 'Price: High to Low',
                      image: 'assets/images/l_h.png'
                    ),
                  ),
                  // SizedBox(
                  //   width: 5.0.wp,
                  //   child: _listIndex ==0?
                  //   InkWell(
                  //     onTap: (){
                  //
                  //       setState(() {
                  //
                  //         _listIndex=1;
                  //
                  //       });
                  //
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/list.png',
                  //       fit: BoxFit.contain,
                  //       height: 2.5.hp,
                  //       width: 1.8.wp
                  //     )
                  //   ):
                  //   InkWell(
                  //     onTap: (){
                  //
                  //       setState(() {
                  //
                  //         _listIndex=0;
                  //
                  //       });
                  //
                  //     },
                  //     child: Image.asset(
                  //       'assets/images/grid.png',
                  //       fit: BoxFit.fill,
                  //       width: 5.0.wp
                  //     )
                  //   )
                  // )
                ]
              ),
              SizedBox(
                height: Get.height*0.8,
                child: SmartRefresher(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: refreshController,
                  enablePullUp: true,
                  onRefresh: () async {
                    final result = await MaterialController.to
                        .getMaterials(isRefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    final result = await MaterialController.to
                        .getMaterials();
                    if (MaterialController.to.currentPage.value >=
                        MaterialController.to.totalPages.value) {
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
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03,
                          horizontal: screenWidth * 0.03,
                        ),
                        itemCount: MaterialController.to.materialList.value.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.60, // 🔥 IMPORTANT
                        ),
                        itemBuilder: (context, index) {
                          var data = MaterialController.to.materialList.value[index];
                          List images = data.image.split(',');

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
                                  builder: (_) => MaterialDetails(
                                    rating: rating,
                                    data: data,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child:Container(
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  AspectRatio(
                                    aspectRatio: 1 / 1.15,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover, // 🔥 IMPORTANT
                                            imageUrl: images.isNotEmpty ? images[0] : '',
                                            errorWidget: (_, __, ___) => _shimmerPlaceholder(),
                                            progressIndicatorBuilder: (_, __, ___) =>
                                                _shimmerPlaceholder(),
                                          ),
                                        ),

                                        /// FAVORITE ICON
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                MaterialController.to.likeList[index] =
                                                !MaterialController.to.likeList[index];
                                                HomeController.to
                                                    .addFavorite('material_id', data.id);

                                              });

                                            },
                                            child: CircleAvatar(
                                              radius: 14,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                MaterialController.to.likeList[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                size: 16,
                                                color: MaterialController.to.likeList[index]
                                                    ? AppColor.red
                                                    : AppColor.greyTitleColor,
                                              ),
                                            ),
                                          ),
                                        ),

                                        /// PRICE TAG
                                        Positioned(
                                          bottom: 0,
                                          left: -2,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColor.black,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: AppColor.white,
                                                width: 3.5,
                                              ),
                                            ),
                                            child: Text(
                                              '₹${data.price ?? ''}',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 10.sp,
                                                color: AppColor.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  /// CATEGORY
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      data.category ?? '',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.black,
                                      ),
                                    ),
                                  ),

                                  /// COLOR
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      data.color ?? '',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.subTitleColor,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  /// RATING + REVIEW
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: rating,
                                          itemSize: 14,
                                          itemBuilder: (_, __) => const Icon(
                                            Icons.star_rounded,
                                            color: Color(0xffFFA800),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                  () => ReviewList(
                                                id: data.id,
                                                value: 'material_id',
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'View Review',
                                            style: GoogleFonts.dmSans(
                                              fontSize: 10.sp,
                                              decoration: TextDecoration.underline,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),

                          );
                        },
                      )
                    ,
                  ),
                ),
              )
            ]
          )
        )
      )
    );

  }

  Widget sortWidget({image, title}){

    return Row(
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          width: 5.0.wp
        ),
        const Gap(8),
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              color: AppColor.textColor,
              fontSize: 9.0.sp,
              fontWeight: FontWeight.w400
            )
          )
        )
      ]
    );

  }
  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.white,
      ),
    );
  }


}