import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

class CommonToast {
  static show({String? msg}) {
    return Fluttertoast.showToast(
      msg: "$msg",
      webShowClose: true,
      textColor: Colors.black,
      backgroundColor: Colors.grey.shade400.withOpacity(0.5),
      timeInSecForIosWeb: 1,
      webBgColor: "linear-gradient(#334, #000)",
      webPosition: "center", // message
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
          child: Center(child: Text("No $title found")),
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
        child: Container(decoration: const BoxDecoration(color: Colors.white)),
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;

  const ShimmerBox({super.key, this.borderRadius});

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

  const ShimmerList({super.key, this.itemCount = 10, this.horizontal = 16});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: horizontal),
          child: ShimmerBox(),
        );
      },
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          _circleShimmer(100),
          const SizedBox(height: 16),

          _rectShimmer(width: 120, height: 16),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(child: _cardShimmer()),
              const SizedBox(width: 12),
              Expanded(child: _cardShimmer()),
            ],
          ),
          const SizedBox(height: 12),

          _cardShimmer(),
          const SizedBox(height: 24),

          _listTileShimmer(),
          const SizedBox(height: 16),

          _textRowShimmer(),
          const SizedBox(height: 12),

          _textRowShimmer(),
        ],
      );

  }

  Widget _circleShimmer(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _rectShimmer({double width = double.infinity, double height = 14}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget _cardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _listTileShimmer() {
    return Row(
      children: [
        _circleShimmer(32),
        const SizedBox(width: 12),
        Expanded(child: _rectShimmer(height: 14)),
        const SizedBox(width: 12),
        _rectShimmer(width: 16, height: 16),
      ],
    );
  }

  Widget _textRowShimmer() {
    return Align(
      alignment: Alignment.centerLeft,
      child: _rectShimmer(width: 140, height: 14),
    );
  }
}
