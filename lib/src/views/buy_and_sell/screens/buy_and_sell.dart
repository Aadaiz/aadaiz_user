import 'dart:developer';

import 'package:aadaiz_customer_crm/src/res/components/ads_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/model/buy_and_sell_list_model.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/add_buy_and_sell_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_cart_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_filter_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_view_details.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/buy_and_sell_whishList_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/your_ads_view_details.dart';
import 'package:aadaiz_customer_crm/src/views/material/filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuyAndSell extends StatefulWidget {
  const BuyAndSell({super.key});

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell> {
  BuyAndSellController controller = Get.find<BuyAndSellController>();
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    controller.featureSelected.value = 0;
    controller.getBuyAndSellList(page: 1, isRefresh: true);
    controller.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () {
            Get.back();
          },
          title: 'Buy And Sell',
          isCheck: true,
          actionButton: Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(() => const BuyAndSellWishlistScreen(),
                      transition: Transition.rightToLeft);
                },
                icon: Obx(
                      () => Badge(
                    isLabelVisible: controller.wishlistProducts.isNotEmpty,
                    label: Text('${controller.wishlistProducts.length}'),
                    child: const Icon(Icons.favorite_border_rounded),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const BuyAndSellCart()));
                },
                icon: Image.asset('assets/images/bag.png',
                    height: screenHeight * 0.02),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  SearchField(
                    controller: controller.searchController,
                    hintText: "Search Events",
                    showSuffix: true,
                    suffixWidget: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {
                          Get.to(
                            () => const BuyAndSellFilter(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _tabItem(
                            label: "Featured",
                            index: 0,
                            screenWidth: screenWidth,
                          ),
                          SizedBox(width: screenWidth * 0.06),
                          _tabItem(
                            label: "Your Ads",
                            index: 1,
                            screenWidth: screenWidth,
                          ),
                          SizedBox(width: screenWidth * 0.06),
                          _tabItem(
                            label: "Orders",
                            index: 2,
                            screenWidth: screenWidth,
                          ),
                          SizedBox(width: screenWidth * 0.06),
                          _tabItem(
                            label: "Purchased",
                            index: 3,
                            screenWidth: screenWidth,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  if (controller.buyAndSellListLoading.value &&
                      controller.featuredProducts.isEmpty)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    Expanded(
                      child: SmartRefresher(
                        physics: const BouncingScrollPhysics(),
                        controller: controller.refreshController,
                        enablePullUp: true,
                        onRefresh: () async {
                          await controller.onRefresh();
                        },
                        onLoading: () async {
                          await controller.onLoadMore();
                        },
                        child: _buildTabContent(screenHeight, screenWidth),
                      ),
                    ),
                ],
              ),
            ),
            if (controller.featureSelected.value == 0 ||
                controller.featureSelected.value == 1)
              Positioned(
                bottom: 25,
                left: 50,
                right: 50,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => const AddBuyAndSellScreen(isEdit: false),
                      transition: Transition.downToUp,
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withAlpha(90),
                          blurRadius: 12,
                        ),
                      ],
                      color: AppColor.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 20, color: AppColor.white),
                        Text(
                          'Sell',
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tabItem({
    required String label,
    required int index,
    required double screenWidth,
  }) {
    final bool isSelected = controller.featureSelected.value == index;
    return InkWell(
      onTap: () {
        controller.featureSelected.value = index;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: isSelected ? AppColor.black : AppColor.textFieldLabelColor,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 2,
              width: 30,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabContent(double screenHeight, double screenWidth) {
    switch (controller.featureSelected.value) {
      case 0:
        return _buildFeaturedGrid(screenHeight, screenWidth);
      case 1:
        return _buildYourAdsList(screenHeight, screenWidth);
      case 2:
        return _buildOrderProductsList(screenHeight, screenWidth);
      case 3:
        return _buildPurchasedProductsList(screenHeight, screenWidth);
      default:
        return const SizedBox();
    }
  }

  Widget _buildFeaturedGrid(double screenHeight, double screenWidth) {
    if (controller.featuredProducts.isEmpty) {
      return Center(
        child: Text(
          'No featured products',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: AppColor.subTitleColor,
          ),
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03,
        horizontal: screenWidth * 0.03,
      ),
      itemCount: controller.featuredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        final data = controller.featuredProducts[index];
        return InkWell(
          onTap: () {
            Get.to(
              () => BuyAndSellViewDetails(
                inCart:data.inCart??false,
                title: data.category ?? '',
                imageUrls: [
                  data.images?.main ?? '',
                  data.images?.front ?? '',
                  data.images?.back ?? '',
                ],
                price: data.price ?? '',
                subtitle: data.subProductName ?? '',
                size: data.size ?? '',
                address:
                    '${data.location?.country ?? ''}, ${data.location?.state ?? ''}, ${data.location?.city ?? ''}, ${data.location?.area ?? ''}, ${data.location?.pincode ?? ''}',

                descriptionTitle: 'Description',
                description: data.description ?? '',
                id: data.id,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: data.images?.main ?? '',
                          errorWidget:
                              (_, __, ___) =>
                                  CustomWidgets.shimmerPlaceholder(),
                          progressIndicatorBuilder:
                              (_, __, ___) =>
                                  CustomWidgets.shimmerPlaceholder(),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Obx(
                              () => InkWell(
                            onTap: () => controller.addToWishlist(data.id),
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
                              child: controller.addToWishlistLoadingId.value == data.id
                                  ? Padding(
                                padding: const EdgeInsets.all(7),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColor.primary,
                                ),
                              )
                                  : Icon(
                                controller.wishlistProductIds.contains(data.id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 16,
                                color: AppColor.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: -2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColor.white,
                              width: 3.5,
                            ),
                          ),
                          child: Text(
                            '₹${data.price ?? '0'}',
                            style: GoogleFonts.dmSans(
                              fontSize: 10.sp,
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data.category ?? '',
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data.subProductName ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.dmSans(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.subTitleColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColor.primary),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          '${data.location?.city ?? ''}, ${data.location?.state ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 10.sp,
                            decoration: TextDecoration.underline,
                            color: AppColor.greyTitleColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildYourAdsList(double screenHeight, double screenWidth) {
    if (controller.yourAdsProducts.isEmpty) {
      return Center(
        child: Text(
          'No ads posted yet',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: AppColor.subTitleColor,
          ),
        ),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.yourAdsProducts.length,
      itemBuilder: (context, index) {
        final data = controller.yourAdsProducts[index];
        final List<String> images = [];
        if (data.images?.main != null) {
          images.add(data.images!.main!);
        }
        if (data.images?.front != null) {
          images.add(data.images!.front!);
        }
        if (data.images?.back != null) {
          images.add(data.images!.back!);
        }
        return Obx(
          () => YourAdsItemCard(
            onTap: () {
              Get.to(
                () => YourAdsViewDetails(
                  title: data.category ?? '',
                  imageUrls: images,
                  price: data.price ?? '',
                  subtitle: data.subProductName ?? '',
                  size: data.size ?? '',
                  address:
                      '${data.location?.city ?? ''}, ${data.location?.state ?? ''}',
                  descriptionTitle: 'Description',
                  description: data.description ?? '',
                ),
                transition: Transition.zoom,
              );
            },
            imageUrls: images,
            title: data.category ?? '',
            subtitle: data.subProductName ?? '',
            size: data.size ?? '',
            price: data.price ?? '',
            status: "Pending",
            onEdit: () {
              Get.to(
                () => AddBuyAndSellScreen(isEdit: true, data: data),
                transition: Transition.zoom,
              );
            },
            onDelete: () {
              controller.deleteBuyAndSell(data.id!);
            },
            onDeleteLoading: controller.deletingBuyAndSellId.value == data.id,
          ),
        );
      },
    );
  }

  Widget _buildOrderProductsList(double screenHeight, double screenWidth) {
    if (controller.orderProducts.isEmpty) {
      return Center(
        child: Text(
          'No orders found',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: AppColor.subTitleColor,
          ),
        ),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      itemCount: controller.orderProducts.length,
      itemBuilder: (context, index) {
        final data = controller.orderProducts[index];

        return _buildOrderCard(data, screenWidth, screenHeight);
      },
    );
  }

  Widget _buildPurchasedProductsList(double screenHeight, double screenWidth) {
    if (controller.purchasedProducts.isEmpty) {
      return Center(
        child: Text(
          'No purchased products',
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            color: AppColor.subTitleColor,
          ),
        ),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      itemCount: controller.purchasedProducts.length,
      itemBuilder: (context, index) {
        final data = controller.purchasedProducts[index];
        return _buildPurchasedCard(data, screenWidth, screenHeight);
      },
    );
  }

  Widget _buildOrderCard(
    OrderProductsDatum data,
    double screenWidth,
    double screenHeight,
  ) {
    Color statusColor = AppColor.primary;

    final String status = data.status?.toLowerCase() ?? '';

    if (status == 'delivered') {
      statusColor = Colors.green;
    } else if (status == 'pending' || status == 'placed') {
      statusColor = Colors.orange;
    } else if (status == 'shipping' || status == 'track') {
      statusColor = Colors.blue;
    } else if (status == 'pickup') {
      statusColor = Colors.purple;
    } else {
      statusColor = AppColor.greyTitleColor;
    }

    final List<String> imageUrls = [];
    if (data.images?.main != null) {
      imageUrls.add(data.images!.main!);
    }
    if (data.images?.front != null) {
      imageUrls.add(data.images!.front!);
    }
    if (data.images?.back != null) {
      imageUrls.add(data.images!.back!);
    }

    log(imageUrls.toString());

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrls.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: screenHeight * 0.12,
                    width: screenWidth * 0.25,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.12,
                        viewportFraction: 1,
                        autoPlay: imageUrls.length > 1,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items:
                          imageUrls.map((imageUrl) {
                            return CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              progressIndicatorBuilder:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                              errorWidget:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              if (imageUrls.isNotEmpty) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.productName ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data.status?.capitalizeFirst ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 10.sp,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '₹${data.price ?? '0'}',
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.grey.shade100),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColor.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.buyer?.name ?? 'Unknown Buyer',
                      style: GoogleFonts.dmSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      data.buyer?.email ?? '',
                      style: GoogleFonts.dmSans(
                        fontSize: 10.sp,
                        color: AppColor.subTitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '#${data.orderId}',
                style: GoogleFonts.dmSans(
                  fontSize: 10.sp,
                  color: AppColor.greyTitleColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.grey.shade100),
          const SizedBox(height: 12),
          Row(
            children: [
              if (data.isCancelled == true)
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        controller.cancelOrder(data.orderId, 'cancelled');
                      },
                      child:
                          controller.buyAndSellCancelLoadingId.value ==
                                  data.orderId
                              ? SizedBox(
                                height: 03.00.hp,
                                width: 5.00.hp,
                                child:
                                    LoadingAnimationWidget.horizontalRotatingDots(
                                      color: AppColor.red,
                                      size: 5.00.hp,
                                    ),
                              )
                              : Text(
                                'Cancel Order',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.sp,
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () async {
                      await controller.cancelOrder(
                        data.orderId,
                        data.status == 'placed'
                            ? 'shipping'
                            : data.status == 'shipping'
                            ? 'pickup'
                            : data.status == 'pickup'
                            ? 'track'
                            : '',
                      );
                    },
                    child:
                        (controller.buyAndSellCancelLoadingId.value == data.orderId)
                            ? SizedBox(
                              height: 03.00.hp,
                              width: 5.00.hp,
                              child:
                                  LoadingAnimationWidget.horizontalRotatingDots(
                                    color: AppColor.white,
                                    size: 5.00.hp,
                                  ),
                            )
                            : Text(
                              data.status?.capitalizeFirst ?? '',
                              style: GoogleFonts.dmSans(
                                fontSize: 11.sp,
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          if (data.isCancelled == true)
            Text(
              'Note : You can cancel the order withing 2 hours only',
              style: GoogleFonts.dmSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.greyTitleColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPurchasedCard(
    OrderProductsDatum data,
    double screenWidth,
    double screenHeight,
  ) {
    Color statusColor = AppColor.primary;
    final String status = data.status?.toLowerCase() ?? '';

    if (status == 'delivered') {
      statusColor = Colors.green;
    } else if (status == 'pending' || status == 'placed') {
      statusColor = Colors.orange;
    } else if (status == 'shipping' || status == 'track') {
      statusColor = Colors.blue;
    } else if (status == 'pickup') {
      statusColor = Colors.purple;
    } else {
      statusColor = AppColor.greyTitleColor;
    }

    final List<String> imageUrls = [];
    if (data.images?.main != null) {
      imageUrls.add(data.images!.main!);
    }
    if (data.images?.front != null) {
      imageUrls.add(data.images!.front!);
    }
    if (data.images?.back != null) {
      imageUrls.add(data.images!.back!);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrls.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: screenHeight * 0.12,
                    width: screenWidth * 0.25,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.12,
                        viewportFraction: 1,
                        autoPlay: imageUrls.length > 1,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items:
                          imageUrls.map((imageUrl) {
                            return CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              progressIndicatorBuilder:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                              errorWidget:
                                  (_, __, ___) =>
                                      CustomWidgets.shimmerPlaceholder(),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              if (imageUrls.isNotEmpty) const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.productName ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data.status?.capitalizeFirst ?? '',
                            style: GoogleFonts.dmSans(
                              fontSize: 10.sp,
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '₹${data.price ?? '0'}',
                            style: GoogleFonts.dmSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 16,
                          color: AppColor.greyTitleColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Order #${data.orderId}',
                          style: GoogleFonts.dmSans(
                            fontSize: 11.sp,
                            color: AppColor.greyTitleColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Container(height: 1, color: Colors.grey.shade100),
          const SizedBox(height: 12),
          Row(
            children: [
              if (data.isCancelled == true)
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        controller.cancelOrder(data.orderId, 'cancelled');
                      },
                      child:
                          controller.buyAndSellCancelLoadingId.value ==
                                  data.orderId
                              ? SizedBox(
                                height: 03.00.hp,
                                width: 5.00.hp,
                                child:
                                    LoadingAnimationWidget.horizontalRotatingDots(
                                      color: AppColor.red,
                                      size: 5.00.hp,
                                    ),
                              )
                              : Text(
                                'Cancel Order',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11.sp,
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () async {
                      await controller.cancelOrder(data.orderId, 'track');

                      Future.delayed(const Duration(seconds: 3), () {
                        controller.trackOrder(data.orderId, data.awbCode);
                      });
                    },
                    child:
                        (controller.trackOrderLoadingId.value == data.orderId)
                            ? SizedBox(
                              height: 03.00.hp,
                              width: 5.00.hp,
                              child:
                                  LoadingAnimationWidget.horizontalRotatingDots(
                                    color: AppColor.white,
                                    size: 5.00.hp,
                                  ),
                            )
                            : Text(
                              'Track Order',
                              style: GoogleFonts.dmSans(
                                fontSize: 11.sp,
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          if (data.isCancelled == true)
            Text(
              'Note : You can cancel the order withing 2 hours only',
              style: GoogleFonts.dmSans(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.greyTitleColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget sortWidget({image, title}) {
    return Row(
      children: [
        Image.asset(image, fit: BoxFit.fill, width: 5.0.wp),
        const Gap(8),
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              color: AppColor.textColor,
              fontSize: 9.0.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
