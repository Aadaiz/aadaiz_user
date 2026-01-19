import 'package:aadaiz_customer_crm/src/res/components/search_field.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/home/offer_banner_widget.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/product/search_screen.dart';
import 'package:aadaiz_customer_crm/src/views/home/self_customization/self_customization_home_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/user_notification.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/home_controller.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({super.key});

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  //
  List categoryList = [
    {'image': 'assets/images/women.png', 'text': 'Women'},
    {'image': 'assets/images/men.png', 'text': 'Men'},
    {'image': 'assets/images/girl.png', 'text': 'Girls'},
    {'image': 'assets/images/boy.png', 'text': 'Boys'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:
         Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SvgPicture.asset(
                //   'assets/aadaiz_home.svg',
                //   width: 100,
                //   height: 50,
                // ),
                Image.asset(
                  'assets/dashboard/aadai.png',
                  fit:BoxFit.fill,
                  //  height: 10.0.hp,
                  width: 25.0.wp,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => const UserNotification());
                      },
                      child: Image.asset(
                        'assets/images/notification.png',
                        fit:BoxFit.fill,
                        //  height: 10.0.hp,
                        width: 5.0.wp,
                      ),
                    ),
                    // Gap(5.0.wp),
                    // Image.asset(
                    //   'assets/images/message.png',
                    //   fit:BoxFit.fill,
                    //   //  height: 10.0.hp,
                    //   width: 5.0.wp,
                    // ),
                  ],
                ),
              ],
            ),
            const Gap(32),
            // SearchField(
            //   controllers: HomeController.to.search,
            //   onChanged: (value) {
            //     Future.delayed(const Duration(milliseconds: 100), () {
            //       HomeController.to.search.text = value;
            //     });
            //   },
            //   onSubmitted: (value) async {
            //      HomeController.to.search.text = value;
            //     await HomeController.to
            //         .getProductList(isRefresh:true)
            //         .then((value)=>Get.to(()=> const SearchScreen()));
            //   },
            //   hinttext: 'Search By Keyword' ,
            // ),
            // const Gap(32),
            const OfferBannerWidget(),
            const Gap(32),
//             Row(
//               children: [
//                 Text('Category',
//                   style: GoogleFonts.inter(
//                       textStyle: TextStyle(
//                           fontSize: 14.00.sp,
//                           color:AppColor.primary,
//                           fontWeight: FontWeight.w400)),),
//               ],
//             ),
//             const Gap(24),
//             SizedBox(
//               height: 5.0.hp,
//               width: Get.width,
//               child:
// //               HomeController.to.genderLoading.value?
// //                   const Text('loading'):
// //               HomeController.to.genderList.value.isEmpty ?
// //                   const Text('gender empty')
// //
// // :
//               ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: categoryList.length,
//                   itemBuilder: (context, index){
//                     var data = categoryList[index];
//                     return   InkWell(
//                       onTap: (){
//                         // Get.to(()=>  SelfCustomizationHomeScreen(catIndex: index,id: data.id));
//                         Get.to(()=>  const SelfCustomizationHomeScreen(catIndex: 0,id:0));
//                       },
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 16, // Image radius
//                             backgroundImage: AssetImage(
//                                 data['image']),
//                           ),
//                           Gap(2.0.wp),
//                           Text(data['text'],
//                             style: GoogleFonts.inter(
//                                 textStyle: TextStyle(
//                                     fontSize: 11.00.sp,
//                                     color:AppColor.black,
//                                     fontWeight: FontWeight.w400)),),
//                           Gap(5.0.wp),
//                         ],
//                       ),
//                     ) ;
//                   }),
//             ),
          ],
        ),
      
    );
  }
}
