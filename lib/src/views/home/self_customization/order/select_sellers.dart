import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/home/self_customization/order/product_customization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSellers extends StatefulWidget {
  const SelectSellers({super.key});

  @override
  State<SelectSellers> createState() => _SelectSellersState();
}

class _SelectSellersState extends State<SelectSellers> {

  final List _retailData = [
    {
      'name' : 'Fash Retail',
      'amount': '198.00',
      'is_selected': true
    },
    {
      'name' : 'Easy Retail',
      'amount': '197.00',
      'is_selected': false
    }
  ];

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
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
          'Select Sellers',
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
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.045
            ),
            ListTile(
              tileColor: Colors.white,
              selectedTileColor: Colors.white,
              leading: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColor.primary
                  )
                ),
                child: Image.asset(
                  'assets/images/women_square.png'
                )
              ),
              title: Text(
                'Mini',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp
                )
              ),
              subtitle: Text(
                'Vado Odelle Dress',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 8.7.sp,
                  color: AppColor.subTitleColor
                )
              ),
              trailing: Column(
                children: [
                  Text(
                    '₹198.00',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.00.sp,
                      color: AppColor.black
                    )
                  )
                ]
              )
            ),
            SizedBox(
                height: screenHeight * 0.03
            ),
            ListView.builder(
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04
                ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _retailData.length,
                itemBuilder: (context, i){

                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: screenHeight * 0.03
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.018,
                          vertical: screenHeight * 0.013
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            spreadRadius: 0
                          )
                        ]
                      ),
                      child: Column(
                          children: [
                            ListTile(
                                tileColor: Colors.white,
                                selectedTileColor: Colors.white,
                                leading: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/retail_logo.png'
                                    )
                                ),
                                title: Text(
                                    _retailData[i]['name'],
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.00.sp
                                    )
                                ),
                                subtitle: SizedBox(
                                    width: screenWidth * 0.3,
                                    child: Row(
                                        children: [
                                          Row(
                                              children: List.generate(4, (index){

                                                return Image.asset(
                                                    'assets/images/star.png'
                                                );

                                              })
                                          ),
                                          SizedBox(
                                              width: screenWidth * 0.01
                                          ),
                                          Text(
                                              '4 star',
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 9.00.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.black
                                              )
                                          )
                                        ]
                                    )
                                ),
                                trailing: Column(
                                    children: [
                                      Text(
                                          '₹${_retailData[i]['amount']}',
                                          style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.00.sp,
                                              color: AppColor.black
                                          )
                                      )
                                    ]
                                )
                            ),
                            SizedBox(
                                height: screenHeight * 0.01
                            ),
                            ExpansionTile(
                                title: Text(
                                    'About Seller',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 10.00.sp,
                                        fontWeight: FontWeight.w400
                                    )
                                ),
                                trailing: Image.asset(
                                    'assets/images/arrow_down.png'
                                )
                            ),
                            ExpansionTile(
                                title: Text(
                                    'Overall Rating',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 10.00.sp,
                                        fontWeight: FontWeight.w400
                                    )
                                ),
                                trailing: Image.asset(
                                    'assets/images/arrow_down.png'
                                )
                            ),
                            const Divider(
                                color: AppColor.dividerColor
                            ),
                            ListTile(
                                leading: SizedBox(
                                    height: screenHeight * 0.045,
                                    child: Image.asset(
                                        'assets/images/clock.png'
                                    )
                                ),
                                title: Text(
                                    'Fast Delivery By May 24, 2024',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.00.sp,
                                        color: AppColor.hintTextColor
                                    )
                                )
                            ),
                            SizedBox(
                                height: screenHeight * 0.01
                            ),
                            Container(
                                width: double.infinity,
                                height: screenHeight * 0.055,
                                decoration: BoxDecoration(
                                  color: _retailData[i]['is_selected'] ? Colors.white : AppColor.primary,
                                    border: Border.all(
                                        color: AppColor.primary
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                    _retailData[i]['is_selected'] ? 'Seller Selected' : 'Select Seller' ,
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.00.sp,
                                      color:  _retailData[i]['is_selected'] ? AppColor.black : Colors.white
                                    )
                                )
                            )
                          ]
                      )
                    )
                  );

                }
            ),
            SizedBox(
              width: screenWidth / 1.1,
              child: CommonButton(
                  text: 'Continue',
                  loading: false,
                  width: double.infinity,
                  height: screenHeight * 0.08,
                  press: (){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => const ProductDetails(rating: 3.0,)
                        )
                    );

                  }
              )
            ),
            SizedBox(
                height: screenHeight * 0.03
            )
          ]
        )
      )
    );

  }

}