import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/search_screen.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/self_customize_category_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../res/components/app_bar.dart';
import '../../../res/components/search_field.dart';
import '../controller/home_controller.dart';

class SelfCustomizationHomeScreen extends StatefulWidget {
  const SelfCustomizationHomeScreen(
      {super.key, required this.catIndex, required this.id});
  final int catIndex;
  final int id;
  @override
  State<SelfCustomizationHomeScreen> createState() =>
      _SelfCustomizationHomeScreenState();
}

class _SelfCustomizationHomeScreenState
    extends State<SelfCustomizationHomeScreen> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = widget.catIndex;
    Future.delayed(const Duration(milliseconds: 500), () async {
      await HomeController.to.getCategoryData(widget.id);
    });

    // Calculate the offset to center the middle item
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Gap(3.0.hp),
                    const CustomizeAppBar(
                      text: 'Self Customization',
                    ),
                    const Gap(32),
                    SearchField(
                      controllers: HomeController.to.search,
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          HomeController.to.search.text = value;
                        });
                      },
                      onSubmitted: (value) async {
                        HomeController.to.search.text=value;
                        await HomeController.to
                            .getProductList(isRefresh:true)
                            .then((value)=>Get.to(()=> const SearchScreen()));
                      },
                      hinttext: 'Search By Keyword',
                    ),
                    const Gap(24),
                    HomeController.to.genderLoading.value
                        ? Text('loading')
                        : SizedBox(
                            height: 5.0.hp,
                            width: Get.width,
                            child: HomeController.to.genderList.value.isEmpty
                                ? Text('empty')
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: HomeController
                                        .to.genderList.value.length,
                                    itemBuilder: (context, index) {
                                      var data = HomeController
                                          .to.genderList.value[index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              _index = index;
                                            });
                                            await HomeController.to
                                                .getCategoryData(data.id);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _index == index
                                                    ? AppColor.primary
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      4, 4, 8, 4),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: _index ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors
                                                                    .transparent),
                                                        shape: BoxShape.circle),
                                                    child: CircleAvatar(
                                                      radius:
                                                          13, // Image radius
                                                      backgroundImage:
                                                          NetworkImage(
                                                              data.imageUrl),
                                                    ),
                                                  ),
                                                  Gap(2.0.wp),
                                                  Text(
                                                    data.catName ?? '',
                                                    style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 10.00.sp,
                                                            color: _index !=
                                                                    index
                                                                ? AppColor.black
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ),
                                                  //Gap(5.0.wp),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                          ),
                  ],
                ),
              ),
              const Gap(24),
              HomeController.to.categoryDataLoading.value ||
                      HomeController.to.categoryData.value.catDetails!
                              .slideImageUrl ==
                          null
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 20.0.hp,
                        width: Get.width * 0.96,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 20.0.hp,
                      width: Get.width * 0.96,
                      errorWidget: (context, url, error) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.0.hp,
                          width: Get.width * 0.96,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.0.hp,
                          width: Get.width * 0.96,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      imageUrl: HomeController
                          .to.categoryData.value.catDetails!.slideImageUrl,
                    ),
              const Gap(24),
              Container(
                width: Get.width,
                color: AppColor.primary,
                child: Center(
                  child: Text(
                    'Select By Category'.toUpperCase(),
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 17.00.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              const Gap(24),
              HomeController.to.categoryDataLoading.value
                  ? const CommonLoading()
                  : CategorySelectionScreen(id: widget.id),
              Gap(
                2.0.hp,
              ),
              Divider(
                color: const Color(0xffD9D9D9),
                thickness: 2.0.hp,
              ),
              const Gap(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/pin.png',
                    fit: BoxFit.fill,
                    height: 5.0.hp,
                  ),
                  const Spacer(),
                  HomeController.to.categoryDataLoading.value
                      ? const SizedBox()
                      : Column(
                          children: [
                            Text(
                              '${HomeController.to.specialPatternText[0]}',
                              style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                      fontSize: 12.00.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const Gap(8),
                            Text(
                              '${HomeController.to.specialPatternText[0]}'
                                  .toUpperCase(),
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12.00.sp,
                                      color: AppColor.titleGreen,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                  const Spacer(),
                ],
              ),
              const Gap(16),
              const SpecialCategoryWidget(),
              const Gap(24),
            ],
          ),
        ),
      )),
    );
  }
}
