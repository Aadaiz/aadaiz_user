import 'package:aadaiz_customer_crm/src/res/components/comming_soon.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/saved_address.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MaterialCart extends StatefulWidget {
  const MaterialCart({super.key});

  @override
  State<MaterialCart> createState() => _MaterialCartState();
}

class _MaterialCartState extends State<MaterialCart> {


  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return ComingSoonOverlay(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: PreferredSize(
          preferredSize: Size(100, 6.0.hp),
          child:  CommonAppBar(title: 'Cart',leadingclick:(){
            DashboardController.to.tabSelected.value=0;}
          ),
        ),
        body: Obx(
              () => MaterialController.to.cartList.value == null ||
              MaterialController.to.cartList.value!.items == null ||
              MaterialController.to.cartList.value!.items!.isEmpty
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
                itemCount:
                MaterialController.to.cartList.value!.items!.length,
                // In the itemBuilder of ListView.builder in MaterialCart screen:
      
                itemBuilder: (context, index) {
                  // Get cart item
                  var cartItem = MaterialController.to.cartList.value!.items![index];
                  var product = cartItem.product;
      
                  if (product == null) {
                    return const SizedBox();
                  }
      
                  List images = product.image?.split(',') ?? [];
                  double rating;
                  if (product.rating is int) {
                    rating = product.rating.toDouble();
                  } else if (product.rating is double) {
                    rating = product.rating;
                  } else {
                    rating = 1.0;
                  }
      
                  // Get current quantity from cart item
                  int currentQuantity = cartItem.quantity ?? 1;
                  var productId = product.id;
      
                  // Calculate item total price
                  double itemPrice = double.tryParse(product.price?.toString() ?? '0') ?? 0;
                  double itemTotal = itemPrice * currentQuantity;
      
                  return Obx(() {
                    // Use Obx to wrap the entire cart item for reactive updates
                    int displayQuantity = productId != null
                        ? MaterialController.to.getItemQuantity(productId)
                        : currentQuantity;
      
                    double displayTotal = itemPrice * displayQuantity;
      
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
                            // Product Image (same as before)
                            Container(
                              padding: const EdgeInsets.all(12.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: screenHeight * 0.12,
                                      width: screenHeight * 0.12,
                                      errorWidget: (context, url, error) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: screenHeight * 0.12,
                                          width: screenHeight * 0.12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder: (context, url, progress) =>
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              height: screenHeight * 0.12,
                                              width: screenHeight * 0.12,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                      imageUrl: images.isNotEmpty ? images[0] : '',
                                    ),
                                  ),
                                  // Price Tag
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.blackBtnColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title and Description
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
                                    // Rating
                                    Row(
                                      children: [
                                        RatingBar(
                                          initialRating: rating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 12,
                                          ignoreGestures: true,
                                          unratedColor: Colors.grey[300],
                                          ratingWidget: RatingWidget(
                                            full: const Icon(
                                              Icons.star_rounded,
                                              color: Color(0xffFFA800),
                                              size: 12,
                                            ),
                                            half: const Icon(
                                              Icons.star_half_rounded,
                                              color: Color(0xffFFA800),
                                              size: 12,
                                            ),
                                            empty: const Icon(
                                              Icons.star_outline_rounded,
                                              color: Color(0xffFFA800),
                                              size: 12,
                                            ),
                                          ),
                                          onRatingUpdate: (value) {},
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Text(
                                          'View Review',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 9.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.black,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.015),
                                    // Quantity Controls and Price
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Quantity Controls
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.primary,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Minus Button
                                              InkWell(
                                                onTap: () async {
                                                  if (productId != null) {
                                                    await MaterialController.to
                                                        .decrementQuantity(productId);
                                                  }
                                                },
                                                child: Container(
                                                  width: screenWidth * 0.08,
                                                  height: screenHeight * 0.035,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.primary,
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(7),
                                                      bottomLeft: Radius.circular(7),
                                                    ),
                                                  ),
                                                  child: MaterialController.to.addLoading.value
                                                      ? const Center(
                                                    child: SizedBox(
                                                      width: 12,
                                                      height: 12,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                      : const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              // Quantity Display
                                              Container(
                                                width: screenWidth * 0.09,
                                                height: screenHeight * 0.035,
                                                color: Colors.white,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '$displayQuantity',
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.00.sp,
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              ),
                                              // Plus Button
                                              InkWell(
                                                onTap: () async {
                                                  if (productId != null) {
                                                    await MaterialController.to
                                                        .incrementQuantity(productId);
                                                  }
                                                },
                                                child: Container(
                                                  width: screenWidth * 0.08,
                                                  height: screenHeight * 0.035,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.primary,
                                                    borderRadius: const BorderRadius.only(
                                                      topRight: Radius.circular(7),
                                                      bottomRight: Radius.circular(7),
                                                    ),
                                                  ),
                                                  child: MaterialController.to.addLoading.value
                                                      ? const Center(
                                                    child: SizedBox(
                                                      width: 12,
                                                      height: 12,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                      : const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Item Total Price
                                        Text(
                                          '₹${displayTotal.toStringAsFixed(2)}',
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
                  });
                },
              ),
              // Order Summary
              Obx(() {
                var cartSummary =
                MaterialController.to.getCartSummary();
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
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
                        // Order Summary Title
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
                              '${MaterialController.to.getTotalItemsCount()} items',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Subtotal
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
                              '₹${cartSummary['subtotal']}',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.00.sp,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Discounts
                        if ((cartSummary['discounts'] as double) > 0)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Discounts',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.00.sp,
                                      color: AppColor.subTitleColor,
                                    ),
                                  ),
                                  Text(
                                    '-₹${cartSummary['discounts']}',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.00.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                            ],
                          ),
                        // Delivery Charges
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery Charges',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.00.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                            Text(
                              '₹${cartSummary['deliveryCharges']}',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.00.sp,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Tax & Charges
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tax & Charges',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.00.sp,
                                color: AppColor.subTitleColor,
                              ),
                            ),
                            Text(
                              '₹${cartSummary['taxAndCharges']}',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.00.sp,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Divider
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                          thickness: 1,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Total
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
                              '₹${cartSummary['total']}',
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
                () => MaterialController.to.cartList.value == null ||
                MaterialController.to.cartList.value!.items == null ||
                MaterialController.to.cartList.value!.items!.isEmpty
                ? const SizedBox()
                : CommonButton(
              borderRadius: 8.0,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SavedAddress(),
                  ),
                );
              },
              text: 'PROCEED TO CHECKOUT',
              loading: false,
              width: screenWidth,
              height: screenHeight * 0.06,
            ),
          ),
        ),
      ),
    );
  }
}