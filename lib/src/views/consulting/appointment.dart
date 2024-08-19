import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/consulting/designers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appointment extends StatefulWidget {

  final double screenWidth;
  final double screenHeight;

  const Appointment({super.key, required this.screenWidth, required this.screenHeight});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {

  final List _categories = [
    {
      'name' : 'Men',
      'image' : 'assets/images/consulting/men.png'
    },
    {
      'name' : 'Women',
      'image' : 'assets/images/consulting/women.png'
    },
    {
      'name' : 'Boy',
      'image' : 'assets/images/consulting/boy.png'
    },
    {
      'name' : 'Girl',
      'image' : 'assets/images/consulting/girl.png'
    }
  ];
  final List _designerList = [
    {
      'gender' : 'Male',
      'image' : 'assets/images/consulting/designer_male.png'
    },
    {
      'gender' : 'Female',
      'image' : 'assets/images/consulting/designer_female.png'
    }
  ];
  int _pickedCategoryIndex = -1;
  int _pickedDesignerIndex = -1;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Select Category',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black
                )
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: widget.screenHeight * 0.022
              ),
              height: widget.screenHeight * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  vertical: widget.screenHeight * 0.02
                ),
                itemCount: _categories.length,
                  itemBuilder: (BuildContext context, int index){

                    return InkWell(
                      onTap: (){

                        setState(() {

                          _pickedCategoryIndex = index;

                        });

                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: widget.screenWidth * 0.01
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 4)
                              )
                            ],
                          border: Border.all(
                            color: _pickedCategoryIndex == index ? AppColor.requiredTextColor : Colors.white
                          )
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: widget.screenHeight * 0.088,
                              width: widget.screenWidth * 0.22,
                              child: Image.asset(
                                _categories[index]['image'],
                                height: widget.screenHeight * 0.088,
                                fit: BoxFit.cover
                              )
                            ),
                            Text(
                                _categories[index]['name'],
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8.00.sp,
                                    color: AppColor.black
                                )
                            )
                          ]
                        )
                      )
                    );

                  }
              )
            ),
            Text(
                'Designer Preference',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black
                )
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: widget.screenHeight * 0.022
              ),
              height: widget.screenHeight * 0.16,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      vertical: widget.screenHeight * 0.02
                  ),
                  itemCount: _designerList.length,
                  itemBuilder: (BuildContext context, int index){

                    return InkWell(
                      onTap: (){

                        setState(() {

                          _pickedDesignerIndex = index;

                        });

                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: widget.screenWidth * 0.01
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: widget.screenHeight * 0.005
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: _pickedDesignerIndex == index ? AppColor.requiredTextColor : Colors.transparent
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: widget.screenHeight * 0.088,
                                    width: widget.screenWidth * 0.22,
                                    child: Image.asset(
                                        _designerList[index]['image'],
                                        height: widget.screenHeight * 0.088,
                                        fit: BoxFit.cover
                                    )
                                ),
                                Text(
                                    _designerList[index]['gender'],
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 8.00.sp,
                                        color: AppColor.black
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
        ),
        CommonButton(
            press: (){

              if(_pickedDesignerIndex != -1 && _pickedCategoryIndex != -1){

                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Designers()
                    )
                );

              }

            },
            text: 'Continue'
        )
      ]
    );

  }

}