import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/filter_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _values = const RangeValues(135, 2000);

  final List<String> categories = [
    'Women',
    'Girl',
    'Men',
    'Boys',
    'Price Range',
    'Ratings'
  ];
  List<PatternCategory> category = [];
  List<PatternCategory> subCategory = [];

  int selectedCategory = 0;
  int selectType = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = HomeController
        .to
        .filterList
        .value[selectedCategory]
        .patternCategories!;
    Future.delayed(const Duration(milliseconds: 500), () async {
      await HomeController.to.getFilterList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RangeLabels labels =
        RangeLabels(_values.start.toString(), _values.end.toString());

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.016),
                child: Image.asset('assets/images/back.png')),
          ),
          title: Text('Filter',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black)),
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 3.0.hp),
          child: Obx(
            () => HomeController.to.filterListLoading.value
                ? const CommonLoading()
                : HomeController.to.filterList.value.isEmpty
                    ? const CommonEmpty(title: 'Filters')
                    : Row(
                        children: [
                          // Sidebar
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColor.borderGrey.withOpacity(0.2),
                                  width: 2),
                            ),
                            width: Get.width * 0.3,
                            child: ListView.builder(
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                // if (index != 4 ) {
                                //   category = HomeController
                                //       .to
                                //       .filterList
                                //       .value[selectedCategory]
                                //       .patternCategories!;
                                // }

                                return Column(
                                  children: [
                                    Container(
                                      width: Get.width * 0.3,
                                      color: selectedCategory == index
                                          ? Colors.white
                                          : Colors.grey[200],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                selectedCategory = index;
                                              });
                                              if (index != 4 && index != 5) {
                                                category = HomeController
                                                    .to
                                                    .filterList
                                                    .value[selectedCategory]
                                                    .patternCategories!;

                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 8),
                                              child: Text(categories[index],
                                                  style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 14.00.sp,
                                                          color: AppColor.black,
                                                          fontWeight: FontWeight
                                                              .w400))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          // Main content
                          Column(
                            children: [
                              Gap(2.0.hp),
                              SizedBox(
                                height: Get.height * 0.83,
                                width: Get.width * 0.7,
                                child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: category.length,
                                    itemBuilder: (context, i) {
                                      var data = category[i];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 16),
                                            child: Row(
                                              children: [
                                                Text(category[i].catName ?? '',
                                                    style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 14.00.sp,
                                                            color:
                                                                AppColor.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))),
                                              ],
                                            ),
                                          ),
                                          data.patternFiltercategories!.isEmpty
                                              ? const SizedBox()
                                              : Wrap(
                                                  direction: Axis.horizontal,
                                                  children: data
                                                      .patternFiltercategories!
                                                      .asMap()
                                                      .entries
                                                      .map((i) {
                                                    int index = i.key + 1;
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectType = index;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            border: Border.all(
                                                                color: selectType ==
                                                                        index
                                                                    ? AppColor
                                                                        .red
                                                                    : Colors
                                                                        .transparent,
                                                                width: 1),
                                                            color:
                                                                AppColor.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                offset:
                                                                    const Offset(
                                                                        2, 2),
                                                                blurRadius: 20,
                                                                color: AppColor
                                                                    .unSelectColor
                                                                    .withOpacity(
                                                                        0.1),
                                                              )
                                                            ]),
                                                        child: Column(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:  BorderRadius.circular(8),
                                                                child: SizedBox(
                                                                    width: Get.width * 0.2,
                                                                    height: Get.width * 0.2,
                                                                    child: Image.network('${i.value.image}',
                                                                    fit: BoxFit.cover,))),
                                                            const SizedBox(
                                                                height: 8.0),
                                                            Text(
                                                                "${i.value.name ?? ''}",
                                                                style: GoogleFonts.dmSans(
                                                                    textStyle: TextStyle(
                                                                        fontSize:
                                                                            7.00
                                                                                .sp,
                                                                        color: AppColor
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400))),
                                                            const SizedBox(
                                                                height: 8.0),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList()),
                                          // SizedBox(
                                          //   //color: Colors.red,
                                          //  // height: Get.height * 0.3,
                                          //   width: Get.width * 0.7,
                                          //   child: GridView.builder(
                                          //     physics: const NeverScrollableScrollPhysics(),
                                          //     padding:
                                          //         const EdgeInsets.symmetric(
                                          //             horizontal: 16),
                                          //     gridDelegate:
                                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                                          //       crossAxisCount: 3,
                                          //       crossAxisSpacing: 8.0,
                                          //       mainAxisSpacing: 8.0,
                                          //       childAspectRatio: 0.7,
                                          //     ),
                                          //     itemCount: 20,
                                          //     // data.patternFiltercategories!
                                          //     //     .length,
                                          //     itemBuilder: (context, index) {
                                          //       final item =
                                          //           data.patternFiltercategories![
                                          //               index];
                                          //       return InkWell(
                                          //         onTap: () {
                                          //           setState(() {
                                          //             selectType = index;
                                          //           });
                                          //         },
                                          //         child: Container(
                                          //           decoration: BoxDecoration(
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(6),
                                          //               border: Border.all(
                                          //                   color: selectType ==
                                          //                           index
                                          //                       ? AppColor.red
                                          //                       : Colors
                                          //                           .transparent,
                                          //                   width: 1),
                                          //               color: AppColor.white,
                                          //               boxShadow: [
                                          //                 BoxShadow(
                                          //                   offset:
                                          //                       const Offset(
                                          //                           2, 2),
                                          //                   blurRadius: 20,
                                          //                   color: AppColor
                                          //                       .unSelectColor
                                          //                       .withOpacity(
                                          //                           0.1),
                                          //                 )
                                          //               ]),
                                          //           child: Column(
                                          //             children: [
                                          //               // Container(
                                          //               //   decoration:
                                          //               //       BoxDecoration(
                                          //               //     image:
                                          //               //         DecorationImage(
                                          //               //       image: NetworkImage(
                                          //               //           item.image),
                                          //               //       fit: BoxFit.fill,
                                          //               //     ),
                                          //               //   ),
                                          //               // ),
                                          //               SizedBox(height: 8.0),
                                          //               Text("{item.name ?? ''}",
                                          //                   style: GoogleFonts.dmSans(
                                          //                       textStyle: TextStyle(
                                          //                           fontSize:
                                          //                               7.00.sp,
                                          //                           color: AppColor
                                          //                               .black,
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .w400))),
                                          //               SizedBox(height: 8.0),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      );
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
