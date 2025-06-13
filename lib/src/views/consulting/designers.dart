import 'package:aadaiz_customer_crm/src/res/components/common_toast.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/designer_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/widgets/common_app_bar.dart';

class Designers extends StatefulWidget {
  const Designers({super.key, this.id, this.designer});
  final dynamic id;
  final dynamic designer;
  @override
  State<Designers> createState() => _DesignersState();
}

class _DesignersState extends State<Designers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      ConsultingController.to.getDesigners(widget.id, widget.designer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 5.5.hp),
        child: const CommonAppBar(title: 'Designers'),
      ),
      body: Obx(
        () =>
            ConsultingController.to.designerLoading.value
                ? const CommonLoading()
                : ConsultingController.to.designerList.isEmpty
                ? const CommonEmpty(title: 'Designers')
                : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.1,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03,
                    horizontal: screenWidth * 0.022,
                  ),
                  itemCount: ConsultingController.to.designerList.length,
                  itemBuilder: (_, int index) {
                    var data = ConsultingController.to.designerList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                                DesignerDetail(data: data),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth / 3.3,
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.016,
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: screenHeight * 0.1,
                              child: Stack(
                                children: [
                                  data.profileImage != null
                                      ? ClipOval(
                                        child: CachedNetworkImage(
                                          height: screenHeight * 0.088,
                                          width: screenHeight * 0.088,
                                          fit: BoxFit.cover,
                                          errorWidget:
                                              (context, url, error) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColor.primary,
                                                    ),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: AppColor.white,
                                                      size:
                                                          screenHeight * 0.088,
                                                    ),
                                                  ),
                                          progressIndicatorBuilder:
                                              (
                                                context,
                                                url,
                                                progress,
                                              ) => Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                          imageUrl: (data.profileImage),
                                        ),
                                      )
                                      : Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.primary,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: AppColor.white,
                                          size: screenHeight * 0.088,
                                        ),
                                      ),
                                  const Positioned(
                                    top: 7,
                                    right: 7,
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: AppColor.circleDotColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${data.name ?? ''}".capitalizeFirst!,
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.00.sp,
                                color: AppColor.designerColor,
                              ),
                            ),
                            Text(
                              '${data.category ?? ''}',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.00.sp,
                                color: AppColor.designerRoleColor,
                              ),
                            ),
                            Text(
                              '⭐️ ${data.avgRate ?? 0} (${data.totalRate ?? 0} reviews)',
                              style: GoogleFonts.dmSans(
                                fontSize: 9.00.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.designerRoleColor,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
