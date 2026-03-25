import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/add_comment_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class PostCard extends StatefulWidget {
  final Datum post;
  final Function()? onTap;

  const PostCard({super.key, required this.post,this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PostController postController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              spacing: 8,
              children: [
                ClipRRect(
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
                    imageUrl: widget.post.user!.profileImage ?? '',
                  ),
                ),
                Text(
                  widget.post.user!.username ?? '',
                  style: GoogleFonts.dmSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onDoubleTap: () {
              postController.likePost(widget.post);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: screenHeight * 0.4,
                fit: BoxFit.cover,
                width: screenWidth,
                imageUrl: widget.post.postImage ?? '',
                errorWidget:
                    (context, url, error) =>
                        Container(width: screenWidth, color: Colors.black),
                progressIndicatorBuilder:
                    (context, url, progress) => Container(
                      height: screenHeight * 0.4,
                      color: Colors.black,
                      width: screenWidth,
                      child: Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                            strokeWidth: 2,
                            value: progress.progress,
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15,
              children: [
                InkWell(
                  onTap: () {
                    postController.likePost(widget.post);
                  },
                  child: Icon(
                    (widget.post.isLiked ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                        (widget.post.isLiked ?? false)
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
                InkWell(
                  onTap: widget.onTap,

                  child: Row(
                    spacing: 3,
                    children: [
                      Image.asset('assets/images/post_comment.png', width: 18),
                      if (widget.post.commentsCount != 0)
                        Text(
                          widget.post.commentsCount.toString(),
                          style: GoogleFonts.dmSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
                Image.asset('assets/images/post_send.png', width: 19),
                Image.asset('assets/images/post_save.png', width: 16),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.01),
          if ((widget.post.likesCount ?? 0) != 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                widget.post.likesCount == 1
                    ? '${widget.post.likesCount} like'
                    : '${widget.post.likesCount} likes',
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          SizedBox(height: screenHeight * 0.01),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ReadMoreText(
              widget.post.caption ?? '',
              trimMode: TrimMode.Line,
              colorClickableText: Colors.black,
              style: GoogleFonts.dmSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              annotations: [
                Annotation(
                  regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                  spanBuilder:
                      ({required String text, TextStyle? textStyle}) =>
                          TextSpan(
                            text: text,
                            style: textStyle?.copyWith(color: Colors.blue),
                          ),
                ),

                Annotation(
                  regExp: RegExp(r'<@(\d+)>'),
                  spanBuilder:
                      ({required String text, TextStyle? textStyle}) =>
                          TextSpan(
                            text: 'User123',
                            style: textStyle?.copyWith(color: Colors.green),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                ),
              ],
              moreStyle: GoogleFonts.dmSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.01),
          if (widget.post.commentsCount != 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(
                'View all ${widget.post.commentsCount} comments',
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ),

          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }
}
