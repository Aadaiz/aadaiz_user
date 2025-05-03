import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {

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
          elevation: 2,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.03
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.022
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Contact Info',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.00.sp,
                            color: AppColor.black
                        )
                    ),
                    SizedBox(
                      height: screenHeight * 0.03
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.00.sp,
                            color: AppColor.black
                        ),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.textFieldLabelColor
                          ),
                            isDense: true,
                            hintText: 'Name',
                            hintStyle: GoogleFonts.dmSans(
                                color: AppColor.black.withOpacity(0.5),
                                fontSize: 10.00.sp
                            ),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.underlineBorderColor
                                )
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.underlineBorderColor
                                )
                            ),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.underlineBorderColor
                              )
                          )
                        )
                    ),
                    SizedBox(
                        height: screenHeight * 0.022
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.00.sp,
                            color: AppColor.black
                        ),
                        decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.textFieldLabelColor
                            ),
                            isDense: true,
                            hintText: 'Mobile Number (+91)',
                            hintStyle: GoogleFonts.dmSans(
                                color: AppColor.black.withOpacity(0.5),
                                fontSize: 10.00.sp
                            ),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.underlineBorderColor
                                )
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.underlineBorderColor
                                )
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.underlineBorderColor
                                )
                            )
                        )
                    )
                  ]
                )
              ),
              Container(
                  color: AppColor.textFieldDividerColor,
                  width: double.infinity,
                  height: screenHeight * 0.03
              )
            ]
          )
        )
      )
    );

  }

}