import 'dart:io';

import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/components/custom_widgets.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    ProfileController.to.image.value = File('');
    isEdit=false;

  }
  bool isEdit=false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: Obx(()=>
       CommonAppBar(
         leadingclick: ()=>Get.back(),
            isLoading: ProfileController.to.UpdateprofileLoading.value,
            title: 'Profile',
            isCheck: (ProfileController.to.image.value.path !=''||isEdit==true)? true:false,
            onTap: () async {
              await ProfileController.to.updateProfile();
               Get.back();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.03,
          ),
          child: Obx(
            () => Column(
              children: [
                // ProfileController.to.UpdateprofileLoading.value?
                //     CommonLoading():
                Center(
                  child: Stack(
                    children: <Widget>[
                      ProfileController.to.image.value.path != ''
                          ? Container(
                            height: 15.0.hp,
                            width: 15.0.hp,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.withAlpha(55)),
                              image: DecorationImage(
                                image: FileImage(
                                  ProfileController.to.image.value,
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          )
                          : ProfileController
                                  .to
                                  .profileData
                                  .value
                                  .profileImage !=
                              null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(screenWidth),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.withAlpha(55)),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              height: 15.0.hp,
                              width: 15.0.hp,
                              errorWidget:
                                  (context, url, error) => const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/emtpy_profile.png',
                                    ),
                                    backgroundColor: Colors.transparent,
                                    radius: 55,
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
                              imageUrl:
                                  (ProfileController
                                      .to
                                      .profileData
                                      .value
                                      .profileImage),
                            ),
                          )
                          : const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/emtpy_profile.png',
                            ),
                            backgroundColor: Colors.transparent,
                            radius: 55,
                          ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: InkWell(
                          onTap: () {
                            ProfileController.to.showdialog(
                              context,
                              profile: true,
                            );
                          },
                          child: Container(
                            height: 4.0.hp,
                            width: 4.0.hp,
                            decoration: BoxDecoration(
                              color: AppColor.dropdownBgColor,
                              border: Border.all(
                                color: AppColor.white,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset('assets/svg/ic_edit.svg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                Text(
                  'Edit Image',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.00.sp,
                    color: AppColor.changeTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomWidgets.fullWidthTextField(
                  label: Text(
                    'User Name',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black,
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                        isEdit=true;
                      });
                    },
                    controller: ProfileController.to.profileName,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [UpperCaseTextFormatter()],
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Veronica',
                      hintStyle: GoogleFonts.dmSans(
                        color: AppColor.hintTextColor,
                        fontSize: 10.00.sp,
                      ),

                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomWidgets.fullWidthTextField(
                  label: Text(
                    'Email',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black,
                    ),
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      setState(() {
                        isEdit=true;
                      });
                    },

                    controller: ProfileController.to.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'vernoica123@gmail.com',
                      hintStyle: GoogleFonts.dmSans(
                        color: AppColor.hintTextColor,
                        fontSize: 10.00.sp,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomWidgets.fullWidthTextField(
                  label: Text(
                    'Mobile Number',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.00.sp,
                      color: AppColor.black,
                    ),
                  ),
                  child: TextFormField(
                    controller: ProfileController.to.mobile,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],

                    onChanged: (value) {
                      setState(() {
                        isEdit = true;
                      });
                    },

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter mobile number";
                      }
                      if (value.length != 10) {
                        return "Mobile number must be 10 digits";
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      counterText: "",
                      isDense: true,
                      hintText: 'Enter 10 digit mobile number',
                      hintStyle: GoogleFonts.dmSans(
                        color: AppColor.hintTextColor,
                        fontSize: 10.00.sp,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppColor.textFieldLightBorderColor,
                        ),
                      ),
                    ),
                  )

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
