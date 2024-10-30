import 'package:aadaiz/src/res/components/common_toast.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/order/checkout.dart';
import 'package:aadaiz/src/views/order/new_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/widgets/common_app_bar.dart';
import '../home/controller/home_controller.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({super.key});

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      await HomeController.to.getAddressList();
    });
  }
  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.addressBgColor,
      appBar: PreferredSize(
        preferredSize: Size(
          100,
          8.0.hp,
        ),
        child: const CommonAppBar(
          title: 'Shipping Addresses',
        ),
      ),
      body: Obx(()=>
      HomeController.to.addressListLoading.value?
          const CommonLoading():
      HomeController.to.addressList.value.isEmpty?
          const CommonEmpty(title: 'Address'):
         ListView.builder(
          itemCount: HomeController.to.addressList.value.length,
            itemBuilder: (context, index){
        var data =HomeController.to.addressList.value[index];
              return InkWell(
                onTap: (){

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>  Checkout(data: data,)
                      )
                  );

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.045,
                      vertical: screenHeight * 0.022
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.03
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.name??"",
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.00.sp,
                                  color: AppColor.textColor
                              )
                          ),
                          InkWell(
                            onTap: (){

                              // Navigator.push(context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>  NewAddress(data:data,isEdit:true)
                              //     )
                              // );
                            },
                            child: Text(
                                'Edit',
                                style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.00.sp,
                                    color: AppColor.blueColor
                                )
                            ),
                          )
                        ]
                      ),
                      SizedBox(
                        height: screenHeight * 0.01
                      ),
                      Text(data.address??'',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.00.sp,
                              color: AppColor.textColor
                          )
                      ),
                      Text(data.state??'',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.00.sp,
                              color: AppColor.textColor
                          )
                      ),
                      SizedBox(
                          height: screenHeight * 0.018
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Checkbox(
                              //checkColor: appcolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                    width: 1, color: Color(0xffBCB5B5)),
                              ),
                              activeColor:  AppColor.requiredTextColor,
                              value: HomeController.to.isDefaultList[index],
                              onChanged: (bool? value) {
                                setState(() {
                                  HomeController.to.isDefaultList[index] = value!;
                                });
                              },
                            ),
                          ),
                          // index == 0 ?
                          // const Icon(
                          //   Icons.check_box,
                          //   color: AppColor.requiredTextColor
                          // ) :
                          // Icon(
                          //   Icons.check_box_outline_blank,
                          //   color: AppColor.borderGrey
                          // ),
                          SizedBox(
                              width: screenWidth * 0.022
                          ),
                          Text(
                              'Use as the shipping address',
                              style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.00.sp,
                                  color: AppColor.textColor
                              )
                          )
                        ]
                      )
                    ]
                  )
                ),
              );

            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        // shape: Border,
        backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          onPressed: (){

            //Navigator.push(context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => const NewAddress()
            //     )
            // );

          },
        child: SvgPicture.asset(
          'assets/svg/add_floating.svg',
          height: screenHeight * 0.1
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat
    );

  }

}