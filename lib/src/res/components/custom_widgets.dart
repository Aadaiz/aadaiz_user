import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidgets{

  static Widget fullWidthTextField({
    required Widget label,
    required Widget child,
    double height = 100,
    bool isHeight = false,
  }){

    return Padding(
        padding: const EdgeInsets.only(
            top: 3
        ),
        child: Container(
            padding: const EdgeInsets.only(
                left: 8,
                right: 5
            ),
            height: isHeight ? 120 : height,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16
                          ),
                          child: label
                      )
                  ),
                  child
                ]
            )
        )
    );

  }
 static Widget shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.white),
    );
  }
}