// buy_and_sell_wishlist_screen.dart

import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_whishlist_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_cart_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_view_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BuyAndSellWishlistScreen extends StatefulWidget {
  const BuyAndSellWishlistScreen({super.key});

  @override
  State<BuyAndSellWishlistScreen> createState() =>
      _BuyAndSellWishlistScreenState();
}

class _BuyAndSellWishlistScreenState extends State<BuyAndSellWishlistScreen> {
  final BuyAndSellController controller = Get.find<BuyAndSellController>();

  @override
  void initState() {
    super.initState();
    controller.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          title: 'My Wishlist',
          leadingclick: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.wishlistLoading.value) {
          return Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: AppColor.primary,
              size: 40,
            ),
          );
        }

        if (controller.wishlistProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.28,
                  height: screenWidth * 0.28,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border_rounded,
                    size: screenWidth * 0.13,
                    color: AppColor.primary.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                Text(
                  'Your wishlist is empty',
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Save items you love by tapping the\nheart icon on any product',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: AppColor.subTitleColor,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.015,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Browse Products',
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppColor.primary,
          onRefresh: () async => controller.getWishlist(),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.58,
            ),
            itemCount: controller.wishlistProducts.length,
            itemBuilder: (context, index) {
              final item = controller.wishlistProducts[index];
              return _buildWishlistCard(item, screenHeight, screenWidth);
            },
          ),
        );
      }),
    );
  }

  Widget _buildWishlistCard(
    WishlistDatum item,
    double screenHeight,
    double screenWidth,
  ) {
    final List<String> images=[];
    images.add(item.images?.main ?? '');
    images.add(item.images?.front ?? '');
    images.add(item.images?.back ?? '');
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Get.to(
          () => BuyAndSellViewDetails(
            inCart: item.inCart ?? false,
            title: item.category ?? '',
            imageUrls: [
              item.images?.main ?? '',
              item.images?.front ?? '',
              item.images?.back ?? '',
            ],
            price: item.price ?? '',
            subtitle: item.subProductName ?? '',
            size: item.size ?? '',
            address:
                '${item.location?.country ?? ''}, ${item.location?.state ?? ''}, '
                '${item.location?.city ?? ''}, ${item.location?.area ?? ''}, '
                '${item.location?.pincode ?? ''}',
            descriptionTitle: 'Description',
            description: item.description ?? '',
            id: item.id,
          ),
          transition: Transition.zoom,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Product Image ───────────────────────────────────
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: screenHeight * 0.28,
                          viewportFraction: 1,
                        ),
                        items:
                       images.map((image) {
                      return CachedNetworkImage(
                        imageUrl: image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorWidget:
                            (_, __, ___) => CustomWidgets.shimmerPlaceholder(),
                        progressIndicatorBuilder:
                            (_, __, ___) => CustomWidgets.shimmerPlaceholder(),
                      );}).toList()
                    ),
                  ),

                  // Price tag
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: Text(
                        '₹${item.price ?? '0'}',
                        style: GoogleFonts.dmSans(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Remove from wishlist heart button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Obx(
                      () => InkWell(
                        onTap: () => controller.addToWishlist(item.id),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child:
                              controller.addToWishlistLoadingId.value == item.id
                                  ? Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColor.primary,
                                    ),
                                  )
                                  : Icon(
                                    controller.wishlistProductIds.contains(
                                          item.id,
                                        )
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 16,
                                    color: AppColor.red,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Product Info ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category ?? '',
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subProductName ?? '',
                    style: GoogleFonts.dmSans(
                      fontSize: 11.sp,
                      color: AppColor.subTitleColor,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.straighten_rounded,
                        size: 12,
                        color: AppColor.greyTitleColor,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'Size: ${item.size ?? '-'}',
                        style: GoogleFonts.dmSans(
                          fontSize: 10.sp,
                          color: AppColor.greyTitleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12,
                        color: AppColor.primary,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${item.location?.city ?? ''}, ${item.location?.state ?? ''}',
                          style: GoogleFonts.dmSans(
                            fontSize: 10.sp,
                            color: AppColor.greyTitleColor,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Obx(
                    () => InkWell(
                      onTap:
                          controller.addToCartLoading.value
                              ? null
                              : () =>
                                  item.inCart == true
                                      ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const BuyAndSellCart(),
                                        ),
                                      )
                                      : controller.addToCart(item.id),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              item.inCart == true
                                  ? Colors.grey.shade200
                                  : AppColor.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child:
                            controller.addToCartLoading.value
                                ? SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color:
                                        item.inCart == true
                                            ? AppColor.primary
                                            : Colors.white,
                                  ),
                                )
                                : Text(
                                  item.inCart == true
                                      ? 'In Cart'
                                      : 'Add to Cart',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        item.inCart == true
                                            ? AppColor.primary
                                            : Colors.white,
                                  ),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
