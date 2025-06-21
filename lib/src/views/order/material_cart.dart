import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/saved_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MaterialCart extends StatefulWidget {
  const MaterialCart({super.key});

  @override
  State<MaterialCart> createState() => _MaterialCartState();
}

class _MaterialCartState extends State<MaterialCart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      await MaterialController.to.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
          child: Image.asset('assets/images/back.png'),
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 14.00.sp,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColor.black,
        forceMaterialTransparency: false,
      ),
      body: Obx(
        () =>
            MaterialController.to.cartListLoading.value
                ? CommonLoading()
                : MaterialController.to.cartList.value!.items!.isEmpty
                ? Container(
                  alignment: Alignment.center,
                  height: screenHeight * 0.33,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/empty-shopping-bag.png',
                        height: screenHeight * 0.08,
                      ),
                      SizedBox(height: screenHeight * 0.022),
                      Text(
                        'No item in your cart',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.00.sp,
                          color: AppColor.cartTextColor,
                        ),
                      ),
                    ],
                  ),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.03,
                        horizontal: screenWidth * 0.04,
                      ),
                      itemCount:
                          MaterialController.to.cartList.value!.items!.length,
                      itemBuilder: (context, index) {
                        var data =
                            MaterialController
                                .to
                                .cartList
                                .value!
                                .items![index];
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
                          padding: const EdgeInsets.only(bottom: 8),

                          child: Container(
                            //  height: screenHeight * 0.14,
                              decoration: BoxDecoration(
                                  color: AppColor.lightGreyColor,
                                  borderRadius:
                                  BorderRadius.circular(18)),
                              child: Row(children: [
                                Container(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Stack(children: [
                                      data.image != null
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fill,
                                          height: screenHeight *
                                              0.1,
                                          width: screenHeight *
                                              0.1,
                                          errorWidget: (context,
                                              url, error) =>
                                              Shimmer
                                                  .fromColors(
                                                baseColor: Colors
                                                    .grey[300]!,
                                                highlightColor:
                                                Colors
                                                    .grey[100]!,
                                                child: Container(
                                                  height:
                                                  screenHeight *
                                                      0.1,
                                                  width:
                                                  screenHeight *
                                                      0.1,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors
                                                        .white,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                  ),
                                                ),
                                              ),
                                          progressIndicatorBuilder:
                                              (context, url,
                                              progress) =>
                                              Shimmer
                                                  .fromColors(
                                                baseColor: Colors
                                                    .grey[300]!,
                                                highlightColor:
                                                Colors
                                                    .grey[100]!,
                                                child: Container(
                                                  height:
                                                  screenHeight *
                                                      0.1,
                                                  width:
                                                  screenHeight *
                                                      0.1,
                                                  decoration:
                                                  BoxDecoration(
                                                    color: Colors
                                                        .white,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        10.0),
                                                  ),
                                                ),
                                              ),
                                          imageUrl: (images[0]),
                                        ),
                                      )
                                          : Shimmer.fromColors(
                                        baseColor:
                                        Colors.grey[300]!,
                                        highlightColor:
                                        Colors.grey[100]!,
                                        child: Container(
                                          height:
                                          screenHeight *
                                              0.13,
                                          width:
                                          screenHeight *
                                              0.1,
                                          decoration:
                                          BoxDecoration(
                                            color:
                                            Colors.white,
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10.0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColor
                                                      .blackBtnColor,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                  border: Border.all(
                                                      color: Colors
                                                          .white,
                                                      width: 2)),
                                              width: screenWidth *
                                                  0.122,
                                              height: screenHeight *
                                                  0.033,
                                              alignment:
                                              Alignment.center,
                                              child: Text(
                                                  '₹${data.price}',
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                      fontSize:
                                                      10.00.sp,
                                                      color: AppColor.white))))
                                    ])),
                                Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: screenWidth / 1.6,
                                          child: ListTile(
                                              title: Text(data.title ?? '',
                                                  style: GoogleFonts.dmSans(
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      fontSize:
                                                      16.00.sp,
                                                      color: AppColor
                                                          .black)),
                                              subtitle: Text(
                                                  data.description ??
                                                      '',
                                                  style: GoogleFonts.dmSans(
                                                      fontSize:
                                                      10.00.sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      color: AppColor
                                                          .subTitleColor)),
                                          )),
                                      SizedBox(
                                          width: screenWidth / 2.5,
                                          child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                RatingBar(
                                                    initialRating:
                                                    rating,
                                                    direction: Axis
                                                        .horizontal,
                                                    allowHalfRating:
                                                    true,
                                                    itemCount: 5,
                                                    itemSize: 12,
                                                    unratedColor:
                                                    Colors.grey,
                                                    ratingWidget: RatingWidget(
                                                        full: const Icon(
                                                            Icons
                                                                .star_rounded,
                                                            color: Color(
                                                                0xffFFA800)),
                                                        half: const Icon(
                                                            Icons
                                                                .star_half_rounded,
                                                            color: Color(
                                                                0xffFFA800)),
                                                        empty: const Icon(
                                                            Icons
                                                                .star_outline_rounded,
                                                            color: Color(
                                                                0xffFFA800))),
                                                    onRatingUpdate:
                                                        (value) {}),
                                                SizedBox(
                                                    width:
                                                    screenWidth *
                                                        0.01),
                                                Text('View Review',
                                                    style: GoogleFonts.dmSans(
                                                        fontSize:
                                                        9.00.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        color: AppColor
                                                            .black,
                                                        decoration:
                                                        TextDecoration
                                                            .underline))
                                              ]))
                                    ])
                              ]))
                          // SwipeActionCell(
                          //     key: UniqueKey(),
                          //     trailingActions: [
                          //       SwipeAction(
                          //           onTap: (handler) {},
                          //           color: AppColor.primary,
                          //           icon: Image.asset(
                          //               'assets/images/trash_white.png',
                          //               height: screenHeight * 0.03))
                          //     ],
                          //     child:
                          // )
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.00.sp,
                            ),
                          ),
                          Text(
                            '₹${MaterialController.to.cartList.value!.total ?? ''}',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.00.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                  ],
                ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: screenWidth / 1.2,
          height: 50,
          child: CommonButton(
            borderRadius: 0.0,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  const SavedAddress(),
                ),
              );
            },
            text: 'CHECKOUT',
            loading: false,
            width: screenWidth / 1.2,
            height: screenHeight * 0.7,
          ),
        ),
      ),
    );
  }
}
