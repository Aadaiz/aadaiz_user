import 'package:aadaiz/src/res/components/custom_widgets.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

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
              'Profile',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.03
          ),
          child: Column(
            children: [
              Center(
                  child: Stack(
                      children: <Widget>[
                        const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/user_profile.png'
                            ),
                            radius: 55
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                                radius: 16,
                                backgroundColor: AppColor.profileBgColor,
                                child: SvgPicture.asset(
                                    'assets/svg/ic_edit.svg'
                                )
                            )
                        )
                      ]
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.018
              ),
              Text(
                  'Edit Image',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.00.sp,
                      color: AppColor.changeTextColor
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.018
              ),
              CustomWidgets.fullWidthTextField(
                  label: Text(
                      'User Name',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.00.sp,
                          color: AppColor.black
                      )
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Veronica',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.hintTextColor,
                              fontSize: 10.00.sp
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01
                            ),
                            child: SvgPicture.asset(
                                'assets/svg/ic_edit.svg'
                            )
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          )
                      )
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.018
              ),
              CustomWidgets.fullWidthTextField(
                  label: Text(
                      'Email',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.00.sp,
                          color: AppColor.black
                      )
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'vernoica123@gmail.com',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.hintTextColor,
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          )
                      )
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.018
              ),
              CustomWidgets.fullWidthTextField(
                  label: Text(
                      'Mobile Number',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.00.sp,
                          color: AppColor.black
                      )
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: '+91 123 456 8970',
                          hintStyle: GoogleFonts.dmSans(
                              color: AppColor.hintTextColor,
                              fontSize: 10.00.sp
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColor.textFieldLightBorderColor
                              )
                          )
                      )
                  )
              )
            ]
          )
        )
      )
    );

  }

}