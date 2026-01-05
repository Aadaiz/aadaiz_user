import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/coupon.dart';
import 'package:aadaiz_customer_crm/src/views/order/payment_success.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';
import '../home/controller/home_controller.dart';
import '../home/model/add_address_model.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, this.data});
  final Address? data;
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String address = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Replace HomeController.to.getCartList() with MaterialController.to.getCart()
      MaterialController.to.getCart();
      coupon.addListener(() {
        setState(() {});
      });
    });

    bool isCouponApplied = false;

    address =
        "${widget.data!.address}," +
        " ${widget.data!.city}," +
        " ${widget.data!.state}," +
        ' ${widget.data!.country},' +
        " - ${widget.data!.pincode.toString()}";
  }

  TextEditingController coupon = TextEditingController();

  bool isCouponApplied = false;

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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.045,
                  vertical: 0,
                ),
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
                        Text(
                          'Change',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.00.sp,
                            color: AppColor.orangeColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '${address}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.00.sp,
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                    horizontal: screenWidth * 0.04,
                  ),
                  itemCount:
                      MaterialController.to.cartList.value?.items?.length ?? 0,
                  itemBuilder: (context, index) {
                    var data =
                        MaterialController.to.cartList.value!.items![index];
                    List images = data.product!.image!.split(',');
                    double rating;
                    if (data.product!.rating is int) {
                      rating = data.product!.rating.toDouble();
                    } else if (data.product!.rating is double) {
                      rating = data.product!.rating;
                    } else {
                      rating = 1.0;
                    }
                    return Container(
                      height: screenHeight * 0.14,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                data.product!.image != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        height: screenHeight * 0.13,
                                        width: screenHeight * 0.1,
                                        errorWidget:
                                            (context, url, error) =>
                                                Shimmer.fromColors(
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
                                                            10.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                Shimmer.fromColors(
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
                                                            10.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                        imageUrl: (images[0]),
                                      ),
                                    )
                                    : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: screenHeight * 0.13,
                                        width: screenHeight * 0.1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10.0,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                    width: screenWidth * 0.122,
                                    height: screenHeight * 0.033,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '₹${data.product!.price}',
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenWidth / 1.6,
                                child: ListTile(
                                  title: Text(
                                    data.product!.category ?? '',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.00.sp,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    data.product!.color ?? '',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 10.00.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.subTitleColor,
                                    ),
                                  ),
                                  trailing: SizedBox(
                                    width: screenWidth * 0.3,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Quantity',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 13.00.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.black,
                                          ),
                                        ),

                                        SizedBox(
                                          width: 25,
                                          height: screenHeight * 0.022,
                                          child: Center(
                                            child:
                                                MaterialController
                                                        .to
                                                        .cartListLoading
                                                        .value
                                                    ? const SizedBox()
                                                    : Text(
                                                      '${data.quantity ?? 1}',
                                                      style: GoogleFonts.dmSans(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13.00.sp,
                                                        color: AppColor.black,
                                                      ),
                                                    ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 2.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBar(
                                      initialRating: rating,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 12,
                                      unratedColor: Colors.grey,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star_rounded,
                                          color: Color(0xffFFA800),
                                        ),
                                        half: const Icon(
                                          Icons.star_half_rounded,
                                          color: Color(0xffFFA800),
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline_rounded,
                                          color: Color(0xffFFA800),
                                        ),
                                      ),
                                      onRatingUpdate: (value) {},
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
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
                              ),
                            ],
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
              Container(
                color: Colors.white,
                height: screenHeight * 0.17,
                width: screenWidth,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: ListTile(
                    title: Row(
                      children: [
                        DottedBorder(
                          color: AppColor.dottedBorderColor,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          padding: EdgeInsets.zero,
                          child: SizedBox(
                            width: screenWidth / 1.6,
                            height: screenHeight * 0.055,
                            child: TextFormField(
                              controller: coupon,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01,
                                  ),
                                  child: Image.asset(
                                    'assets/images/pre_coupon.png',
                                  ),
                                ),

                                /// 🔹 SUFFIX CLOSE ICON
                                suffixIcon:
                                    coupon.text.isNotEmpty
                                        ? IconButton(
                                          icon: const Icon(
                                            Icons.close,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            coupon.clear();
                                            isCouponApplied = false;
                                            setState(() {});
                                          },
                                        )
                                        : null,

                                hintText: 'Enter coupon code',
                                hintStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.00.sp,
                                  color: AppColor.borderGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        (coupon.text.isEmpty &&
                                    MaterialController
                                            .to
                                            .cartList
                                            .value!
                                            .couponCode !=
                                        null ||
                                MaterialController
                                        .to
                                        .cartList
                                        .value!
                                        .couponCode !=
                                    '')
                            ? InkWell(
                              onTap: () async {
                                if (coupon.text.isEmpty) return;

                                await MaterialController.to.getCart(
                                  couponCode: coupon.text,
                                );

                                isCouponApplied = true;
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: screenWidth * 0.01,
                                ),
                                color: AppColor.primary,
                                width: screenWidth * .18,
                                height: screenHeight * .055,
                                alignment: Alignment.center,
                                child: Text(
                                  'ADD',
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.00.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Applied',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                    subtitle: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (BuildContext context) => Coupon(
                                  callBack: (value) {
                                    setState(() {
                                      coupon.text = value;
                                    });
                                  },
                                ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.018,
                        ),
                        child: Text(
                          'View All Coupon',
                          style: GoogleFonts.dmSans(
                            fontSize: 10.00.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.01,
                color: AppColor.addressBgColor,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.045,
                  vertical: screenHeight * 0.022,
                ),
                child: Obx(
                  () =>
                      MaterialController.to.cartListLoading.value
                          ? const SizedBox()
                          : MaterialController.to.cartList.value == null
                          ? const Center(child: Text('Cart is empty'))
                          : Column(
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
                                value:
                                    '${MaterialController.to.cartList.value!.subtotal ?? 0}',
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              amountText(
                                title: 'Discounts',
                                value:
                                    '${MaterialController.to.cartList.value!.discounts ?? 0}',
                                isDiscount: true,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              amountText(
                                title: 'Tax & Charges',
                                value:
                                    '${MaterialController.to.cartList.value!.taxAndCharges ?? 0}',
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              amountText(
                                title: 'Delivery Charges',
                                value:
                                    MaterialController
                                                .to
                                                .cartList
                                                .value!
                                                .deliveryCharges ==
                                            0
                                        ? 'Free'
                                        : '${MaterialController.to.cartList.value!.deliveryCharges}',
                              ),
                            ],
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            subtitle:
                MaterialController.to.cartListLoading.value
                    ? const SizedBox()
                    : MaterialController.to.cartList.value == null
                    ? const SizedBox()
                    : Text(
                      '₹${MaterialController.to.cartList.value!.total ?? 0}',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.00.sp,
                        color: Colors.white,
                      ),
                    ),
            trailing: InkWell(
              onTap: HomeController.to.placeOrderLoading.value?null: () {
                if (MaterialController.to.cartList.value != null) {
                  // Updated: Only pass address ID (or address string)
                  HomeController.to.placeOrder(addressId: widget.data!.address);
                }
              },
              child: Obx(
                () => Container(
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
                      HomeController.to.placeOrderLoading.value
                          ? LoadingAnimationWidget.horizontalRotatingDots(
                            color: AppColor.primary,
                            size: 50,
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
      ),
    );
  }

  Widget amountText({
    required String title,
    required String value,
    bool? isDiscount = false,
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
        isDiscount == true
            ? Text(
              '-₹$value',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 11.00.sp,
                color: AppColor.minusColor,
              ),
            )
            : Text(
              '₹$value',
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
