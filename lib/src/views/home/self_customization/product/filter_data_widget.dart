import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/colors.dart';
import 'filter_screen.dart';

class FilterDataWidget extends StatefulWidget {
  const FilterDataWidget({super.key});

  @override
  State<FilterDataWidget> createState() => _FilterDataWidgetState();
}

class _FilterDataWidgetState extends State<FilterDataWidget> {
  bool isPrice = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Get.to(() => const FilterScreen());
              },
              child: sortWidget(
                title: 'Filters',
                image: 'assets/images/sort.png',
              )),
          InkWell(
            onTap: () async {
              setState(() {
                isPrice = !isPrice;
                if(isPrice){
                  HomeController.to.price.value='asc';
                }else{
                  HomeController.to.price.value='desc';
                }
              });
              await HomeController.to.getProductList(
                  isRefresh: true);
            },
            child: sortWidget(
              title: !isPrice ? 'Price: Low to High' : 'Price: High to Low',
              image: 'assets/images/l_h.png',
            ),
          ),
          Obx(
            () => SizedBox(
              width: 5.0.wp,
              child: HomeController.to.listIndex.value == 0
                  ? InkWell(
                      onTap: () {
                        //   setState(() {
                        HomeController.to.listIndex.value = 1;
                        //    });
                      },
                      child: Image.asset(
                        'assets/images/list.png',
                        fit: BoxFit.contain,
                        height: 2.5.hp,
                        width: 2.0.wp,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        // setState(() {
                        HomeController.to.listIndex.value = 0;
                        // });
                      },
                      child: Image.asset(
                        'assets/images/grid.png',
                        fit: BoxFit.fill,
                        //  height: 10.0.hp,
                        width: 5.0.wp,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sortWidget({image, title}) {
    return Row(
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          //  height: 10.0.hp,
          width: 5.0.wp,
        ),
        const Gap(8),
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              color: AppColor.primary,
              fontSize: 11.0.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
