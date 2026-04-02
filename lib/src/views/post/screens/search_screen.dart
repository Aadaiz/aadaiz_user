import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_view_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SearchImageScreen extends StatefulWidget {
  const SearchImageScreen({super.key});

  @override
  State<SearchImageScreen> createState() => _SearchImageScreenState();
}

class _SearchImageScreenState extends State<SearchImageScreen> {
  final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: ''),
      ),
      body: Obx(() {
        if (controller.searchLoading.value) {
          return Center(
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

        if (controller.searchData.isEmpty) {
          return const Center(child: Text("No Data"));
        }

        return Padding(
          padding: const EdgeInsets.all(4),
          child: StaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(controller.searchData.length, (index) {
              final item = controller.searchData[index];

              return StaggeredGridTile.count(
                crossAxisCellCount: _getCrossAxisCount(index),
                mainAxisCellCount: _getMainAxisCount(index),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => PostViewDetailScreen(id: item['id']),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: item['post_image'] ?? '',
                      fit: BoxFit.cover,
                      placeholder:
                          (_, __) => Container(color: Colors.grey[200]),
                      errorWidget: (_, __, ___) => const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  int _getCrossAxisCount(int index) {
    int patternIndex = index % 9;

    if (patternIndex == 0) return 2;

    return 1;
  }

  int _getMainAxisCount(int index) {
    int patternIndex = index % 9;

    if (patternIndex == 0) return 2;

    if (patternIndex == 1 || patternIndex == 2) return 1;

    return 1;
  }
}
