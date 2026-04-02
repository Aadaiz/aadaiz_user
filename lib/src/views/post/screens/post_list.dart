import 'package:aadaiz_customer_crm/src/res/components/post_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/search_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/add_comment_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/chat_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_other_profile_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_profile_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/search_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  PostController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: 'Post'),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () => controller.getPostListData(true),
        onLoading: () => controller.getPostListData(false),
        child: Obx(() {
          if (controller.postListLoading.value && controller.postList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
            itemCount: controller.postList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    headerWidget(),
                    SizedBox(
                      height: Utils.getActivityScreenHeight(context) * 0.02,
                    ),
                  ],
                );
              }

              final post = controller.postList[index - 1];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PostCard(
                  profileTap: () {
                    (ProfileController.to.profileData.value.id != post.user!.id)
                        ? Get.to(
                          () => OthersProfileScreen(userId: post.userId),
                          transition: Transition.rightToLeft,
                        )
                        : Get.to(
                          () => const ProfileScreen(),
                          transition: Transition.rightToLeft,
                        );
                  },

                  post: post,
                  saveOnTap: () {
                    controller.savePost(post);
                  },
                  onTap: () {
                    Get.to(
                      () => AddCommentScreen(post: post),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 600),
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        InkWell(
          onTap: () {
            Get.to(
              () => const ProfileScreen(),
              transition: Transition.rightToLeft,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),

            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 40,
              width: 40,
              errorWidget:
                  (context, url, error) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40,
                      width: 40,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              progressIndicatorBuilder:
                  (context, url, progress) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              imageUrl: ProfileController.to.profileData.value.profileImage,
            ),
          ),
        ),

        Expanded(
          child: SearchField(
            hintText: "Search ",
            showSuffix: true,
            onTap: () {
              Get.to(
                () => const SearchImageScreen(),
                transition: Transition.rightToLeft,
              );
            },
            readOnly: true,
          ),
        ),
        InkWell(
          onTap: () {


          }
          ,
          child: Column(
            children: [
              Image.asset('assets/images/message.png', width: 25),
              Text(
                'Chat',
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
