import 'dart:ui';

import 'package:aadaiz_customer_crm/src/res/components/post_card.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart'
    as post;
import 'package:aadaiz_customer_crm/src/views/post/screens/add_comment_screen.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_other_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as AppColor;
import 'package:get/get.dart';

class PostViewDetailScreen extends StatefulWidget {
  final dynamic id;
  const PostViewDetailScreen({super.key, required this.id});

  @override
  State<PostViewDetailScreen> createState() => _PostViewDetailScreenState();
}

class _PostViewDetailScreenState extends State<PostViewDetailScreen> {
  PostController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getPostViewDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: ''),
      ),
      body: Obx(() {
        if (controller.getPosViewDetailsLoading.value) {
          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: AppColor.primary,
                strokeWidth: 2,
              ),
            ),
          );
        }

        final viewData = controller.getPosViewDetails.value;

        if (viewData == null) {
          return const Center(child: Text("No Data"));
        }

        final data = post.Datum(
          id: viewData.id,
          userId: viewData.userId,
          postImage: viewData.postImage,
          caption: viewData.caption,
          createdAt: viewData.createdAt,
          updatedAt: viewData.updatedAt,
          likesCount: viewData.likesCount,
          commentsCount: viewData.commentsCount,
          isLiked: viewData.isLiked,
          isSaved: viewData.isSaved,

          user:
              viewData.user != null
                  ? post.DatumUser(
                    id: viewData.user!.id,
                    username: viewData.user!.username ?? '',
                    profileImage: viewData.user!.profileImage ?? '',
                  )
                  : null,

          postComment: viewData.postComment
              ?.map(
                (e) => post.PostComment(
              id: e.id,
              comment: e.comment ?? '',
              userId: e.userId,
              createdAt: e.createdAt,

              user: e.user != null
                  ? post.PostCommentUser(
                id: e.user!.id,
                username: e.user!.username ?? '',
                userProfileImage: e.user!.userProfileImage ?? '',
              )
                  : null,
            ),
          )
              .toList(),
        );

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PostCard(
                post: data,
                profileTap: () {
                  Get.to(() => OthersProfileScreen(userId: data.userId));
                },
                saveOnTap: () {
                  controller.savePost(data);
                },
                onTap: () {
                  Get.to(
                    () => AddCommentScreen(post: data),
                    transition: Transition.downToUp,
                    duration: const Duration(milliseconds: 600),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
