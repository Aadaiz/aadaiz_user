import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/consulting/designer_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Designers extends StatefulWidget {
  const Designers({super.key});

  @override
  State<Designers> createState() => _DesignersState();
}

class _DesignersState extends State<Designers> {

  final List _dataList = ['Vijay', 'Joe', 'Prabhu', 'Karthi', 'Prabhu', 'Karthi'];

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
                'Designers',
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
      body: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.1
          ),
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.03,
            horizontal: screenWidth * 0.022
          ),
          itemCount: _dataList.length,
          itemBuilder: (_, int index){

            return Container(
                width: screenWidth / 3.3,
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.016,
                  vertical: screenHeight * 0.01
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)
                ),
                child: InkWell(
                    onTap: (){

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const DesignerDetail()
                          )
                      );

                    },
                    child: Column(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: screenHeight * 0.1,
                            child: Stack(
                                children: [
                                  SizedBox(
                                      child: Image.asset(
                                          'assets/images/consulting/designer_avatar.png',
                                          fit: BoxFit.cover
                                      )
                                  ),
                                  const Positioned(
                                      top: 7,
                                      right: 7,
                                      child: CircleAvatar(
                                        radius: 7,
                                        backgroundColor: AppColor.circleDotColor
                                      )
                                  )
                                ]
                            )
                          ),
                          const Spacer(),
                          Text(
                              _dataList[index],
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.00.sp,
                                  color: AppColor.designerColor
                              )
                          ),
                          Text(
                              'Designer',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.00.sp,
                                  color: AppColor.designerRoleColor
                              )
                          ),
                          Text(
                              '⭐️ 4.5 (135 reviews)',
                              style: GoogleFonts.dmSans(
                                  fontSize: 9.00.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.designerRoleColor
                              )
                          ),
                          const Spacer()
                        ]
                    )
                )
            );

          }
      )
    );

  }

}