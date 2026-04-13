import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/saved_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class BuyAndSellCart extends StatefulWidget {
  const BuyAndSellCart({super.key});

  @override
  State<BuyAndSellCart> createState() => _BuyAndSellCartState();
}

class _BuyAndSellCartState extends State<BuyAndSellCart> {
  final BuyAndSellController controller = Get.find<BuyAndSellController>();

  @override
  void initState() {
    super.initState();
    controller.getBuyAndSellCartList();
  }

  double get subtotal {
    return controller.buyAndSellCartList.fold(0.0, (sum, item) {
      final price = double.tryParse(item.product?.price?.toString() ?? '0') ?? 0;
      return sum + price;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          title: 'Cart',
          leadingclick: () {
          Get.back();
          },
        ),
      ),
      body: Obx(
            () => controller.buyAndSellCartList.isEmpty
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
            : ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.04,
              ),
              itemCount: controller.buyAndSellCartList.length,
              itemBuilder: (context, index) {
                final cartItem = controller.buyAndSellCartList[index];
                final product = cartItem.product;

                if (product == null) return const SizedBox();

                final double itemPrice =
                    double.tryParse(product.price?.toString() ?? '0') ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.lightGreyColor,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: screenHeight * 0.12,
                                  width: screenHeight * 0.12,
                                  errorWidget: (context, url, error) =>
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: screenHeight * 0.12,
                                          width: screenHeight * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: screenHeight * 0.12,
                                          width: screenHeight * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                  imageUrl: product.productImage ?? '',
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: 2,
                                  ),
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
                            ],
                          ),
                        ),
                        // Product Details
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth * 0.04,
                              top: screenHeight * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.category ?? '',
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.00.sp,
                                    color: AppColor.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  product.description ?? '',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10.00.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.subTitleColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Remove Button
                                    Obx(
                                          () => InkWell(
                                        onTap: controller
                                            .removeFromCartLoading
                                            .value
                                            ? null
                                            : () async {
                                          if (cartItem.id != null) {
                                            await controller
                                                .removeFromCart(
                                                cartItem.id!);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            color: Colors.red
                                                .withOpacity(0.08),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.03,
                                            vertical:
                                            screenHeight * 0.008,
                                          ),
                                          child: controller
                                              .removeFromCartLoading
                                              .value
                                              ? const SizedBox(
                                            width: 14,
                                            height: 14,
                                            child:
                                            CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.red,
                                            ),
                                          )
                                              : Row(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.delete_outline,
                                                color: Colors.red,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                  width:
                                                  screenWidth *
                                                      0.01),
                                              Text(
                                                'Remove',
                                                style: GoogleFonts
                                                    .dmSans(
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  fontSize: 12.00.sp,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Item Price
                                    Text(
                                      '₹${itemPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.00.sp,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.01),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Order Summary
            Obx(() {
              final double total = controller.buyAndSellCartList
                  .fold(0.0, (sum, item) {
                final price = double.tryParse(
                    item.product?.price?.toString() ?? '0') ??
                    0;
                return sum + price;
              });

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey.withOpacity(0.3)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Summary',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.00.sp,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            '${controller.buyAndSellCartList.length} items',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.subTitleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.00.sp,
                              color: AppColor.subTitleColor,
                            ),
                          ),
                          Text(
                            '₹${total.toStringAsFixed(2)}',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.00.sp,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Divider(
                        color: Colors.grey.withOpacity(0.3),
                        thickness: 1,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.00.sp,
                              color: AppColor.black,
                            ),
                          ),
                          Text(
                            '₹${total.toStringAsFixed(2)}',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.00.sp,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Obx(
              () => controller.buyAndSellCartList.isEmpty
              ? const SizedBox()
              : CommonButton(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                   const SavedAddress(comesFromBuyAndSell: true),
                ),
              );
            },
            text: 'PROCEED TO CHECKOUT',
            width: screenWidth,
            height: screenHeight * 0.06,
          ),
        ),
      ),
    );
  }
}