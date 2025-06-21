import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/order/product_customization.dart';
import 'package:aadaiz_customer_crm/src/views/material/filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
            title: 'Material',
            isCheck: true,
            actionButton: Image.asset('assets/dashboard/fabric.png',color: AppColor.primary,
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05
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
                  onChanged: (value) {},
                  onSubmitted: (value) {},
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
                  sortWidget(
                    title: 'Price: lowest to high',
                    image: 'assets/images/l_h.png'
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
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.8
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03
                        ),
                        itemCount: MaterialController.to.materialList.value.length,
                        itemBuilder: (_, int index){
                            var data =MaterialController.to.materialList.value[index];
                            List images = data.image.split(',');
                            double rating;
                            if (data.rating is int) {
                              rating = data.rating.toDouble();
                            } else if (data.rating is double) {
                              rating = data.rating;
                            } else {
                              rating = 1.0;
                            }
                          return Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth * 0.016
                              ),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>  MaterialDetails(rating: rating,data: data,)
                                        )
                                    );

                                  },
                                  child: SizedBox(
                                      width: screenWidth / 2.2,
                                      child: Column(
                                          children: [
                                            SizedBox(
                                              height: screenHeight * 0.26,
                                              child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(16),
                                                      child: data.image!=null||data.image!=''?
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
                                                      )
                                                          : SizedBox(
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
                                                      // Image.asset(
                                                      //   'assets/images/ethinic.png',
                                                      //   fit: BoxFit.cover,
                                                      //   height: Get.width * 0.3,
                                                      //   width: Get.width * 0.25,
                                                      // ),
                                                    ),
                                                    Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: InkWell(
                                                          onTap: (){
                                                            setState(() {
                                                              MaterialController.to.likeList[index]=
                                                              !MaterialController.to.likeList[index];
                                                            });
                                                            HomeController.to.addFavorite('material_id', data.id);
                                                          },
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColor.white,
                                                                  shape: BoxShape.circle
                                                              ),
                                                              padding: const EdgeInsets.all(6),
                                                              child: CircleAvatar(
                                                                  backgroundColor: Colors.white,
                                                                  radius: 8,
                                                                  child: MaterialController.to.likeList[index]
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
                                                              )
                                                          ),
                                                        )
                                                    ),
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
                                                                        color: AppColor.white,
                                                                        width: 3
                                                                    )
                                                                ),
                                                                padding: const EdgeInsets.symmetric(
                                                                    vertical: 4,
                                                                    horizontal: 8
                                                                ),
                                                                child: Center(child: Text(
                                                                        '₹${data.price??''}',
                                                                        style: GoogleFonts.dmSans(
                                                                            textStyle: TextStyle(
                                                                                fontSize: 10.00.sp,
                                                                                color: AppColor.white,
                                                                                fontWeight: FontWeight.w500
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                  ]
                                              ),
                                            ),
                                            ListTile(
                                                title: Text(data.title??'',
                                                    style: GoogleFonts.dmSans(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16.00.sp,
                                                        color: AppColor.black
                                                    )
                                                ),
                                                subtitle: Text(
                                                    '${data.subtitle??''}',
                                                    style: GoogleFonts.dmSans(
                                                        fontSize: 10.00.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.subTitleColor
                                                    )
                                                )
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  RatingBar(
                                                      initialRating: rating,
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
                                                  SizedBox(
                                                      width: screenWidth * 0.01
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      Get.to(()=> ReviewList(id: data.id,value: 'material_id',));
                                                    },
                                                    child: Text(
                                                        'View Review',
                                                        style: GoogleFonts.dmSans(
                                                            fontSize: 9.00.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color: AppColor.black,
                                                            decoration: TextDecoration.underline
                                                        )
                                                    ),
                                                  )
                                                ]
                                            )
                                          ]
                                      )
                                  )
                              )
                          );

                        }
                    ),
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

}