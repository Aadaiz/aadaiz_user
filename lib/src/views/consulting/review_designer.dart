import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/book_designer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewDesigner extends StatefulWidget {
  const ReviewDesigner({super.key});

  @override
  State<ReviewDesigner> createState() => _ReviewDesignerState();
}

class _ReviewDesignerState extends State<ReviewDesigner> {

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
              'Review',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.045
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const BookDesigner()
                      )
                  );

                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.033
                  ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.033
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4)
                          )
                        ]
                    ),
                    child: Row(
                        children: [
                          SizedBox(
                              height: screenHeight * 0.1,
                              child: Stack(
                                  children: [
                                    SizedBox(
                                        child: Image.asset(
                                            'assets/images/consulting/designer_avatar.png',
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    const Positioned(
                                        top: 7,
                                        right: 7,
                                        child: CircleAvatar(
                                            radius: 7,
                                            backgroundColor: AppColor.circleDotColor
                                        )
                                    )
                                  ]
                              )
                          ),
                          SizedBox(
                              width: screenWidth * 0.05
                          ),
                          SizedBox(
                              height: screenHeight * 0.1,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Vijay',
                                        style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.00.sp,
                                            color: AppColor.designerColor
                                        )
                                    ),
                                    Text(
                                        'Designer',
                                        style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.00.sp,
                                            color: AppColor.designerRoleColor
                                        )
                                    ),
                                    Text(
                                        '⭐️ 4.5 (135 reviews)',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 9.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.designerRoleColor
                                        )
                                    )
                                  ]
                              )
                          )
                        ]
                    )
                )
              ),
              Text(
                  '135 reviews',
                  style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.00.sp,
                      color: AppColor.textColor
                  )
              ),
              SizedBox(
                  height: screenHeight * 0.033
              ),
              SizedBox(
                  width: screenWidth / 1.2,
                  child: Row(
                      children: [
                        Column(
                            children: [
                              Text(
                                  '4.3',
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 38.00.sp,
                                      color: AppColor.textColor
                                  )
                              ),
                              Text(
                                  '23 ratings',
                                  style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.00.sp,
                                      color: AppColor.borderGrey
                                  )
                              )
                            ]
                        ),
                        Column(
                            children: [
                              Row(
                                  children: [
                                    Row(
                                        children: List.generate(5, (index){

                                          return Icon(
                                              Icons.star,
                                              color: AppColor.starColor,
                                              size: screenHeight * 0.022
                                          );

                                        })
                                    ),
                                    Container(
                                        width: screenWidth / 2.6,
                                        height: screenHeight * 0.022,
                                        decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(19)
                                        )
                                    ),
                                    Text(
                                        '12',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.ratingTextColor
                                        )
                                    )
                                  ]
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                        children: List.generate(4, (index){

                                          return Icon(
                                              Icons.star,
                                              color: AppColor.starColor,
                                              size: screenHeight * 0.022
                                          );

                                        })
                                    ),
                                    Container(
                                        width: screenWidth * 0.18,
                                        height: screenHeight * 0.022,
                                        decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(19)
                                        )
                                    ),
                                    Text(
                                        '5',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.ratingTextColor
                                        )
                                    )
                                  ]
                              ),
                              Row(
                                  children: [
                                    Row(
                                        children: List.generate(3, (index){

                                          return Icon(
                                              Icons.star,
                                              color: AppColor.starColor,
                                              size: screenHeight * 0.022
                                          );

                                        })
                                    ),
                                    Container(
                                        width: screenWidth * 0.13,
                                        height: screenHeight * 0.022,
                                        decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(19)
                                        )
                                    ),
                                    Text(
                                        '4',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.ratingTextColor
                                        )
                                    )
                                  ]
                              ),
                              Row(
                                  children: [
                                    Row(
                                        children: List.generate(2, (index){

                                          return Icon(
                                              Icons.star,
                                              color: AppColor.starColor,
                                              size: screenHeight * 0.022
                                          );

                                        })
                                    ),
                                    Container(
                                        width: screenWidth * 0.08,
                                        height: screenHeight * 0.022,
                                        decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(19)
                                        )
                                    ),
                                    Text(
                                        '2',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.ratingTextColor
                                        )
                                    )
                                  ]
                              ),
                              Row(
                                  children: [
                                    Row(
                                        children: List.generate(1, (index){

                                          return Icon(
                                              Icons.star,
                                              color: AppColor.starColor,
                                              size: screenHeight * 0.022
                                          );

                                        })
                                    ),
                                    Container(
                                        width: screenWidth * 0.03,
                                        height: screenHeight * 0.022,
                                        decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.circular(19)
                                        )
                                    ),
                                    Text(
                                        '0',
                                        style: GoogleFonts.dmSans(
                                            fontSize: 12.00.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.ratingTextColor
                                        )
                                    )
                                  ]
                              )
                            ]
                        )
                      ]
                  )
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.022
                  ),
                  width: screenWidth / 1.2,
                  alignment: Alignment.centerLeft,
                  child: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/human_avatar.png'
                      )
                  )
              ),
              Container(
                  width: screenWidth / 1.3,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.033
                  ),
                  child: ListTile(
                      title: Text(
                          'Angel',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.00.sp,
                              color: AppColor.textColor
                          )
                      ),
                      subtitle:Row(
                          children: List.generate(5, (index){

                            return index == 4 ?
                            Icon(
                                Icons.star_border_outlined,
                                color: AppColor.borderGrey,
                                size: screenHeight * 0.022
                            ) :
                            Icon(
                                Icons.star,
                                color: AppColor.starColor,
                                size: screenHeight * 0.022
                            );

                          })
                      ),
                      trailing: Text(
                          'June 5, 2019',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.borderGrey
                          )
                      )
                  )
              ),
              Text(
                  '''
              I recently purchased a dress from [Your 
              Online Shopping Platform], and I must say, 
              I'm absolutely thrilled with my purchase! 
              The dress exceeded my expectations in 
              every way.
              Firstly, the quality of the fabric is 
              exceptional. It's soft, comfortable, and 
              feels luxurious against my skin. 
              I was also impressed by the attention to detail.''',
                  style: GoogleFonts.dmSans(
                      fontSize: 10.00.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor
                  )
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.022
                  ),
                  width: screenWidth / 1.2,
                  alignment: Alignment.centerLeft,
                  child: const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/human_avatar.png'
                      )
                  )
              ),
              Container(
                  width: screenWidth / 1.3,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.033
                  ),
                  child: ListTile(
                      title: Text(
                          'Veronica',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.00.sp,
                              color: AppColor.textColor
                          )
                      ),
                      subtitle:Row(
                          children: List.generate(5, (index){

                            return index == 4 ?
                            Icon(
                                Icons.star_border_outlined,
                                color: AppColor.borderGrey,
                                size: screenHeight * 0.022
                            ) :
                            Icon(
                                Icons.star,
                                color: AppColor.starColor,
                                size: screenHeight * 0.022
                            );

                          })
                      ),
                      trailing: Text(
                          'June 5, 2019',
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.borderGrey
                          )
                      )
                  )
              ),
              Text(
                  '''
              I recently purchased a dress from [Your 
              Online Shopping Platform], and I must say, 
              I'm absolutely thrilled with my purchase! 
              The dress exceeded my expectations in 
              every way.''',
                  style: GoogleFonts.dmSans(
                      fontSize: 10.00.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor
                  )
              )
            ]
          )
        )
      )
    );

  }

}