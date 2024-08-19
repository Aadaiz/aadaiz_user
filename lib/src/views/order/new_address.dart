import 'package:aadaiz/src/res/components/common_button.dart';
import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:aadaiz/src/views/home/controller/home_controller.dart';
import 'package:aadaiz/src/views/order/saved_address.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_state_city/country_state_city.dart';

import '../home/model/add_address_model.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key,  this.data, this.isEdit=false});
final Address? data;
final dynamic isEdit;
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {

  bool value = false;
  List countries = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
       countries = await getAllCountries();
    });
    if(widget.isEdit){
      HomeController.to.name.text = widget.data!.name??'';
      HomeController.to.mobile.text = widget.data!.mobile.toString()??'';
      HomeController.to.landmark.text = widget.data!.landmark??'';
      HomeController.to.city.text = widget.data!.city??'';
      HomeController.to.state.text = widget.data!.state??'';
      HomeController.to.zipCode.text = widget.data!.pincode.toString()??'';
      HomeController.to.country.text = widget.data!.country??'';
      HomeController.to.addressController.text = widget.data!.address??'';
      value=widget.data!.isDefault==1?true:false;
    }else{
      HomeController.to.name.text ='';
      HomeController.to.mobile.text ='';
      HomeController.to.landmark.text ='';
      HomeController.to.city.text ='';
      HomeController.to.state.text ='';
      HomeController.to.zipCode.text ='';
      HomeController.to.country.text ='';
      HomeController.to.addressController.text ='';
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.addressBgColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.016
                ),
                child: Image.asset(
                    'assets/images/back.png'
                )
            ),
          ),
          title: Text(
              'Adding Shipping Address',
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
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03
          ),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                height: screenHeight * 0.1,
                child: TextFormField(
                  controller: HomeController.to.name,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Full name',
                    hintStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.00.sp,
                        color: AppColor.borderGrey
                    ),
                    label: const Text(
                      'Full name'
                    ),
                    labelStyle: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.00.sp,
                      color: AppColor.borderGrey
                    ),
                    border: InputBorder.none
                  )
                )
              ),
              SizedBox(
                height: screenHeight * 0.022
              ),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                height: screenHeight * 0.1,
                child: TextFormField(
                    controller: HomeController.to.mobile,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Mobile Number',
                      hintStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.borderGrey
                      ),
                      label: const Text(
                          'Mobile Number'
                      ),
                      labelStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.borderGrey
                      ),
                      border: InputBorder.none
                    )
                )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                height: screenHeight * 0.1,
                child: TextFormField(
                    controller: HomeController.to.landmark,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Landmark',
                      hintStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.borderGrey
                      ),
                      label: const Text(
                          'Landmark'
                      ),
                      labelStyle: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.00.sp,
                          color: AppColor.borderGrey
                      ),
                      border: InputBorder.none
                    )
                ),
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      height: screenHeight * 0.1,
                      width: (screenWidth / 2) - screenHeight * 0.033,
                      child: TextFormField(
                          controller: HomeController.to.city,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'City',
                              hintStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.00.sp,
                                  color: AppColor.borderGrey
                              ),
                              label: const Text(
                                  'City'
                              ),
                              labelStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.00.sp,
                                  color: AppColor.borderGrey
                              ),
                              border: InputBorder.none
                          )
                      )
                  ),
                  Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: screenHeight * 0.1,
                    width: (screenWidth / 2) - screenHeight * 0.033,
                    child: TextFormField(
                        controller: HomeController.to.addressController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Address',
                            hintStyle: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.borderGrey
                            ),
                            label: const Text(
                                'Address'
                            ),
                            labelStyle: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.00.sp,
                                color: AppColor.borderGrey
                            ),
                            border: InputBorder.none
                        )
                    )
                  )
                ]
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: screenHeight * 0.1,
                  child: TextFormField(
                      controller: HomeController.to.state,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'State/Province/Region',
                          hintStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          label: const Text(
                              'State/Province/Region'
                          ),
                          labelStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          border: InputBorder.none
                      )
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: screenHeight * 0.1,
                  child: TextFormField(
                      controller: HomeController.to.zipCode,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Zip Code (Postal Code)',
                          hintStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          label: const Text(
                              'Zip Code (Postal Code)'
                          ),
                          labelStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          border: InputBorder.none
                      )
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
            InkWell(
              onTap: ()  {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20)),
                        elevation: 16,
                        child:  SizedBox(
                          height: Get.width*0.85,
                          width: Get.width*0.6 ,
                          child: Column(
                            children: [
                              Text('Country',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.greyTitleColor,
                                          fontWeight: FontWeight.w500))),
                              const Gap(16),
                              SizedBox(
                                height: Get.width*0.68,
                                child: countries.isEmpty?
                                const Text('No countries found'):
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount: countries.length,
                                    itemBuilder: (context, index) {
                                      var data = countries[index];
                                      return InkWell(
                                        onTap: ()async{
                                          Get.back();
                                          HomeController.to.country.text = data.name??'';
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 16,bottom: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text('${data.name}',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColor.black,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ));
                  },
                );
              },
              child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: screenHeight * 0.1,
                  child: TextFormField(
                    enabled: false,
                      controller: HomeController.to.country,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Country',
                          hintStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          label: const Text(
                              'Country'
                          ),
                          labelStyle: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.00.sp,
                              color: AppColor.borderGrey
                          ),
                          border: InputBorder.none
                      )
                  )
              ),
            ),
              SizedBox(
                  height: screenHeight * 0.022
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
                        value: value,
                        onChanged: (bool? value) {
                          setState(() {
                            this.value= value!;
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
              ),

              // Container(
              //     color: Colors.white,
              //     alignment: Alignment.center,
              //     height: screenHeight * 0.1,
              //     child: DropdownButton<String>(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 20
              //         ),
              //         borderRadius: BorderRadius.circular(18),
              //         underline: const SizedBox(),
              //         value: _selectedCountry,
              //         isDense: true,
              //         isExpanded: true,
              //         style: GoogleFonts.dmSans(
              //             fontWeight: FontWeight.w400,
              //             fontSize: 12.00.sp,
              //             color: AppColor.black
              //         ),
              //         hint: Text(
              //             _selectedCountry,
              //           style: GoogleFonts.dmSans(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 12.00.sp,
              //               color: AppColor.borderGrey
              //           )
              //         ),
              //         items: _countries.map<DropdownMenuItem<String>>((String val){
              //
              //           return DropdownMenuItem<String>(
              //               value: val,
              //               child: Text(
              //                   val
              //               )
              //           );
              //
              //         }).toList(),
              //       onChanged: (String? value) {
              //           setState(() {
              //             _selectedCountry=value!;
              //             HomeController.to.country.text=value!;
              //           });
              //       },
              //     )
              // ),
              SizedBox(
                  height: screenHeight * 0.022
              ),
              Obx(()=>
                SizedBox(
                    width: screenWidth / 1.2,
                    child: CommonButton(
                        press: (){
                          if(widget.isEdit){
                            HomeController.to.address('update',addressId: widget.data!.id,isDefault: value?1:0);
                          }else{
                            HomeController.to.address('create',isDefault: value?1:0);
                          }
                        },
                        text: 'SAVE ADDRESS',
                        loading: HomeController.to.addressLoading.value,
                        width: screenWidth / 1.2,
                        height: screenHeight * 0.7
                    )
                ),
              )
            ]
          )
        )
      )
    );

  }

}