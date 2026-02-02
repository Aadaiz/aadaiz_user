import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImageWrapper extends StatelessWidget {
  final Widget child;

  final ImageProvider imageProvider;

  const ZoomableImageWrapper({
    super.key,
    required this.child,
    required this.imageProvider,
  });

  void _openPhotoView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(backgroundColor: AppColors.blackColor),
          body: Center(
            child: PhotoView(
              imageProvider: imageProvider,
              backgroundDecoration: const BoxDecoration(
                color: AppColors.blackColor,
              ),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => _openPhotoView(context), child: child);
  }
}