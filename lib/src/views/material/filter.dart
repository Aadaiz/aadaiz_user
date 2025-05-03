import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final List<String> _categories = [
    'Fabrics',
    'Colors',
    'Price Range',
    'Ratings'
  ];
  final List<dynamic> _items = [
    {
      'title': '',
      'data': [
        {'image': 'assets/images/cotton_satten.png', 'label': 'Cotton Satten'},
        {'image': 'assets/images/wool.png', 'label': 'Wool'},
        {'image': 'assets/images/polystar.png', 'label': 'Polystar'}
      ]
    },
    {
      'title': '',
      'data': [
        {'image': 'assets/images/cotton_satten.png', 'label': 'Dark Pink'},
        {'image': 'assets/images/wool.png', 'label': 'Beige'}
      ]
    },
    {'title': 'Price Range'},
    {'title': 'Rating'}
  ];
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
                child: Image.asset('assets/images/back.png')),
            title: Text('Filter',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black)),
            centerTitle: true,
            elevation: 2,
            shadowColor: AppColor.black,
            forceMaterialTransparency: false),
        body: Padding(
            padding: EdgeInsets.only(top: 3.0.hp),
            child: Row(children: [
              // Sidebar
              SizedBox(
                  width: Get.width * 0.3,
                  child: ListView.builder(
                      itemCount: _categories.length + 2,
                      itemBuilder: (context, index) {
                        return Container(
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                                color: _selectedCategory == index
                                    ? Colors.white
                                    : AppColor.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color:
                                            AppColor.black.withOpacity(0.05)))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedCategory = index;
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 8),
                                          child: Text(_categories[index],
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 12.00.sp,
                                                  color: AppColor.black,
                                                  fontWeight:
                                                      FontWeight.w400))))
                                ]));
                      })),
              // Main content
              Expanded(
                  child: Column(children: [
                Gap(2.0.hp),
                Expanded(
                    child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: _items[_selectedCategory]['data'].length,
                        itemBuilder: (context, index) {
                          final item = _items[_selectedCategory]['data'][index];

                          return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(2, 2),
                                        blurRadius: 20,
                                        color: AppColor.unSelectColor
                                            .withOpacity(0.1))
                                  ]),
                              child: Column(children: [
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage(item!['image']!),
                                                fit: BoxFit.fill)))),
                                const SizedBox(height: 8.0),
                                Text(item['label']!,
                                    style: GoogleFonts.dmSans(
                                        fontSize: 7.00.sp,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 8.0)
                              ]));
                        }))
              ]))
            ])),
        bottomNavigationBar: BottomAppBar(
            height: screenHeight * 0.1,
            color: Colors.white,
            child: Row(children: [
              Container(
                  width: screenWidth / 2.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderGrey)),
                  alignment: Alignment.center,
                  child: Text('Reset',
                      style: GoogleFonts.dmSans(
                          fontSize: 12.00.sp,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500))),
              const Spacer(),
              SizedBox(
                  width: screenWidth / 2.3,
                  child: CommonButton(
                      press: () {}, text: 'Apply', borderRadius: 0.0))
            ])));
  }
}
