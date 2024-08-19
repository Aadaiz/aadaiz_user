import 'package:aadaiz/src/res/components/search_field.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/home/self_customization/order/product_customization.dart';
import 'package:aadaiz/src/views/material/filter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {

  int _listIndex = 0;
  final List _dataList = [
    {
      'image' : 'assets/images/material_blue.png',
      'color' : 'Blue'
    },
    {
      'image' : 'assets/images/material_green.png',
      'color' : 'Green'
    },
    {
      'image' : 'assets/images/material_purple.png',
      'color' : 'Rose'
    },
    {
      'image' : 'assets/images/material_rose.png',
      'color' : 'Maxui'
    }
  ];

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
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.016
                ),
                child: Image.asset(
                    'assets/images/back.png'
                )
            ),
            title: Text(
                'Material',
                style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black
                )
            ),
            centerTitle: true,
            elevation: 2,
            shadowColor: AppColor.black,
            forceMaterialTransparency: false
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4)
                    )
                  ]
                ),
                child: SearchField(
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  hinttext: 'Search By Keyword'
                )
              ),
              SizedBox(
                  height: screenHeight * 0.045
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){

                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Filter()
                          )
                      );

                    },
                    child: sortWidget(
                      title: 'Filters',
                      image: 'assets/images/sort.png'
                    ),
                  ),
                  sortWidget(
                    title: 'Price: lowest to high',
                    image: 'assets/images/l_h.png'
                  ),
                  SizedBox(
                    width: 5.0.wp,
                    child: _listIndex ==0?
                    InkWell(
                      onTap: (){
        
                        setState(() {
        
                          _listIndex=1;
        
                        });
        
                      },
                      child: Image.asset(
                        'assets/images/list.png',
                        fit: BoxFit.contain,
                        height: 2.5.hp,
                        width: 1.8.wp
                      )
                    ):
                    InkWell(
                      onTap: (){
        
                        setState(() {
        
                          _listIndex=0;
        
                        });
        
                      },
                      child: Image.asset(
                        'assets/images/grid.png',
                        fit: BoxFit.fill,
                        width: 5.0.wp
                      )
                    )
                  )
                ]
              ),
              GridView.builder(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.8
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.03
                  ),
                  itemCount: _dataList.length,
                  itemBuilder: (_, int index){
        
                    return Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth * 0.016
                        ),
                        child: InkWell(
                          onTap: (){

                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => const ProductDetails(rating: 3.0,)
                                )
                            );

                          },
                          child: SizedBox(
                              width: screenWidth / 2.2,
                              child: Column(
                                  children: [
                                    SizedBox(
                                      height: screenHeight * 0.26,
                                      child: Stack(
                                          children: [
                                            SizedBox(
                                              child: Image.asset(
                                                _dataList[index]['image'],
                                                fit: BoxFit.cover
                                              )
                                            ),
                                            Positioned(
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        shape: BoxShape.circle
                                                    ),
                                                    padding: const EdgeInsets.all(6),
                                                    child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 8,
                                                        child: Icon(
                                                          Icons.favorite_border,
                                                          size: 2.0.hp
                                                        )
                                                    )
                                                )
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColor.black,
                                                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(
                                                                color: AppColor.white,
                                                                width: 3
                                                            )
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 8
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                                '₹145',
                                                                style: GoogleFonts.dmSans(
                                                                    textStyle: TextStyle(
                                                                        fontSize: 10.00.sp,
                                                                        color: AppColor.white,
                                                                        fontWeight: FontWeight.w500
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                          ]
                                      ),
                                    ),
                                    ListTile(
                                        title: Text(
                                            _dataList[index]['color'],
                                            style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.00.sp,
                                                color: AppColor.black
                                            )
                                        ),
                                        subtitle: Text(
                                            'Fabric',
                                            style: GoogleFonts.dmSans(
                                                fontSize: 10.00.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.subTitleColor
                                            )
                                        )
                                    ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                              children: List.generate(5, (index){

                                                return Icon(
                                                    Icons.star,
                                                    color: AppColor.starColor,
                                                    size: screenHeight * 0.016
                                                );

                                              })
                                          ),
                                          SizedBox(
                                              width: screenWidth * 0.01
                                          ),
                                          Text(
                                              'View Review',
                                              style: GoogleFonts.dmSans(
                                                  fontSize: 9.00.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColor.black,
                                                  decoration: TextDecoration.underline
                                              )
                                          )
                                        ]
                                    )
                                  ]
                              )
                          )
                        )
                    );
        
                  }
              )
            ]
          )
        )
      )
    );

  }

  Widget sortWidget({image, title}){

    return Row(
      children: [
        Image.asset(
          image,
          fit: BoxFit.fill,
          width: 5.0.wp
        ),
        const Gap(8),
        Text(
          title,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
              color: AppColor.textColor,
              fontSize: 9.0.sp,
              fontWeight: FontWeight.w400
            )
          )
        )
      ]
    );

  }

}