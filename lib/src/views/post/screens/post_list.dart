import 'dart:math' as math;

import 'package:aadaiz_customer_crm/src/res/components/event_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/jobs_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/post_card.dart';
import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/Event/controller/event_controller.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/create_event_screen.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_filter.dart';
import 'package:aadaiz_customer_crm/src/views/Event/screens/event_view_screen.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/create_jobs.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/job_detail_screen.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/screens/job_filter.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_model.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final List<PostModel> postList = [
    PostModel(
      name: "Veronica",
      profileImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7nstASo8BdadWs3X-ji8e1O0hd5AMByZdGQ&s",
      postImage: "https://sadgirldp.com/wp-content/uploads/Cute-Girl-Pic-for-Instagram.jpeg",
      description: '"Sunday brunch fit ☕️✨ Loving this comfy aesthetic. #OOTD #SundayVibes"',
      likesText: "Liked by Josh and 905,235 others",
      commentsCount: "234",
    ),
    PostModel(
      name: "Sophia",
      profileImage: "https://randomuser.me/api/portraits/women/44.jpg",
      postImage: "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
      description: '"Beach vibes 🌊☀️ #Travel #Relax"',
      likesText: "Liked by Alex and 10,235 others",
      commentsCount: "120",
    ),
    PostModel(
      name: "Emma",
      profileImage: "https://randomuser.me/api/portraits/women/65.jpg",
      postImage: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
      description: '"Coffee time ☕ #ChillLife"',
      likesText: "Liked by John and 5,235 others",
      commentsCount: "89",
    ),
  ];
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        itemCount: postList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: [
                headerWidget(),
                SizedBox(height: screenHeight * 0.02),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PostCard(post: postList[index - 1]),
          );
        },
      ),

    );
  }
  Widget headerWidget(){
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        InkWell(
          onTap: (){
            Get.to(()=>const ProfileScreen(),transition: Transition.rightToLeft);

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
              imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7nstASo8BdadWs3X-ji8e1O0hd5AMByZdGQ&s',
            ),
          ),
        ),

        const Expanded(
          child: SearchField(hintText: "Search Jobs", showSuffix: true),
        ),
        Column(
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
      ],
    );

  }
}
