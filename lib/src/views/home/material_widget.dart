import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/material/controller/material_controller.dart';
import 'package:aadaiz/src/views/material/material_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FabricWidget extends StatefulWidget {
  const FabricWidget({super.key});

  @override
  State<FabricWidget> createState() => _FabricWidgetState();
}

class _FabricWidgetState extends State<FabricWidget> {
  bool isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  int customFunction(int number) {
    if (number % 2 == 0) {
      return 0;
    } else if (number % 3 == 0) {
      return 1;
    } else {
      return 2;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      MaterialController.to
          .getMaterials(isRefresh: true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       SizedBox(
          width: Get.width,
          child: MaterialController.to.materialLoading.value?
             const CommonLoading():
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: MaterialController.to.materialList.value.asMap().entries.take(4).map((entry) {
              int index = entry.key;
              var e = entry.value;
              bool prime = isPrime(index);
              int value = customFunction(index);
              double width;
              if (prime) {
                width = value == 1 ? 0.5 : 0.4;
              } else if (value == 1) {
                width = 0.3;
              } else {
                width =  0.45;
              }
              return InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 10.0.hp,
                        width: Get.width * width,
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
                        imageUrl: (e.image),
                      )
                    ),
                    index != 3
                        ? Positioned(
                            bottom: 8,
                            right: Get.width * width * 0.1,
                            child: Container(
                              width: Get.width * width * 0.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Text(
                                    e.title??"",
                                    style: GoogleFonts.sacramento(
                                      textStyle: TextStyle(
                                        fontSize: 12.00.sp,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                      onTap: (){
                        Get.to(()=> const MaterialScreen());
                      },
                          child: Container(
                              height: 10.0.hp,
                              width: Get.width * width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/explore.png',
                                    fit: BoxFit.fill,
                                    height: 3.0.hp,
                                  ),
                                  const Gap(8),
                                  Text(
                                    'Explore All',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 12.00.sp,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                  ],
                ),
              );
            }).toList(),
          )),
    );
  }
}
