import 'package:aadaiz_customer_crm/src/res/components/post_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/add_comment_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class SavedPostList extends StatefulWidget {
  const SavedPostList({super.key});

  @override
  State<SavedPostList> createState() => _SavedPostListState();
}

class _SavedPostListState extends State<SavedPostList> {
  final PostController controller = Get.find();
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
      body: Obx(() {
        if (controller.savedPostLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColor.primary,
            ),
          );
        }

        final posts = controller.savedPostList;

        return SmartRefresher(
          controller: controller.savedRefreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => controller.getProfilePosts(true),
          onLoading: () => controller.getProfilePosts(false),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                    return Stack(

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2.r),
                          child: FadeInImage(
                            image: NetworkImage(
                              posts[index].post!.postImage ?? '',
                            ),
                            placeholder: MemoryImage(kTransparentImage),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(

                          top: -4,
                          right: -2,

                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              iconSize: 18,
                              onPressed: () {
                                controller.deletePost(posts[index].post!.id);
                              },
                              icon: const Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
