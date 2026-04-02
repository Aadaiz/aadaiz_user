import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/chat_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class OthersProfileScreen extends StatefulWidget {
  final dynamic userId;
  const OthersProfileScreen({super.key, required this.userId});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileScreenState();
}

class _OthersProfileScreenState extends State<OthersProfileScreen> {
  final PostController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOtherProfile(widget.userId, true);
  }

  Future<Map<String, dynamic>?> createConversation({
    required String receiverId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "https://aadaizcrm.aadaiz.com/aadaiz-new/public/index.php/api/post/store",
        ),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "receiver_id": receiverId,
          "message": "", // 👈 empty or "Hi"
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        /// 🔥 IMPORTANT: backend must return conversation_id
        return data['data'];
      }
    } catch (e) {
      log("Create conversation error: $e");
    }

    return null;
  }

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
        if (controller.otherProfileLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColor.primary,
            ),
          );
        }

        final user = controller.otherProfileData.value?.data?.user;
        final posts = controller.otherProfilePostList;

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh:
              () => controller.getOtherProfile(user?.id.toString() ?? '', true),
          onLoading:
              () =>
                  controller.getOtherProfile(user?.id.toString() ?? '', false),
          controller: controller.otherRefreshController,
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
                      Obx(
                        () => Expanded(
                          child: InkWell(
                            onTap: () {
                              if (user?.id != null) {
                                controller.followOthers(user!.id.toString());
                              }
                            },
                            child: _button(
                              user?.isFollowing == true
                                  ? "Following"
                                  : "Follow",
                              user?.isFollowing == true ? true : false,
                              controller.followOthersLoading.value,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            final token = prefs.getString("token");

                            final response = await createConversation(
                              receiverId: user!.id.toString(),
                              token: token!,
                            );

                            if (response == null) {
                              CommonToast.show(msg: 'Something went wrong');
                              return;
                            }

                            await Get.to(
                              () => PostChatScreen(
                                conversationId:
                                    response['conversation_id'].toString(),
                                receiverId: user.id.toString(),
                                token: token,
                                currentUserId:
                                    ProfileController.to.profileData.value.id
                                        .toString(),
                                profileName: user.username.toString(),
                                profileImage: user.profileImage.toString(),
                              ),
                            );
                          },
                          child: _button("Message", true, false),
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

  Widget _button(String text, bool isPrimary, bool isLoading) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPrimary ? AppColor.primary : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child:
          isLoading
              ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: isPrimary ? Colors.white : AppColor.primary,
                  strokeWidth: 2,
                ),
              )
              : Text(
                text,
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isPrimary ? Colors.white : Colors.black,
                ),
              ),
    );
  }
}
