import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

class CommonToast {
  static show({String? msg}){
    return Fluttertoast.showToast(
      msg: "$msg",
      webShowClose: true,
      textColor: Colors.black,
      backgroundColor: Colors.grey.shade400.withOpacity(0.5),
      timeInSecForIosWeb: 1,
      webBgColor: "linear-gradient(#334, #000)",
      webPosition: "center",// message
      toastLength: Toast.LENGTH_LONG, // length
      gravity: ToastGravity.BOTTOM, // location
    );
  }
}

class CommonEmpty extends StatelessWidget {
  const CommonEmpty({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.00.hp,
          width: Get.width * 0.8,
          child: Center(
            child: Text(
              "No $title found",
            ),
          ),
        ),
      ],
    );
  }
}

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.00.hp,
      width: Get.width * 0.8,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      )
    );
  }
}
class ShimmerBox extends StatelessWidget {

  final BorderRadiusGeometry? borderRadius;

  const ShimmerBox({
    super.key,

    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}


class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double horizontal;

  const ShimmerList({super.key, this.itemCount = 10,  this.horizontal=16});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return  Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: horizontal),
          child: ShimmerBox(),
        );
      },
    );
  }
}
