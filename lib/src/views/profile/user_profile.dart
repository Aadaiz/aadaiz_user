import 'dart:io';

import 'package:aadaiz/src/res/components/custom_widgets.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';
import '../../utils/textfield_capital.dart';
import '../home/controller/home_controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileController.to.image.value=File('');
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(
            100,
            6.0.hp,
          ),
          child:  CommonAppBar(
            title: 'Profile',
            isCheck: true,
            onTap: () async{
           await   ProfileController.to.uploadImage();
           await ProfileController.to.updateProfile();
            },
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045,
              vertical: screenHeight * 0.03
          ),
          child: Obx(()=>
            Column(
              children: [
                Center(
                    child: Stack(
                        children: <Widget>[ ProfileController.to.image.value.path!=''?
                        CircleAvatar(
                            backgroundImage: FileImage(
                              ProfileController.to.image.value,
                            ),
                            backgroundColor: Colors.transparent,
                            radius: 55
                        ):
                        ProfileController.to.profileData.value.profileImage!=null?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 25.0.hp,
                              errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/emtpy_profile.png',
                                  ),
                                  backgroundColor: Colors.transparent,
                                  radius: 55
                              ),
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              imageUrl: (ProfileController.to.profileData.value.profileImage),
                            ),
                          ):const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/emtpy_profile.png',
                              ),
                              backgroundColor: Colors.transparent,
                              radius: 55
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: (){
                                  ProfileController.to.showdialog(context,profile: true);
                                },
                                child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColor.profileBgColor,
                                    child: SvgPicture.asset(
                                        'assets/svg/ic_edit.svg'
                                    )
                                ),
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
                      controller: ProfileController.to.profileName,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          UpperCaseTextFormatter()
                        ],
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
            ),
          )
        )
      )
    );

  }

}