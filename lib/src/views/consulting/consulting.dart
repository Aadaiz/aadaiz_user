import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/online_consult.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Consulting extends StatefulWidget {
  const Consulting({super.key});

  @override
  State<Consulting> createState() => _ConsultingState();
}

class _ConsultingState extends State<Consulting> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.016
                  ),
                  child: Image.asset(
                      'assets/images/back.png'
                  )
              ),
            ),
            title: Text(
                'Consulting',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black
                )
            ),
            elevation: 2,
            centerTitle: true,
            shadowColor: AppColor.black,
            forceMaterialTransparency: false
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.01
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                        text: 'Let’s find\nyour top ',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.00.sp,
                              color: AppColor.black
                          ),
                        children: [
                          TextSpan(
                            text: 'Designer!',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.00.sp,
                                  color: AppColor.mangoColor
                              )
                          )
                        ]
                      )
                  ),
                  Image.asset(
                    'assets/images/pencil.png',
                    height: screenHeight * 0.08
                  )
                ]
              ),
              InkWell(
                onTap: (){

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const OnlineConsult()
                      )
                  );

                },
                child: Image.asset(
                  'assets/images/consulting/consulting_one.png',
                  height: screenHeight / 2.7
                ),
              ),
              Image.asset(
                  'assets/images/consulting/consulting_two.png',
                  height: screenHeight / 2.7
              )
            ]
          )
        )
      )
    );

  }

}