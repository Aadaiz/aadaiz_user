import 'dart:ui';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/saved_post_list.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: 'Your Profile',
        ),
      ),
      body: Obx(() {
        if (controller.profilePostLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColor.primary,
            ),
          );
        }

        final user = controller.myProfileData.value?.data?.user!;
        final posts = controller.profilePostList;
        String imageUrl = user?.profileImage ?? '';
        return SmartRefresher(
          controller: controller.profileRefreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.getProfilePosts(true),
          onLoading: () => controller.getProfilePosts(false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                FadeInImage(
                                  image:
                                      (user?.profileImage != null &&
                                              user!.profileImage!.isNotEmpty &&
                                              user.profileImage!.startsWith(
                                                'http',
                                              ))
                                          ? NetworkImage(user.profileImage!)
                                          : const AssetImage(
                                                'assets/images/profile_placeholder.png',
                                              )
                                              as ImageProvider,
                                  placeholder: MemoryImage(kTransparentImage),
                                  height: 133,
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return Container(
                                      height: 133,
                                      width: screenWidth,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(
                                      color: Colors.white.withAlpha(5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 55),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: _countWidget(
                                "${user?.followersCount ?? 0}",
                                "Followers",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                user?.profileImage ?? '',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: _countWidget(
                                "${user?.followingCount ?? 0}",
                                "Following",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  user?.username ?? "",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bio',
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user?.bio ?? "",
                      style: GoogleFonts.dmSans(fontSize: 12.sp),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: _button("Add Post +", true),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.bioController.text = user?.bio ?? '';
                            _showBioBottomSheet(context);
                          },
                          child: _button("Edit Bio", false),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => const SavedPostList(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: _button("Saved", false),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                GridView.builder(
                  itemCount: posts.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: screenHeight * 0.15,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: FadeInImage(
                        image:
                            (posts[index].postImage != null &&
                                    posts[index].postImage!.isNotEmpty &&
                                    posts[index].postImage!.startsWith('http'))
                                ? NetworkImage(posts[index].postImage!)
                                : const AssetImage(
                                      'assets/images/image_placeholder.png',
                                    )
                                    as ImageProvider,
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _countWidget(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.dmSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _button(String text, bool isPrimary) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? AppColor.primary : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: isPrimary ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,

      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Post',
                        style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.red, width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Container(
                    height: 215,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.black.withAlpha(20)),
                    ),
                    child: Obx(() {
                      return Center(
                        child:
                            controller.postImagFile.value == null
                                ? InkWell(
                                  onTap: () {
                                    controller.showDialogImage(
                                      context,
                                      picture: 1,
                                    );
                                  },
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      color: AppColor.red,
                                      strokeWidth: 1,
                                      dashPattern: const [5, 5],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.cloud_upload,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Add Picture',
                                            style: GoogleFonts.dmSans(
                                              fontSize: 10.sp,
                                              color: Colors.black.withAlpha(60),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                : Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        controller.postImagFile.value!,
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: InkWell(
                                        onTap: () {
                                          controller.postImagFile.value = null;
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08), // soft shadow
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 4), // bottom shadow
                        ),
                      ],
                    ),

                    child: TextFormField(
                      controller: controller.captionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Add Caption',

                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        fillColor: Colors.white,
                        filled: true,

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => CommonButton(
                      loading: controller.createPostLoading.value,
                      press: () {
                        controller.createPost();
                      },
                      text: 'Publish',
                      height: 45.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBioBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,

      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Bio',
                        style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.red, width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 15,
                            color: AppColor.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08), // soft shadow
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: const Offset(0, 4), // bottom shadow
                        ),
                      ],
                    ),

                    child: TextFormField(
                      controller: controller.bioController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Add Bio',

                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        fillColor: Colors.white,
                        filled: true,

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Obx(
                    () => CommonButton(
                      loading: controller.addBioLoading.value,
                      press: () {
                        controller.addBio();
                      },
                      text: 'Update',
                      height: 45.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
