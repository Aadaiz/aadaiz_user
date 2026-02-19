import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/res/components/image_preview.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/auth/controller/auth_controller.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/register_screen.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/controller.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/my_orders_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/payment_history.dart';
import 'package:aadaiz_customer_crm/src/views/profile/support/help_center.dart';
import 'package:aadaiz_customer_crm/src/views/profile/user_profile.dart';
import 'package:aadaiz_customer_crm/src/views/profile/wishlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileController.to.getProfile();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child:  CommonAppBar(title: 'Profile',leadingclick:(){
        DashboardController.to.tabSelected.value=0;}
       ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.03,
          ),
          child: Obx(
            () =>
                ProfileController.to.profileLoading.value
                    ? const ProfileShimmer()
                    : Column(
                      children: [
                        Center(
                          child: Stack(
                            children: <Widget>[
                              ProfileController
                                          .to
                                          .profileData
                                          .value
                                          .profileImage !=
                                      null
                                  ? SizedBox(
                                width: 15.0.hp,
                                height: 15.0.hp,
                                child: ZoomableImageWrapper(
                                  imageProvider: CachedNetworkImageProvider(
                                    ProfileController.to.profileData.value.profileImage ?? '',
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      ProfileController.to.profileData.value.profileImage ?? '',
                                      fit: BoxFit.cover,

                                      /// ✅ This guarantees circular image
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

                                      /// ✅ Circular shimmer
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),

                                      /// ✅ Circular fallback image
                                      errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                        backgroundImage:
                                        AssetImage('assets/images/emtpy_profile.png'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),

                              )


                                  : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/emtpy_profile.png',
                                    ),
                                // Positioned(
                                //     bottom: 0,
                                //     right: 0,
                                //     child: CircleAvatar(
                                //         radius: 16,
                                //         backgroundColor: AppColor.profileBgColor,
                                //         child: SvgPicture.asset(
                                //             'assets/svg/ic_edit.svg'
                                //         )
                                //     )
                                // )
                                    backgroundColor: Colors.transparent,
                                    radius: 55,
                                  ),

                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.018),
                        Text(
                          '${ProfileController.to.profileData.value.username ?? ''}'
                              .capitalizeFirst!,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 19.00.sp,
                            color: AppColor.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.022),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         Get.to(() => MyOrderScreen());
                        //       },
                        //       child: customWidget(
                        //         Image.asset(
                        //           'assets/dashboard/orders.png',
                        //           height: screenHeight * 0.03,
                        //           color: AppColor.black,
                        //         ),
                        //         'My Orders',
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: () {
                        //         Get.to(() => Wishlist());
                        //       },
                        //       child: customWidget(
                        //         const Icon(
                        //             Icons.favorite_border,
                        //             color: AppColor.textColor),
                        //         'Wishlist',
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: screenHeight * 0.01),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         Get.to(() => HelpCenter());
                        //       },
                        //       child: customWidget(
                        //         const Icon(
                        //           Icons.info,
                        //           color: AppColor.textColor,
                        //         ),
                        //         'Help Center',
                        //       ),
                        //     ),
                        //     // InkWell(
                        //     //   onTap: () {
                        //     //    // Get.to(() => ());
                        //     //   },
                        //     //   child: customWidget(
                        //     //     SvgPicture.asset(
                        //     //       'assets/svg/meetings.svg',
                        //     //       height: screenHeight * 0.03,
                        //     //     ),
                        //     //     'Meetings',
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
                        SizedBox(height: screenHeight * 0.012),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                        const UserProfile(),
                              ),
                            );
                          },
                          leading: SvgPicture.asset(
                            'assets/svg/ic_profile.svg',
                            width: screenWidth * 0.066,
                          ),
                          title: Text(
                            'Your Profile',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.black,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right_sharp),
                        ),
                        // ListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (BuildContext context) =>
                        //                   const PaymentHistory()));
                        //     },
                        //     leading: SvgPicture.asset(
                        //         'assets/svg/ic_transaction.svg',
                        //         width: screenWidth * 0.066),
                        //     title: Text('Payment History',
                        //         style: GoogleFonts.dmSans(
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: 12.00.sp,
                        //             color: AppColor.black)),
                        //     trailing: const Icon(Icons.chevron_right_sharp)),
                        // ListTile(
                        //   // onTap: ()=> Navigator.pushNamed(context, RoutesName.notificationPermissionActivity),
                        //   leading: SvgPicture.asset(
                        //     'assets/svg/ic_privacy.svg',
                        //     width: screenWidth * 0.066,
                        //   ),
                        //   title: Text(
                        //     'Privacy Policy',
                        //     style: GoogleFonts.dmSans(
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: 12.00.sp,
                        //       color: AppColor.black,
                        //     ),
                        //   ),
                        //   trailing: const Icon(Icons.chevron_right_sharp),
                        // ),
                        // ListTile(
                        //     // onTap: ()=> Navigator.pushNamed(context, RoutesName.notificationPermissionActivity),
                        //     leading: SvgPicture.asset(
                        //         'assets/svg/delete_account.svg',
                        //         width: screenWidth * 0.066),
                        //     title: Text('Delete Account',
                        //         style: GoogleFonts.dmSans(
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: 12.00.sp,
                        //             color: AppColor.black))),
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: screenHeight * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Logout',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19.00.sp,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        Text(
                                          'Are you sure you want to log out ?',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.00.sp,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap:
                                                  () => Navigator.pop(context),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                                width: screenWidth / 3.3,
                                                height: screenHeight * 0.066,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.00.sp,
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth / 3.3,
                                              child: CommonButton(
                                                press: () async {
                                                  await AuthController.to
                                                      .logOut();
                                                },
                                                text: 'Logout',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          leading: SvgPicture.asset(
                            'assets/svg/log_out.svg',
                            width: screenWidth * 0.066,
                          ),
                          title: Text(
                            'Log Out',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.exitTextColor,
                            ),
                          ),
                        ), ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: SizedBox(
                                    height: screenHeight * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Delete Account',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19.00.sp,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        Text(
                                          'Are you sure you want to Delete your Account ?',
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11.00.sp,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap:
                                                  () => Navigator.pop(context),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                                width: screenWidth / 3.3,
                                                height: screenHeight * 0.066,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13.00.sp,
                                                    color: AppColor.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth / 3.3,
                                              child: CommonButton(
                                                press: () async {
                                                  await AuthController.to
                                                      .logOut();
                                                },
                                                text: 'Delete Account',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          leading: SvgPicture.asset(
                            'assets/svg/log_out.svg',
                            width: screenWidth * 0.066,
                          ),
                          title: Text(
                            'Delete Account',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.exitTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget customWidget(Widget icon, text) {
    return Container(
      width: Get.width * 0.43,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.tileBorderColor),
      ),
      child: Row(
        spacing: 8,
        children: [
          icon,
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 12.00.sp,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
