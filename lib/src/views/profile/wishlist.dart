import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.016
              ),
              child: Image.asset(
                  'assets/images/back.png'
              )
          ),
          title: Text(
              'My Wishlist',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          elevation: 2,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
              horizontal: screenWidth * 0.033
          ),
          child: Column(
            children: [
              Container(
                height: screenHeight / 2,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  bottom: screenHeight * 0.05
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 2,
                    itemBuilder: (context, index){
        
                      return Padding(
                        padding: EdgeInsets.only(
                          right: screenWidth * 0.016
                        ),
                        child: SizedBox(
                            // height: screenHeight / 3.8,
                            width: screenWidth / 2.2,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      child: Image.asset(
                                        'assets/images/ethinic.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        top: 5,
                                        right: 5,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColor.white, shape: BoxShape.circle),
                                          padding: const EdgeInsets.all(6),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 8,
                                            child: Image.asset(
                                              'assets/images/trash_white.png',
                                              color: AppColor.trashColor
                                            )
                                          )
                                        )
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColor.black,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: AppColor.white, width: 3)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 8),
                                            child: Center(
                                              child: Text(
                                                '₹145',
                                                style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        fontSize: 10.00.sp,
                                                        color: AppColor.white,
                                                        fontWeight: FontWeight.w500
                                                    )
                                                )
                                              )
                                            )
                                          )
                                      )
                                    )
                                  ]
                                ),
                                ListTile(
                                    title: Text(
                                        'Mini',
                                        style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.00.sp,
                                            color: AppColor.black
                                        )
                                    ),
                                    subtitle: Text(
                                        'Vado Odelle Dress',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 10.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.subTitleColor
                                        )
                                    )
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                          children: List.generate(5, (index){
        
                                            return Icon(
                                                Icons.star,
                                                color: AppColor.starColor,
                                                size: screenHeight * 0.016
                                            );
        
                                          })
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.01
                                      ),
                                      Text(
                                          'View Review',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 9.00.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black,
                                              decoration: TextDecoration.underline
                                          )
                                      )
                                    ]
                                ),
                                Container(
                                  width: double.infinity,
                                  height: screenHeight * 0.055,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.black
                                    )
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/bag.png',
                                        height: screenHeight * 0.03
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.013
                                      ),
                                      Text(
                                        'Add to cart',
                                          style: GoogleFonts.dmSans(
                                              fontSize: 11.11.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black
                                          )
                                      )
                                    ]
                                  )
                                )
                              ]
                            )
                        )
                      );
        
                    }
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buy And Sell',
                    style: GoogleFonts.dmSans(
                        fontSize: 16.00.sp,
                        color: AppColor.textColor,
                        fontWeight: FontWeight.w400
                    )
                  ),
                  Image.asset(
                    'assets/images/arrow_up.png',
                    height: screenHeight * 0.045
                  )
                ]
              ),
              Container(
                  height: screenHeight / 2,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.05
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index){

                        return Padding(
                            padding: EdgeInsets.only(
                                right: screenWidth * 0.016
                            ),
                            child: SizedBox(
                              // height: screenHeight / 3.8,
                                width: screenWidth / 2.2,
                                child: Column(
                                    children: [
                                      Stack(
                                          children: [
                                            SizedBox(
                                              child: Image.asset(
                                                'assets/images/ethinic.png',
                                                fit: BoxFit.cover
                                              )
                                            ),
                                            Positioned(
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        shape: BoxShape.circle
                                                    ),
                                                    padding: const EdgeInsets.all(6),
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 8,
                                                        child: Image.asset(
                                                            'assets/images/trash_white.png',
                                                            color: AppColor.trashColor
                                                        )
                                                    )
                                                )
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColor.black,
                                                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(
                                                                color: AppColor.white,
                                                                width: 3
                                                            )
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 8
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                                '₹145',
                                                                style: GoogleFonts.dmSans(
                                                                    textStyle: TextStyle(
                                                                        fontSize: 10.00.sp,
                                                                        color: AppColor.white,
                                                                        fontWeight: FontWeight.w500
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                          ]
                                      ),
                                      ListTile(
                                          title: Text(
                                              'Mini',
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16.00.sp,
                                                  color: AppColor.black
                                              )
                                          ),
                                          subtitle: Text(
                                              'Vado Odelle Dress',
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 10.00.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.subTitleColor
                                              )
                                          )
                                      ),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                                children: List.generate(5, (index){

                                                  return Icon(
                                                      Icons.star,
                                                      color: AppColor.starColor,
                                                      size: screenHeight * 0.016
                                                  );

                                                })
                                            ),
                                            SizedBox(
                                                width: screenWidth * 0.01
                                            ),
                                            Text(
                                                'View Review',
                                                style: GoogleFonts.dmSans(
                                                    fontSize: 9.00.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor.black,
                                                    decoration: TextDecoration.underline
                                                )
                                            )
                                          ]
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: screenHeight * 0.055,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColor.black
                                              )
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/bag.png',
                                                    height: screenHeight * 0.03
                                                ),
                                                SizedBox(
                                                    width: screenWidth * 0.013
                                                ),
                                                Text(
                                                    'Add to cart',
                                                    style: GoogleFonts.dmSans(
                                                        fontSize: 11.11.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColor.black
                                                    )
                                                )
                                              ]
                                          )
                                      )
                                    ]
                                )
                            )
                        );

                      }
                  )
              )
            ]
          )
        )
      )
    );

  }

}