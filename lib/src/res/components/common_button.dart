import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.text,
      this.loading = false,
      this.width,
      this.height,
      required this.press,
      this.borderRadius = 8.0,
      this.isBorder = false});
  final dynamic text;
  final dynamic loading;
  final dynamic width;
  final dynamic height;
  final VoidCallback press;
  final dynamic borderRadius;
  final isBorder;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !loading ? press : null,
      child: isBorder
          ? Container(
              height: height?? Get.height * 0.07,
              width: width ?? Get.width,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(
                      color: AppColor.greyTitleColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Center(
                child: loading
                    ? SizedBox(
                        height: 03.00.hp,
                        width: 5.00.hp,
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: AppColor.primary,
                          size: 5.00.hp,
                        ),
                      )
                    : Text(text,
                        style: GoogleFonts.dmSans(
                            fontSize: 15,
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700)),
              ),
            )
          : Container(
              height:height?? Get.height * 0.07,
              width: width ?? Get.width,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Center(
                child: loading
                    ? SizedBox(
                        height: 03.00.hp,
                        width: 5.00.hp,
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: Colors.white,
                          size: 5.00.hp,
                        ),
                      )
                    : Text(text,
                        style: GoogleFonts.dmSans(
                            fontSize: 15,
                            color: AppColor.white,
                            fontWeight: FontWeight.w700)),
              ),
            ),
    );
  }
}
