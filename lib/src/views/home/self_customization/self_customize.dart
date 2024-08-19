import 'package:aadaiz/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/widgets/common_app_bar.dart';

class SelfCustomize extends StatefulWidget {
  const SelfCustomize({super.key});

  @override
  State<SelfCustomize> createState() => _SelfCustomizeState();
}

class _SelfCustomizeState extends State<SelfCustomize> {
  String? selectedShirt;
  String? selectedPant;
  String? selectedSleeve;
  Color? selectedMaterial;
  int selectedIndex = 0;
  String defaultSleeve = 'assets/self/db.png';
  String defaultTop = 'assets/self/dp.png';
  String defaultBottom = 'assets/self/ds.png';

  final List maxList = [
    {
      "name": "Material",
      "categories": [
        {
          "color": Colors.transparent,
          "name": "Half Sleeve",
        },
        {
          "color": Colors.blue,
          "name": "Half Sleeve",
        },
        {
          "color": Colors.green,
          "name": "Half Sleeve",
        },
        {
          "color": Colors.orange,
          "name": "Half Sleeve",
        },
      ]
    },
    {
      "name": "Skirt",
      "categories": [
        {
          "image": 'assets/self/b1.png',
          "name": "Knee",
        },
        {
          "image": 'assets/self/b2.png',
          "name": "Knee",
        },
        {
          "image": 'assets/self/b3.png',
          "name": "Knee",
        },
      ]
    },
    {
      "name": "Top",
      "categories": [
        {
          "image": 'assets/self/t1.png',
          "name": "Full Top",
        },
        {
          "image": 'assets/self/t2.png',
          "name": "Full Top",
        },
        {
          "image": 'assets/self/t3.png',
          "name": "Full Top",
        },
      ]
    },
    {
      "name": "Sleeve",
      "categories": [
        {
          "image": 'assets/self/s1.png',
          "name": "Half Sleeve",
        },
        {
          "image": 'assets/self/s2.png',
          "name": "Half Sleeve",
        },
        {
          "image": 'assets/self/s3.png',
          "name": "Half Sleeve",
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(
      //     100,
      //     8.0.hp,
      //   ),
      //   child: const CommonAppBar(
      //     title: 'Coupon',
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // Display selected shirt and pant with overlays
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.height * 0.75,
                            // decoration: const BoxDecoration(
                            //     //color: Colors.red,
                            //     image: DecorationImage(
                            //         image: ExactAssetImage(
                            //   'assets/self/croquis.png',
                            // ))),
                          ),
                          selectedMaterial != null
                              ? Positioned(
                                  top: 35,
                                  left: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: Get.height * 0.75,
                                    color: selectedMaterial,
                                  ),
                                )
                              : const SizedBox(),
                          selectedPant != null ?
                           Positioned(
                                  top: 35,
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
                        :  Container(),
                          selectedShirt != null ?
                           Positioned(
                                  top: 35,
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
                          selectedSleeve != null ?
                          Positioned(
                                  top: 34.5,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: 50,
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
                            switch (selectedIndex) {
                              case 0:
                                selectedMaterial = data['color'];
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
                        child: selectedIndex != 0
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      data['image'],
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )),
                              )
                            : Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: data['color'],
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
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
                              color: selectedIndex == index
                                  ? Colors.teal.shade400
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                data['name'],
                                style: TextStyle(
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: 15),
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
