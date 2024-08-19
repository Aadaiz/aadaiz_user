import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OfferBannerWidget extends StatefulWidget {
  const OfferBannerWidget({super.key, });
  @override
  State<OfferBannerWidget> createState() => _OfferBannerWidgetState();
}

class _OfferBannerWidgetState extends State<OfferBannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    HomeController.to.bannerList.value.isEmpty?
    const SizedBox()
        : SizedBox(
        height: 20.0.hp,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
            ),
            itemCount: HomeController.to.bannerList.value.length,
            itemBuilder: (context, index){
              var data = HomeController.to.bannerList.value[index];
          return   Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(24),
              //   child:  Image.asset(
              //     'assets/images/self.png',
              //     fit:BoxFit.fill,
              //     height: 20.0.hp,
              //     width: Get.width*0.8,
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                      height: 20.0.hp,
                      width: Get.width*0.8,
                  errorWidget: (context, url, error) =>
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.0.hp,
                          width: Get.width*0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                  progressIndicatorBuilder:
                      (context, url, progress) =>           Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.0.hp,
                          width: Get.width*0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                  imageUrl: (data.imageUrl),
                ),
              ),
              Gap(5.0.wp)
            ],
          ) ;
        }),
      ),
    );
  }
}
