import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/custom_text_field.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/home/controller/home_controller.dart';
import 'package:aadaiz_customer_crm/src/views/order/saved_address.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_state_city/country_state_city.dart' as csc;

import '../home/model/add_address_model.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key, this.data, this.isEdit = false});
  final Address? data;
  final dynamic isEdit;
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  bool value = false;
  List<csc.Country> countries = [];
  List<csc.State> states = [];
  List<csc.City> cities = [];
  String countryCode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () async {
      countries = await csc.getAllCountries();
    });
    if (widget.isEdit) {
      HomeController.to.name.text = widget.data!.name ?? '';
      HomeController.to.mobile.text = widget.data!.mobile.toString() ?? '';
      HomeController.to.landmark.text = widget.data!.landmark ?? '';
      HomeController.to.city.text = widget.data!.city ?? '';
      HomeController.to.state.text = widget.data!.state ?? '';
      HomeController.to.zipCode.text = widget.data!.pincode.toString() ?? '';
      HomeController.to.country.text = widget.data!.country ?? '';
      HomeController.to.addressController.text = widget.data!.address ?? '';
      value = widget.data!.isDefault == 1 ? true : false;
    } else {
      HomeController.to.name.text = '';
      HomeController.to.mobile.text = '';
      HomeController.to.landmark.text = '';
      HomeController.to.city.text = '';
      HomeController.to.state.text = '';
      HomeController.to.zipCode.text = '';
      HomeController.to.country.text = '';
      HomeController.to.addressController.text = '';
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
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
            child: Image.asset('assets/images/back.png'),
          ),
        ),
        title: Text(
          'Adding Shipping Address',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 14.00.sp,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColor.black,
        forceMaterialTransparency: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.03,
          ),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Full name',
                controller: HomeController.to.name,
              ),

              SizedBox(height: screenHeight * 0.022),
              CustomTextField(
                hintText: 'Mobile Number',
                controller: HomeController.to.mobile,
              ),
              SizedBox(height: screenHeight * 0.022),
              CustomTextField(
                hintText: 'Address',
                controller: HomeController.to.addressController,
              ),
              SizedBox(height: screenHeight * 0.022),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 16,
                        child: SizedBox(
                          height: Get.width * 0.85,
                          width: Get.width * 0.6,
                          child: Column(
                            children: [
                              Text(
                                'Country',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.greyTitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                height: Get.width * 0.68,
                                child:
                                    countries.isEmpty
                                        ? const Text('No countries found')
                                        : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: countries.length,
                                          itemBuilder: (context, index) {
                                            var data = countries[index];
                                            return InkWell(
                                              onTap: () async {
                                                Get.back();
                                                HomeController.to.country.text =
                                                    data.name ?? '';
                                                countryCode = data.isoCode;
                                                states = await csc
                                                    .getStatesOfCountry(
                                                      data.isoCode,
                                                    );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  bottom: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${data.name}',
                                                        style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child:   CustomTextField(
                  enabled: false,
                  hintText: 'Country',
                  controller: HomeController.to.country,
                ),
              ),
              SizedBox(height: screenHeight * 0.022),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 16,
                        child: SizedBox(
                          height: Get.width * 0.85,
                          width: Get.width * 0.6,
                          child: Column(
                            children: [
                              Text(
                                'States',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.greyTitleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(16),
                              SizedBox(
                                height: Get.width * 0.68,
                                child:
                                    states.isEmpty
                                        ? const Text('No cities found')
                                        : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: states.length,
                                          itemBuilder: (context, index) {
                                            var data = states[index];
                                            return InkWell(
                                              onTap: () async {
                                                Get.back();
                                                HomeController.to.state.text =
                                                    data.name ?? '';
                                                cities = await csc
                                                    .getStateCities(
                                                      countryCode,
                                                      data.isoCode,
                                                    );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                  bottom: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${data.name}',
                                                        style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child:   CustomTextField(
                  enabled: false,
                  hintText: 'State/Province/Region',
                  controller: HomeController.to.state,
                ),
              ),
              SizedBox(height: screenHeight * 0.022),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 16,
                            child: SizedBox(
                              height: Get.width * 0.85,
                              width: Get.width * 0.6,
                              child: Column(
                                children: [
                                  Text(
                                    'States',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: AppColor.greyTitleColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const Gap(16),
                                  SizedBox(
                                    height: Get.width * 0.68,
                                    child:
                                        cities.isEmpty
                                            ? const Text('No cities found')
                                            : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemCount: cities.length,
                                              itemBuilder: (context, index) {
                                                var data = cities[index];
                                                return InkWell(
                                                  onTap: () async {
                                                    Get.back();
                                                    HomeController
                                                        .to
                                                        .city
                                                        .text = data.name ?? '';
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          left: 16,
                                                          bottom: 8,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${data.name}',
                                                            style: GoogleFonts.poppins(
                                                              textStyle: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    AppColor
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child:   CustomTextField(
                      enabled: false,
                      width: (screenWidth / 2) - screenHeight * 0.033,
                      hintText: 'City',
                      controller: HomeController.to.city,
                    ),
                  ),
                  CustomTextField(
                    width: (screenWidth / 2) - screenHeight * 0.033,
                    hintText: 'Landmark',
                    controller: HomeController.to.landmark,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.022),
              CustomTextField(
                hintText: 'Zip Code (Postal Code)',
                controller: HomeController.to.zipCode,
              ),

              SizedBox(height: screenHeight * 0.044),
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
                          width: 1,
                          color: Color(0xffBCB5B5),
                        ),
                      ),
                      activeColor: AppColor.requiredTextColor,
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value = value!;
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
                  SizedBox(width: screenWidth * 0.022),
                  Text(
                    'Use as the shipping address',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 13.00.sp,
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),

              // Container(
              //     color: Colors.white,
              //     alignment: Alignment.center,
              //     height: screenHeight * 0.08,
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
              SizedBox(height: screenHeight * 0.022),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: screenWidth / 1.2,
            height: 50,
            child: CommonButton(
              borderRadius: 0.0,
              press: () {
                if (widget.isEdit) {
                  HomeController.to.address(
                    'update',
                    addressId: widget.data!.id,
                    isDefault: value ? 1 : 0,
                  );
                } else {
                  HomeController.to.address('create', isDefault: value ? 1 : 0);
                }
              },
              text: 'SAVE ADDRESS',
              loading: HomeController.to.addressLoading.value,
              width: screenWidth / 1.2,
              height: screenHeight * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
