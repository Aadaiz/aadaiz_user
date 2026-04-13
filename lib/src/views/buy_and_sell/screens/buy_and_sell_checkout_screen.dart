import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/coupon.dart';
import 'package:aadaiz_customer_crm/src/views/order/payment_success.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/model/add_address_model.dart';

class BuyAndSellCheckout extends StatefulWidget {
  const BuyAndSellCheckout({super.key, this.data});
  final Address? data;

  @override
  State<BuyAndSellCheckout> createState() => _BuyAndSellCheckoutState();
}

class _BuyAndSellCheckoutState extends State<BuyAndSellCheckout> {
  final BuyAndSellController controller = Get.find<BuyAndSellController>();
  String address = '';

  @override
  void initState() {
    super.initState();
    getData();
    address =
        "${widget.data!.address}, ${widget.data!.city}, ${widget.data!.state}, ${widget.data!.country} - ${widget.data!.pincode.toString()}";
  }

  double get subtotal {
    return controller.buyAndSellCartList.fold(0.0, (sum, item) {
      final price =
          double.tryParse(item.product?.price?.toString() ?? '0') ?? 0;
      return sum + price;
    });
  }

  Future<void> getData() async {
    await controller.getBuyAndSellCartList();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 8.0.hp),
        child: CommonAppBar(
          title: 'Checkout',
          leadingclick: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                child: Text(
                  'Shipping Address',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.textColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.045,
                  vertical: screenHeight * 0.022,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.data!.name ?? ''}',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.00.sp,
                            color: AppColor.textColor,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Text(
                            'Change',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.orangeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      address,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.00.sp,
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Cart Items ────────────────────────────────────────────
              Container(
                width: screenWidth,
                color: Colors.white,
                child:
                    controller.buyAndSellCartList.isEmpty
                        ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 0.03),
                            child: Text(
                              'No items in cart',
                              style: GoogleFonts.dmSans(
                                fontSize: 14.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                            horizontal: screenWidth * 0.04,
                          ),
                          itemCount: controller.buyAndSellCartList.length,
                          itemBuilder: (context, index) {
                            final cartItem =
                                controller.buyAndSellCartList[index];
                            final product = cartItem.product;

                            if (product == null) return const SizedBox();

                            return Container(
                              height: screenHeight * 0.14,
                              margin: EdgeInsets.only(
                                bottom: screenHeight * 0.01,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  // Product Image
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            height: screenHeight * 0.13,
                                            width: screenHeight * 0.1,
                                            imageUrl:
                                                product.productImage ?? '',
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: screenHeight * 0.13,
                                                    width: screenHeight * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            progressIndicatorBuilder:
                                                (
                                                  context,
                                                  url,
                                                  progress,
                                                ) => Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: screenHeight * 0.13,
                                                    width: screenHeight * 0.1,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                        // Price Tag
                                        Positioned(
                                          left: 0,
                                          bottom: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.blackBtnColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),

                                            height: screenHeight * 0.033,
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.all(3),
                                              child: Text(
                                                '₹${product.price}',
                                                style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10.00.sp,
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth / 1.6,
                                          child: ListTile(
                                            title: Text(
                                              product.category ?? '',
                                              style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.00.sp,
                                                color: AppColor.black,
                                              ),
                                            ),
                                            subtitle: Text(
                                              product.description ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.dmSans(
                                                fontSize: 10.00.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.subTitleColor,
                                              ),
                                            ),
                                            trailing: Text(
                                              '₹${double.tryParse(product.price?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00'}',
                                              style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13.00.sp,
                                                color: AppColor.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),

              Container(
                height: screenHeight * 0.01,
                color: AppColor.addressBgColor,
              ),

              // ── Order Details ─────────────────────────────────────────
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.045,
                  vertical: screenHeight * 0.022,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.00.sp,
                        color: AppColor.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.033),
                    amountText(
                      title: 'Subtotal',
                      value: subtotal.toStringAsFixed(2),
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    amountText(
                      title: 'Delivery Charges',
                      value: 'Free',
                      screenHeight: screenHeight,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    amountText(
                      title: 'Total Items',
                      value: '${controller.buyAndSellCartList.length}',
                      screenHeight: screenHeight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ── Bottom Nav: Total + Place Order ──────────────────────────────
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03,
              vertical: 5,
            ),
            dense: true,
            tileColor: AppColor.primary,
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              'Total',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 12.00.sp,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              '₹${subtotal.toStringAsFixed(2)}',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 13.00.sp,
                color: Colors.white,
              ),
            ),
            trailing: InkWell(
              onTap:
                  controller.buyAndSellCartList.isEmpty
                      ? null
                      : () {
                        controller.buyAndSellCheckOut(
                          controller.buyAndSellCartList.map((id) {
                            return id.id;
                          }).toList(),
                          widget.data?.id,
                        );
                      },
              child: Container(
                height: screenHeight * 0.066,
                width: screenWidth * 0.35,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.033,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    controller.buyAndSellCheckOutLoading.value
                        ? SizedBox(
                          height: 03.00.hp,
                          width: 5.00.hp,
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                            color: AppColor.primary,
                            size: 5.00.hp,
                          ),
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/ic_pay.png',
                              width: screenWidth * 0.066,
                            ),
                            Text(
                              'Payment',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget amountText({
    required String title,
    required String value,
    required double screenHeight,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 12.00.sp,
            color: AppColor.orderTextColor,
          ),
        ),
        isDiscount
            ? Text(
              '-₹$value',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 11.00.sp,
                color: AppColor.minusColor,
              ),
            )
            : Text(
              value.startsWith('₹') || value == 'Free' ? value : '₹$value',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 11.00.sp,
                color: AppColor.black,
              ),
            ),
      ],
    );
  }
}
