import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/auth/controller/auth_controller.dart';
import 'package:aadaiz/src/views/auth/ui/register_screen.dart';
import 'package:aadaiz/src/views/my_orders/my_orders_screen.dart';
import 'package:aadaiz/src/views/profile/payment_history.dart';
import 'package:aadaiz/src/views/profile/support/help_center.dart';
import 'package:aadaiz/src/views/profile/user_profile.dart';
import 'package:aadaiz/src/views/profile/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
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
                  'Veronica',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.00.sp,
                      color: AppColor.black
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.tileBorderColor
                      )
                    ),
                    width: screenWidth / 2.4,
                    child: ListTile(
                      onTap: (){

                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => const MyOrderScreen()
                            )
                        );

                      },
                      leading: Image.asset(
                        'assets/dashboard/orders.png',
                        height: screenHeight * 0.03,
                        color: AppColor.black
                      ),
                      title: Text(
                          'My Orders',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.textColor
                          )
                      )
                    )
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.tileBorderColor
                          )
                      ),
                      width: screenWidth / 2.4,
                      child: ListTile(
                        onTap: (){

                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => const Wishlist()
                              )
                          );

                        },
                          leading: const Icon(
                            Icons.favorite_border,
                            color: AppColor.textColor
                          ),
                          title: Text(
                              'Wish list',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.00.sp,
                                  color: AppColor.black
                              )
                          )
                      )
                  )
                ]
              ),
              SizedBox(
                  height: screenHeight * 0.01
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.tileBorderColor
                            )
                        ),
                        width: screenWidth / 2.4,
                        child: ListTile(
                          onTap: (){

                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => const HelpCenter()
                                )
                            );

                          },
                            leading: const Icon(
                                Icons.info,
                                color: AppColor.textColor
                            ),
                            title: Text(
                                'Help Centre',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            )
                        )
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.tileBorderColor
                            )
                        ),
                        width: screenWidth / 2.4,
                        child: ListTile(
                            leading: SvgPicture.asset(
                                'assets/svg/meetings.svg',
                                height: screenHeight * 0.03
                            ),
                            title: Text(
                                'Meetings',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.00.sp,
                                    color: AppColor.black
                                )
                            )
                        )
                    )
                  ]
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              ListTile(
                  onTap: (){

                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const UserProfile()
                        )
                    );

                  },
                  leading: SvgPicture.asset(
                      'assets/svg/ic_profile.svg',
                      width: screenWidth * 0.066
                  ),
                  title: Text(
                      'Your Profile',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.black
                      )
                  ),
                  trailing: const Icon(
                      Icons.chevron_right_sharp
                  )
              ),
              ListTile(
                onTap: (){

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const PaymentHistory()
                      )
                  );

                },
                  leading: SvgPicture.asset(
                      'assets/svg/ic_transaction.svg',
                      width: screenWidth * 0.066
                  ),
                  title: Text(
                      'Payment History',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.black
                      )
                  ),
                  trailing: const Icon(
                      Icons.chevron_right_sharp
                  )
              ),
              ListTile(
                // onTap: ()=> Navigator.pushNamed(context, RoutesName.notificationPermissionActivity),
                  leading: SvgPicture.asset(
                      'assets/svg/ic_privacy.svg',
                      width: screenWidth * 0.066
                  ),
                  title: Text(
                      'Privacy Policy',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.black
                      )
                  ),
                  trailing: const Icon(
                      Icons.chevron_right_sharp
                  )
              ),
              ListTile(
                // onTap: ()=> Navigator.pushNamed(context, RoutesName.notificationPermissionActivity),
                  leading: SvgPicture.asset(
                      'assets/svg/delete_account.svg',
                      width: screenWidth * 0.066
                  ),
                  title: Text(
                      'Delete Account',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.black
                      )
                  )
              ),
              ListTile(
                onTap: (){

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {

                        return Dialog(
                          child: SizedBox(
                            height: screenHeight * 0.22,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                    'Logout',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 19.00.sp,
                                        color: AppColor.primary
                                    )
                                ),
                                Text(
                                    'Are you sure you want to log out ?',
                                    style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11.00.sp,
                                        color: AppColor.primary
                                    )
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: ()=> Navigator.pop(context),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: AppColor.primary
                                                )
                                            ),
                                            width: screenWidth / 3.3,
                                            height: screenHeight * 0.066,
                                            alignment: Alignment.center,
                                            child: Text(
                                                'Cancel',
                                                style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.00.sp,
                                                    color: AppColor.primary
                                                )
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth / 3.3,
                                          child: CommonButton(
                                              press: ()async{
                                             await AuthController.to.logOut();
                                              },
                                              text: 'Logout'
                                          )
                                      )
                                    ]
                                )
                              ]
                            )
                          )
                        );

                      }
                  );

                },
                  leading: SvgPicture.asset(
                      'assets/svg/log_out.svg',
                      width: screenWidth * 0.066
                  ),
                  title: Text(
                      'Log Out',
                      style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.exitTextColor
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