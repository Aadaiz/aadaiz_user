import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/product_list_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key, this.id});
final dynamic id;
  @override
  State<CategorySelectionScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
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
    // materialIndex.clear();
    // for(var i=0;i<material.length;i++){
    //   materialIndex.add(i);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: Get.width,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: HomeController.to.categoryData.value.data!
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key + 1;
                var e = entry.value;
                bool prime = isPrime(index);
                int value = customFunction(index);
                double bottomLeft;
                double bottomRight;
                double topRight;
                double topLeft;
                double width;
                if (prime) {
                  topRight = 24.0;
                  topLeft = 0.0;
                  bottomRight = 0.0;
                  bottomLeft = 0.0;
                  width = value == 1 ? 0.5 : 0.35;
                } else if (value == 1) {
                  topRight = 0.0;
                  topLeft = 24.0;
                  bottomRight = 0.0;
                  bottomLeft = 0.0;
                  width = 0.3;
                } else {
                  topRight = 0.0;
                  topLeft = 0.0;
                  bottomRight = 0.0;
                  bottomLeft = 0.0;
                  width = index == 4 ? 0.45 : 0.6;
                }
                return CategoryWidget(
                  height: 15.0.hp,
                  width: Get.width * width,
                  color: AppColor.unSelectColor,
                  image: e.imageUrl,
                  title: e.catName,
                  isTop: prime,
                  bottomLeft: bottomLeft,
                  bottomRight: bottomRight,
                  topRight: topRight,
                  topLeft: topLeft,
                  textColor: AppColor.white,
                  id: widget.id,
                  index:index,
                );
              }).toList(),
            )),
        //const Gap(8),
        // const CategoryItem(imagePath: 'assets/images/bridal.png', title: 'Bridal Gown',)
      ],
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {super.key,
      this.image,
      this.bottomLeft = 0.0,
      this.bottomRight = 0.0,
      this.topRight = 0.0,
      this.topLeft = 0.0,
      this.height,
      this.width,
      this.isTop = true,
      this.color,
      this.title,
      this.textColor, this.id, this.index});
  final dynamic image;
  final dynamic title;
  final dynamic bottomLeft;
  final dynamic bottomRight;
  final dynamic topRight;
  final dynamic topLeft;
  final dynamic height;
  final dynamic width;
  final dynamic isTop;
  final dynamic color;
  final dynamic textColor;
  final dynamic id;
  final dynamic index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() =>  ProductListScreen(id:id,index:index));
      },
      child: isTop
          ? SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(topRight),
                      topLeft: Radius.circular(topLeft),
                      bottomRight: Radius.circular(bottomRight),
                      bottomLeft: Radius.circular(bottomLeft),
                    ),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: height,
                      // width: width/2,
                    ),
                  ),
                  Positioned(
                    left: width * 0.3,
                    child: SizedBox(
                      width: width / 1.5,
                      child: Text(
                        title,
                        maxLines: 5,
                        style: GoogleFonts.alegreyaSc(
                          textStyle: TextStyle(
                            color: textColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(topRight),
                        topLeft: Radius.circular(topLeft),
                        bottomRight: Radius.circular(bottomRight),
                        bottomLeft: Radius.circular(bottomLeft)),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: width,
                      height: height,
                    ),
                  ),
                  Positioned(
                    top: height / 4,
                    right: 4,
                    child: SizedBox(
                      width: width / 2.2,
                      child: Text(
                        title,
                        maxLines: 5,
                        style: GoogleFonts.alegreyaSc(
                          textStyle: TextStyle(
                            color: textColor,
                            fontSize: 15.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final double fontSize;

  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.0.hp,
      width: Get.width * 0.92,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.alegreyaSc(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SpecialCategoryWidget extends StatelessWidget {
  const SpecialCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeController.to.categoryDataLoading.value
        ? const Text('loading')
        : HomeController.to.categoryData.value.specialPatterns!.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 35.0.hp,
                width: Get.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: HomeController
                      .to.categoryData.value.specialPatterns!.length,
                  itemBuilder: (context, index) {
                    final data = HomeController
                        .to.categoryData.value.specialPatterns![index];
                    List imageUrl = data.imageUrl.split(',');
                    return Container(
                      width: Get.width * 0.5, // Set a fixed width for each item
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2,
                            offset: const Offset(2, 0.1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          data.imageUrl != null || data.imageUrl != ''
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: Get.width * 0.45,
                                  height: 29.0.hp,
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
                                  imageUrl: (imageUrl[0]),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          Gap(1.0.hp),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text(
                              data.title?.toUpperCase() ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                             // maxLines: 2,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                  fontSize: 12.0.sp,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
  }
}
