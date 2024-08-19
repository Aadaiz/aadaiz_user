
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FabricWidget extends StatefulWidget {
  const FabricWidget({super.key});

  @override
  State<FabricWidget> createState() => _FabricWidgetState();
}

class _FabricWidgetState extends State<FabricWidget> {

List<dynamic> material= [
  {'image': 'assets/images/green_material.png', 'text': 'Green','width': 0.6},
  {'image': 'assets/images/green_material.png', 'text': 'blue','width': 0.35},
  {'image': 'assets/images/green_material.png', 'text': 'Yellow','width': 0.4},
  {'image': 'assets/images/green_material.png', 'text': 'Green','width': 0.5},
];
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: Get.width,
      child:Wrap(
        spacing: 8,
        runSpacing: 8,
        direction: Axis.horizontal,
        children: material.asMap().entries.map((entry) {
          int index = entry.key;
          var e = entry.value;
          return InkWell(
            onTap: () {
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    e['image'],
                    fit: BoxFit.fill,
                    height: 10.0.hp,
                    width: Get.width * e['width'],
                  ),
                ),
                index != material.length - 1
                    ? Positioned(
                  bottom: 8,
                  right: Get.width * e['width'] * 0.1,
                  child: Container(
                    width: Get.width * e['width'] * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          e['text'],
                          style: GoogleFonts.sacramento(
                            textStyle: TextStyle(
                              fontSize: 12.00.sp,
                              color:AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : Container(
                  height: 10.0.hp,
                  width: Get.width * e['width'],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/explore.png',
                        fit: BoxFit.fill,
                        height: 3.0.hp,
                      ),
                      const Gap(8),
                      Text('Explore All',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 12.00.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      )
    );
  }
}
