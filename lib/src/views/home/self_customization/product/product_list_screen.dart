import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/product_widget.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/components/common_toast.dart';
import '../../controller/home_controller.dart';
import 'filter_data_widget.dart';
import 'filter_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.id, this.index});
final dynamic id;
final dynamic index;
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index=widget.index-1;
   // HomeController.to.getProductList(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            Gap(3.0.hp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          'assets/images/back.png',
                          //   fit: BoxFit.contain,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: (){
                      Get.to(()=> const SearchScreen());
                    },
                    child: Image.asset(
                      'assets/images/search.png',
                      //height: 01.50.hp,
                      width: 5.00.wp,
                      fit: BoxFit.fill,
                      color: AppColor.primary,
                    ),
                  ),
                  // Gap(5.0.wp),
                  // Image.asset(
                  //   'assets/images/message.png',
                  //   fit: BoxFit.fill,
                  //   //  height: 10.0.hp,
                  //   width: 5.0.wp,
                  // ),
                ],
              ),
            ),
            Gap(3.0.hp),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: HomeController.to.categoryData.value.data!.isEmpty
                  ? Text('Loading')
                  : SizedBox(
                      height: 5.0.hp,
                      width: Get.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount:
                              HomeController.to.categoryData.value.data!.length,
                          itemBuilder: (context, index) {
                            var data = HomeController
                                .to.categoryData.value.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: ()  async{
                                  setState(() {
                                    _index = index;
                                  });
                                   HomeController.to.catId.value=data.id.toString();
                                  await HomeController.to
                                      .getProductList(isRefresh: true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _index == index
                                          ? AppColor.primary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: _index == index
                                              ? Colors.transparent
                                              : AppColor.borderGrey)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          data.catName ?? '',
                                          style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  fontSize: 10.00.sp,
                                                  color: _index == index
                                                      ? AppColor.white
                                                      : AppColor.primary,
                                                  fontWeight: FontWeight.w400)),
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
            ),
            Gap(3.0.hp),
            const FilterDataWidget(),
            Gap(3.0.hp),
            ProductWidget(
                    type: HomeController.to.listIndex.value,
              id:widget.id
                  ),
          ],
        ),
      )),
    );
  }

}
