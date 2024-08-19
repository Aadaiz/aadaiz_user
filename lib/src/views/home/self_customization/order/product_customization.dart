import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:aadaiz/src/views/material/add_measurement.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/productlist_model.dart';
import '../product/people_viewed_product_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, this.data, required this.rating});
  final PatternListDatum? data;
  final double rating;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final List<String> _fabric = ["5", "10"];
  String size = '';
  String displayImage = '';
  int selected = 0;
  List images =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     images = widget.data!.imageUrl.split(',');
    displayImage=images[0];
    HomeController.to.cartLoading(false);
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    final String selectedValue = _fabric.first;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
                  child: Image.asset('assets/images/back.png')),
            ),
            shadowColor: AppColor.black,
            forceMaterialTransparency: false,
            elevation: 4),
        body: SingleChildScrollView(
            child: Obx(
          () => Column(children: [
            SizedBox(height: screenHeight * 0.022),
            Center(
                child: Container(
                    height: screenHeight * 0.22,
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                        color: AppColor.productBgColor,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(displayImage), fit: BoxFit.cover)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.03,
                                  top: screenHeight * 0.01),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.favorite_border,
                                      color: AppColor.black))),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  screenHeight * 0.01,
                                  screenWidth * 0.03,
                                  screenHeight * 0.01),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.008,
                                            vertical: screenHeight * 0.005),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFE9E9E9)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.018,
                                                vertical: screenHeight * 0.008),
                                            alignment: Alignment.center,
                                            child: Text('Customize',
                                                style: GoogleFonts.inter(
                                                    color: AppColor.primary,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 8.7.sp)))),
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                            'assets/images/send.png'))
                                  ]))
                        ]))),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                height: screenHeight * 0.08,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      displayImage=images[0];
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.018),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                displayImage = images[index];
                                selected=index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selected==index? AppColor.primary:Colors.transparent, // Set the border color to blue
                                  width: 2, // Set the border width
                                ),
                                borderRadius: BorderRadius.circular(10), // Match the border radius with ClipRRect
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  images[index],
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ));
                    })),
            SizedBox(height: screenHeight * 0.03),
            Container(
              color: Colors.red,
                width: screenWidth,
                child: ListTile(
                    title: Text(widget.data!.title ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.39.sp,
                            color: AppColor.black)),
                    subtitle: Text(widget.data!.subTitle ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.24.sp,
                            color: AppColor.subTitleColor)),
                    trailing: Column(children: [
                      Text('₹${widget.data!.price ?? ''}',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 22.00.sp,
                              color: AppColor.black))
                    ]))),
            SizedBox(
                width: screenWidth,
                child: Row(children: [
                  RatingBar(
                      initialRating: widget.rating,
                      direction: Axis.horizontal,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      unratedColor: Colors.grey,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star_rounded,
                              color: Color(0xffFFA800)),
                          half: const Icon(Icons.star_half_rounded,
                              color: Color(0xffFFA800)),
                          empty: const Icon(Icons.star_outline_rounded,
                              color: Color(0xffFFA800))),
                      onRatingUpdate: (value) {}),
                  SizedBox(width: screenWidth * 0.01),
                  Text('View Review',
                      style: GoogleFonts.dmSans(
                          fontSize: 14.00.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                          decoration: TextDecoration.underline))
                ])),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                width: screenWidth,
                child: Text('Size',
                    style: GoogleFonts.dmSans(
                        fontSize: 14.00.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.primary))),
            Container(
                width: screenWidth ,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                alignment: Alignment.centerLeft,
                child: GroupButton<String>(
                    buttons: widget.data!.sizes.split(','),
                    onSelected: (value, i, isSelected) {
                      setState(() {
                        size = value;
                      });
                    },
                    options: GroupButtonOptions(
                      buttonWidth: 40,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      borderRadius: BorderRadius.circular(50),
                      selectedColor: AppColor.primary,
                      selectedBorderColor: AppColor.groupBtnBorderColor,
                      unselectedBorderColor: AppColor.groupBtnBorderColor,
                      selectedTextStyle: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.00.sp),
                      unselectedTextStyle: GoogleFonts.dmSans(
                          color: AppColor.groupBtnTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.00.sp),
                    ))),
            Container(
                width: screenHeight,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.1),
                child: RichText(
                    text: TextSpan(
                        text: 'How Many meters fabric you have ? ',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.00.sp,
                            color: AppColor.black),
                        children: [
                      TextSpan(
                          text: ' *',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.requiredTextColor))
                    ]))),
            Container(
                width: screenWidth,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppColor.dropdownBgColor)),
                child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    borderRadius: BorderRadius.circular(3),
                    underline: const SizedBox(),
                    value: selectedValue,
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.00.sp,
                        color: AppColor.black.withOpacity(0.5)),
                    isExpanded: true,
                    hint: Text('Choose Here',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.black.withOpacity(0.5))),
                    items: _fabric.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                          value: val, child: Text(val));
                    }).toList(),
                    onChanged: (String? val) {})),
            Container(
                width: screenHeight,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.1),
                child: Text('Required 5 Mtr',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.00.sp,
                        color: AppColor.requiredTextColor))),
            Container(
                width: screenWidth ,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddMeasurement()));
                    },
                    tileColor: AppColor.primary,
                    title: Text('Add Measurement',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: Colors.white)),
                    trailing: Image.asset('assets/images/arrow_right.png',
                        height: screenHeight * 0.022))),
            SizedBox(
                width: screenWidth,
                child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.022),
                      child: Text('Description',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.00.sp,
                              color: AppColor.black)),
                    ),
                    subtitle: Text(widget.data!.description ?? '',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.subTitleColor)))),
            Container(
              width: screenWidth,
              height: screenHeight * 0.022,
              color: AppColor.containerDividerColor,
            ),
            Container(
                width: screenHeight ,
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.1),
                child: Text('Ratings & Reviews',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.00.sp,
                        color: AppColor.textColor))),
            RatingsWidget(
              rating: widget.data!.rating,
              averageRating: 4.3,
              totalRatings: 23,
              ratingCounts: [
                12,
                5,
                4,
                2,
                8
              ], // Replace with actual rating counts
            ),
            Container(
                margin: EdgeInsets.only(top: screenHeight * 0.022),
                width: screenWidth / 1.2,
                alignment: Alignment.centerLeft,
                child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/human_avatar.png'))),
            SizedBox(
                width: screenWidth / 1.3,
                child: ListTile(
                    title: Text('Angel',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.00.sp,
                            color: AppColor.textColor)),
                    subtitle: Row(
                        children: List.generate(5, (index) {
                      return index == 4
                          ? Icon(Icons.star_border_outlined,
                              color: AppColor.borderGrey,
                              size: screenHeight * 0.022)
                          : Icon(Icons.star,
                              color: AppColor.starColor,
                              size: screenHeight * 0.022);
                    })),
                    trailing: Text('June 5, 2019',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.borderGrey)))),
            Text('''
                I recently purchased a dress from [Your 
                Online Shopping Platform], and I must say, 
                I'm absolutely thrilled with my purchase! 
                The dress exceeded my expectations in 
                every way.
                Firstly, the quality of the fabric is 
                exceptional. It's soft, comfortable, and 
                feels luxurious against my skin. 
                I was also impressed by the attention to detail.''',
                style: GoogleFonts.dmSans(
                    fontSize: 10.00.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor)),
            Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.033, bottom: screenHeight * 0.03),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Helpful',
                          style: GoogleFonts.dmSans(
                              fontSize: 10.00.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.borderGrey)),
                      Image.asset('assets/images/like.png',
                          height: screenHeight * 0.045)
                    ])),
            SizedBox(
                width: screenWidth / 1.2,
                child: PhysicalShape(
                    color: Colors.white,
                    elevation: 18,
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    child: ListTile(
                        title: Text('All 106 review',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.textColor)),
                        trailing: Image.asset(
                            'assets/images/arrow_right_orange.png',
                            height: screenHeight * 0.022)))),
            SizedBox(height: screenHeight * 0.03),
            SizedBox(
                width: screenWidth / 1.2,
                child: Text('Seller',
                    style: GoogleFonts.dmSans(
                        fontSize: 12.00.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black))),
            Container(
                width: screenWidth / 1.2,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.018,
                    vertical: screenHeight * 0.013),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      spreadRadius: 0)
                ]),
                child: Column(children: [
                  ListTile(
                      tileColor: Colors.white,
                      selectedTileColor: Colors.white,
                      leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/retail_logo.png')),
                      title: Text('Aadaiz',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400, fontSize: 14.00.sp)),
                      subtitle: SizedBox(
                          width: screenWidth * 0.3,
                          child: Row(children: [
                            Row(
                                children: List.generate(4, (index) {
                              return Image.asset('assets/images/star.png');
                            })),
                            SizedBox(width: screenWidth * 0.01),
                            Text('4 star',
                                style: GoogleFonts.dmSans(
                                    fontSize: 9.00.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black))
                          ])),
                      trailing: Column(children: [
                        Text('₹189',
                            style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.00.sp,
                                color: AppColor.black))
                      ])),
                  SizedBox(height: screenHeight * 0.01),
                  ExpansionTile(
                      title: Text('About Seller',
                          style: GoogleFonts.dmSans(
                              fontSize: 10.00.sp, fontWeight: FontWeight.w400)),
                      trailing: Image.asset('assets/images/arrow_down.png'),
                      shape: const Border(),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Text('Reseller',
                            style: GoogleFonts.dmSans(
                                fontSize: 10.00.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.hintTextColor))
                      ]),
                  ExpansionTile(
                      title: Text('Overall Rating',
                          style: GoogleFonts.dmSans(
                              fontSize: 10.00.sp, fontWeight: FontWeight.w400)),
                      trailing: Image.asset('assets/images/arrow_down.png'),
                      shape: const Border(),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        ListTile(
                            title: Text('Product Quality',
                                style: GoogleFonts.dmSans(
                                    fontSize: 10.00.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.hintTextColor)),
                            trailing: SizedBox(
                                width: screenWidth * 0.3,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                          children: List.generate(4, (index) {
                                        return Image.asset(
                                            'assets/images/star.png');
                                      })),
                                      SizedBox(width: screenWidth * 0.01),
                                      Text('4 star',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 9.00.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black))
                                    ]))),
                        ListTile(
                            title: Text('Service Quality',
                                style: GoogleFonts.dmSans(
                                    fontSize: 10.00.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.hintTextColor)),
                            trailing: SizedBox(
                                width: screenWidth * 0.3,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                          children: List.generate(3, (index) {
                                        return Image.asset(
                                            'assets/images/star.png');
                                      })),
                                      SizedBox(width: screenWidth * 0.01),
                                      Text('3 star',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 9.00.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black))
                                    ])))
                      ]),
                  const Divider(color: AppColor.dividerColor),
                  SizedBox(height: screenHeight * 0.01),
                  const Divider(color: AppColor.dividerColor),
                  ListTile(
                      title: Text('Select Other Sellers',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 10.00.sp,
                              color: Colors.black)),
                      trailing: Image.asset('assets/images/arrow_right.png',
                          color: AppColor.black, height: screenHeight * 0.022))
                ])),
            Container(
                width: screenWidth / 1.2,
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset('assets/images/truck.png',
                        height: screenHeight * 0.05),
                    title: Text('Fast Delivery',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.00.sp,
                            color: AppColor.black)),
                    subtitle: Text('Deliver from 2 Feb',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.hintTextColor)),
                    trailing: Text('Learn more',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.00.sp,
                            color: AppColor.primary)))),
            SizedBox(
                width: screenWidth / 1.2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: screenHeight * 0.05,
                          //width: screenWidth * 0.28,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.primary),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('assets/images/share.png',
                                    width: screenWidth * 0.1),
                                Text('Share',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.00.sp,
                                        color: Colors.white))
                              ])),
                      Gap(screenWidth * 0.05),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            HomeController.to.cart(
                              action: 'add',
                              id: widget.data!.id,
                              price: widget.data!.price,
                              gst: widget.data!.price,
                              quantity: 1,
                              size: size,
                            );
                          },
                          child: Container(
                              height: screenHeight * 0.05,
                              // width: screenWidth * 0.45,
                              // padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: AppColor.black, width: 2)),
                              child: HomeController.to.cartLoading.value
                                  ? SizedBox(
                                      // height: 1.00.hp,
                                      width: 1.00.wp,
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                        color: AppColor.primary,
                                        size: 5.00.hp,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Image.asset('assets/images/bag.png',
                                              height: screenHeight * 0.03),
                                          SizedBox(
                                            width: screenWidth * 0.05,
                                          ),
                                          Text('Add to cart',
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.00.sp,
                                                  color: Colors.black))
                                        ])),
                        ),
                      )
                    ])),
            Container(
                width: screenWidth / 1.2,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.022),
                child: Text('People Also Viewed',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.00.sp,
                        color: Colors.black))),
            HomeController.to.peopleMostViewList.value.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      SizedBox(
                          height: screenHeight * 0.45,
                          child: ListView.builder(
                              itemCount: HomeController
                                  .to.peopleMostViewList.value.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final data = HomeController
                                    .to.peopleMostViewList.value[index];
                                final images = data.imageUrl.split(',');
                                double rating;
                                if (data.rating is int) {
                                  rating = data.rating.toDouble();
                                } else if (data.rating is double) {
                                  rating = data.rating;
                                } else {
                                  rating = 1.0;
                                }
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                          data: data,
                                                          rating: rating)));
                                        },
                                        child: PeopleViewedProductWidget(
                                            data: data,
                                            images: images,
                                            rating: rating)));
                              })),
                    ],
                  ),
            InkWell(
              onTap: () {},
              child: Container(
                  width: screenWidth / 1.2,
                  height: screenHeight * 0.055,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColor.primary)),
                  alignment: Alignment.center,
                  child: Text('View More',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.00.sp,
                          color: AppColor.black))),
            ),
            SizedBox(height: screenHeight * 0.03)
          ]),
        )));
  }
}

class RatingsWidget extends StatelessWidget {
  final double averageRating;
  final int totalRatings;
  final List<int> ratingCounts;
  final dynamic rating;
  const RatingsWidget({
    Key? key,
    required this.averageRating,
    required this.totalRatings,
    required this.ratingCounts,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(children: [
                Text('${rating}',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 38.00.sp,
                        color: AppColor.textColor)),
                Text('23 ratings',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.00.sp,
                        color: AppColor.borderGrey))
              ]),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i <= 4; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: List.generate(
                                  5 - i,
                                  (index) => Icon(Icons.star,
                                      color: AppColor.starColor,
                                      size: Get.height * 0.022)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width:
                                      (200 * ratingCounts[4 - i] / totalRatings)
                                          .clamp(0, 200),
                                  height: Get.height * 0.022,
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(19))),
                              const SizedBox(width: 8),
                              Text(ratingCounts[4 - i].toString(),
                                  style: GoogleFonts.dmSans(
                                      fontSize: 12.00.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.ratingTextColor))
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
