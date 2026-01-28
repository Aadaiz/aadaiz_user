import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:aadaiz_customer_crm/src/res/components/comming_soon.dart';
import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/contact.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/home/model/productlist_model.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/order/select_sellers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../res/widgets/common_app_bar.dart';

class SelfCustomize extends StatefulWidget {
  const SelfCustomize({super.key, this.data});
  final PatternListDatum? data;
  @override
  State<SelfCustomize> createState() => _SelfCustomizeState();
}

class _SelfCustomizeState extends State<SelfCustomize> {
  String? selectedShirt;
  String? selectedPant;
  String? selectedSleeve;
  Color? selectedMaterial;
  Color? selectedTop;
  int selectedIndex = 0;
  int selectIndex = 0;
  String defaultSleeve = 'assets/self/db.png';
  String defaultTop = 'assets/self/dp.png';
  String defaultBottom = 'assets/self/ds.png';

  final List maxList = [
    {
      "name": "Material",
      "categories": [
        {"color": Colors.transparent, "name": "Half Sleeve"},
        {"color": Colors.blue, "name": "Half Sleeve"},
        {"color": Colors.green, "name": "Half Sleeve"},
        {"color": Colors.orange, "name": "Half Sleeve"},
      ],
    },
    {
      "name": "Skirt",
      "categories": [
        {"image": 'assets/self/b1.png', "name": "Knee"},
        {"image": 'assets/self/b2.png', "name": "Knee"},
        {"image": 'assets/self/b3.png', "name": "Knee"},
      ],
    },
    {
      "name": "Top",
      "categories": [
        {"image": 'assets/self/t1.png', "name": "Full Top"},
        {"image": 'assets/self/t2.png', "name": "Full Top"},
        {"image": 'assets/self/t3.png', "name": "Full Top"},
        {"image": 'assets/self/4.png', "name": "Full Top"},
        {"image": 'assets/self/11.png', "name": "Full Top"},
      ],
    },
    {
      "name": "Sleeve",
      "categories": [
        {"image": 'assets/self/s1.png', "name": "Half Sleeve"},
        {"image": 'assets/self/s2.png', "name": "Half Sleeve"},
        {"image": 'assets/self/s3.png', "name": "Half Sleeve"},
      ],
    },
  ];
  final GlobalKey _globalKey = GlobalKey();

  Future<void> captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
        return captureAndSavePng();
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/rendered_image.png';
      final imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      print('Saved image at: $filePath');
      await Get.to(() => SelectSellers(image: imgFile, data: widget.data));
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(100, 5.5.hp),
        child: CommonAppBar(
          title: 'Self Customize',
          isCheck: true,
          actionButton: CommonButton(
            width: 80.0,
            height: 40.0,
            borderRadius: 12.0,
            text: 'Finish',
            press: () async {
              await captureAndSavePng();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display selected shirt and pant with overlays
            Expanded(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: Get.width,
                              height: Get.height * 0.67,
                              //color: Colors.cyan,
                            ),
                            selectedMaterial != null
                                ? Positioned(
                                  top: 35,
                                  left: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height * 0.165,
                                    color: selectedMaterial,
                                  ),
                                )
                                : const SizedBox(),
                            selectedTop != null
                                ? Positioned(
                                  top: Get.height * 0.2,
                                  left: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height * 0.16,
                                    color: selectedTop,
                                  ),
                                )
                                : const SizedBox(),
                            selectedPant != null
                                ? Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    //  selectedPant != null ?
                                    selectedPant!,
                                    //:defaultBottom,
                                    height: 560,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Container(),
                            selectedSleeve != null
                                ? Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    // selectedSleeve != null ?
                                    selectedSleeve!,
                                    // :defaultSleeve,
                                    height: 560,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Container(),
                            selectedShirt != null
                                ? Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Image.asset(
                                    // selectedShirt != null ?
                                    selectedShirt!,
                                    // :defaultTop,
                                    height: 560,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: Get.height * 0.08,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: maxList[selectedIndex]['categories'].length,
                  itemBuilder: (context, index) {
                    var data = maxList[selectedIndex]['categories'][index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex = index;
                            switch (selectedIndex) {
                              case 0:
                                if (index == 0) {
                                } else if (index == 1) {
                                  selectedMaterial = data['color'];
                                } else {
                                  selectedTop = data['color'];
                                }
                              case 1:
                                selectedPant = data['image'];
                              case 2:
                                selectedShirt = data['image'];
                              case 3:
                                selectedSleeve = data['image'];
                              default:
                                selectedPant = data['image'];
                            }
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            switch (selectedIndex) {
                              case 0:
                                selectedMaterial = null;
                              case 1:
                                selectedPant = null;
                              case 2:
                                selectedShirt = null;
                              case 3:
                                selectedSleeve = null;
                              default:
                                selectedPant = null;
                            }
                          });
                        },
                        child:
                            selectedIndex != 0
                                ? Container(
                                  decoration: BoxDecoration(
                                    //   color: Colors.blue,
                                    border: Border.all(
                                      color:
                                          selectedIndex == index
                                              ? Colors.teal
                                              : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    data['image'],
                                    height: Get.height * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: data['color'],
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: maxList.length,
                  itemBuilder: (context, index) {
                    var data = maxList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                selectedIndex == index
                                    ? Colors.teal.shade400
                                    : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                data['name'],
                                style: TextStyle(
                                  color:
                                      selectedIndex == index
                                          ? Colors.white
                                          : Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
