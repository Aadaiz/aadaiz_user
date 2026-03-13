import 'package:aadaiz_customer_crm/src/res/components/ads_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/add_buy_and_sell_screen.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/screens/your_ads_view_details.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/filter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class BuyAndSell extends StatefulWidget {
  const BuyAndSell({super.key});

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell> {
  BuyAndSellController controller = Get.find<BuyAndSellController>();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  List<Map<String, dynamic>> buyAndSellList = [
    {
      'CategoryName': 'Maxi',
      'SubCategoryName': 'Vado Odelle Dress',
      'Price': '258',
      'Category_image':
          'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRiPQeTiO0Fox-QoGlHToJ5ZUe_DXQBBHQWXorpnKxsKUpPThPJxAj47CQbHGLdAJFsz8NUTVub0QIKFdbMUtvnsYnCJZ2VjkXBJv_dT-zHTdFI5UHyNDds2A',
      'Address': 'Anna Nagar, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
    {
      'CategoryName': 'T-Shirt',
      'SubCategoryName': 'Casual Cotton Tee',
      'Price': '199',
      'Category_image':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab,https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
      'Address': 'Velachery, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
    {
      'CategoryName': 'Saree',
      'SubCategoryName': 'Silk Party Wear Saree',
      'Price': '1250',
      'Category_image':
          'https://images.unsplash.com/photo-1610030469983-98e550d6193c',
      'Address': 'T. Nagar, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
    {
      'CategoryName': 'Jeans',
      'SubCategoryName': 'Slim Fit Blue Jeans',
      'Price': '799',
      'Category_image':
          'https://images.unsplash.com/photo-1542272604-787c3835535d',
      'Address': 'Adyar, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
    {
      'CategoryName': 'Kurti',
      'SubCategoryName': 'Printed Daily Wear Kurti',
      'Price': '349',
      'Category_image':
          'https://images.unsplash.com/photo-1593032465175-481ac7f401a0',
      'Address': 'Porur, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
    {
      'CategoryName': 'Shoes',
      'SubCategoryName': 'Running Sports Shoes',
      'Price': '999',
      'Category_image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      'Address': 'Tambaram, Chennai',
      'DescriptionTitle': 'This is a description title',
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.featureSelected.value = true;
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
                            () => const Filter(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.045),
                  Obx(
                    () => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.featureSelected.value = true;
                          },
                          child: Text(
                            "Featured Products",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.07),
                        InkWell(
                          onTap: () {
                            controller.featureSelected.value = false;
                          },
                          child: Text(
                            "Your Ads",
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color:
                                  controller.featureSelected.value == false
                                      ? AppColor.black
                                      : AppColor.textFieldLabelColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.featureSelected.value == true)
                    Expanded(
                      child: SmartRefresher(
                        physics: const BouncingScrollPhysics(),
                        controller: refreshController,
                        enablePullUp: true,
                        onRefresh: () async {
                          // final result = await MaterialController.to
                          //     .getMaterials(isRefresh: true);
                          // if (result) {
                          //   refreshController.refreshCompleted();
                          // } else {
                          //   refreshController.refreshFailed();
                          // }
                        },
                        onLoading: () async {
                          // final result = await MaterialController.to
                          //     .getMaterials();
                          // if (MaterialController.to.currentPage.value >=
                          //     MaterialController.to.totalPages.value) {
                          //   refreshController.loadNoData();
                          // } else {
                          //   if (result) {
                          //     refreshController.loadComplete();
                          //   } else {
                          //     refreshController.loadFailed();
                          //   }
                          // }
                        },
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                            horizontal: screenWidth * 0.03,
                          ),
                          itemCount: buyAndSellList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.60,
                              ),
                          itemBuilder: (context, index) {
                            var data = buyAndSellList[index];

                            return InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  data['Category_image']
                                                      .split(',')
                                                      .first,
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
                                            child: InkWell(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 16,
                                                  color: AppColor.red,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            bottom: 0,
                                            left: -2,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColor.black,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppColor.white,
                                                  width: 3.5,
                                                ),
                                              ),
                                              child: Text(
                                                '₹${data['Price']}',
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        data['CategoryName'],
                                        style: GoogleFonts.dmSans(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        data['SubCategoryName'],
                                        style: GoogleFonts.dmSans(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.subTitleColor,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: AppColor.primary,
                                        ),

                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            data['Address'],
                                            style: GoogleFonts.dmSans(
                                              fontSize: 10.sp,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: AppColor.greyTitleColor,
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
                        ),
                      ),
                    ),
                  SizedBox(height: screenHeight * 0.035),
                  if (controller.featureSelected.value == false)
                    Expanded(
                      child: ListView.builder(
                        itemCount: buyAndSellList.length,
                        itemBuilder: (context, index) {
                          var data = buyAndSellList[index];
                          List<String> convertImages(String images) {
                            return images.split(',').map((e) => e.trim()).toList();
                          }

                          return YourAdsItemCard(
                            onTap: () {
                              Get.to(
                                () => YourAdsViewDetails(
                                  title: data['CategoryName'],
                                  imageUrls: convertImages(data['Category_image']),

                                  price: data['Price'],
                                  subtitle: data['SubCategoryName'],
                                  size: 'M',
                                  address: data['Address'],
                                  descriptionTitle: 'Description',
                                  description: data['DescriptionTitle'],
                                ),transition: Transition.zoom,
                              );
                            },
                            image: data['Category_image'],
                            title: data['CategoryName'],
                            subtitle: data['SubCategoryName'],
                            size: "M",
                            price: data['Price'],
                            status: "Pending",
                            onEdit: () {},
                            onDelete: () {},
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            if (controller.featureSelected.value)
              Positioned(
                bottom: 25,
                left: 50,
                right: 50,
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => const AddBuyAndSellScreen(),
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
