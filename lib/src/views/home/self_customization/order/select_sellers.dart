import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/model/productlist_model.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/order/product_customization.dart';
import 'package:aadaiz_customer_crm/src/views/material/add_measurement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../res/widgets/common_app_bar.dart';

class SelectSellers extends StatefulWidget {
  const SelectSellers({super.key, required this.image, this.data});
  final File image;
  final PatternListDatum? data;
  @override
  State<SelectSellers> createState() => _SelectSellersState();
}

class _SelectSellersState extends State<SelectSellers> {
  var selected = -1;
  var price = '';

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
     HomeController.to.getTailors(
       isRefresh: true,
       id: '1',
       city: 'Madurai',
     );
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 5.5.hp),
        child: const CommonAppBar(title: 'Select Sellers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.045),
            widget.data!=null?
            ListTile(
              selectedTileColor: Colors.white,
              leading: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.primary),
                ),
                child: AnimatedRotation(
                  turns: 0.5,
                  duration: Duration(milliseconds: 300),
                  child: Image.file(widget.image),
                ),
              ),
              title: Text(
                '${widget.data!.title ?? ""}',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                ),
              ),
              subtitle: Text(
                '${widget.data!.description ?? ""}',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 8.7.sp,
                  color: AppColor.subTitleColor,
                ),
              ),
              trailing: Column(
                children: [
                  Text(
                    '₹${widget.data!.startsFrom ?? ''}',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.00.sp,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ):
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.primary),
              ),
              child: AnimatedRotation(
                turns: 0.5,
                duration: Duration(milliseconds: 300),
                child: Image.file(widget.image,fit: BoxFit.cover,),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Obx(
              () =>
                  HomeController.to.tailorLoading.value
                      ? CommonLoading()
                      : HomeController.to.tailorList.isEmpty
                      ? CommonEmpty(title: 'tailors')
                      : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: HomeController.to.tailorList.length,
                        itemBuilder: (context, i) {
                          var data = HomeController.to.tailorList[i];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: screenHeight * 0.03,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.grey[200],
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: data.image,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (
                                                BuildContext context,
                                                String url,
                                              ) =>
                                                  const CircularProgressIndicator(),
                                          errorWidget:
                                              (
                                                BuildContext context,
                                                String url,
                                                Object error,
                                              ) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      data.shopName ?? "",
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.00.sp,
                                      ),
                                    ),
                                    subtitle: SizedBox(
                                      width: screenWidth * 0.3,
                                      child: Row(
                                        children: [
                                          Row(
                                            children: List.generate(4, (index) {
                                              return Image.asset(
                                                'assets/images/star.png',
                                              );
                                            }),
                                          ),
                                          SizedBox(width: screenWidth * 0.01),
                                          Text(
                                            "${data.avgRate}" ?? '2.5',
                                            style: GoogleFonts.dmSans(
                                              fontSize: 9.00.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          '₹ ${data.category!.price ?? ""}',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.00.sp,
                                            color: AppColor.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ExpansionTile(
                                    title: Text(
                                      'About Seller',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 10.00.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    trailing: Image.asset(
                                      'assets/images/arrow_down.png',
                                    ),
                                  ),

                                  // ExpansionTile(
                                  //   title: Text(
                                  //     'Overall Rating',
                                  //     style: GoogleFonts.dmSans(
                                  //       fontSize: 10.00.sp,
                                  //       fontWeight: FontWeight.w400,
                                  //     ),
                                  //   ),
                                  //   trailing: Image.asset(
                                  //     'assets/images/arrow_down.png',
                                  //   ),
                                  // ),
                                  // const Divider(color: AppColor.dividerColor),
                                  // ListTile(
                                  //   leading: SizedBox(
                                  //     height: screenHeight * 0.045,
                                  //     child: Image.asset(
                                  //       'assets/images/clock.png',
                                  //     ),
                                  //   ),
                                  //   title: Text(
                                  //     'Fast Delivery By May 24, 2024',
                                  //     style: GoogleFonts.dmSans(
                                  //       fontWeight: FontWeight.w400,
                                  //       fontSize: 10.00.sp,
                                  //       color: AppColor.hintTextColor,
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected = i;
                                          price = data.category!.price;
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: screenHeight * 0.055,
                                        decoration: BoxDecoration(
                                          color:
                                              selected != i
                                                  ? Colors.white
                                                  : AppColor.primary,
                                          border: Border.all(
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          selected == i
                                              ? 'Seller Selected'
                                              : 'Select Seller',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.00.sp,
                                            color:
                                                selected != i
                                                    ? AppColor.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),

            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CommonButton(
          text: 'Continue',
          width: double.infinity,
          height: screenHeight * 0.06,
          borderRadius: 0.0,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddMeasurement(price: price,id: widget.data!.id,)),
            );
          },
        ),
      ),
    );
  }
}
