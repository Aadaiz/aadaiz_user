import 'package:aadaiz/src/utils/colors.dart';
import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {

  final List<Map<String,dynamic>> _data = [
    {
      'initial' : 'G',
      'title' : 'Consulting',
      'date' : 'Mar 24, 2024  11:15 AM',
      'amount' : '-₹314.00'
    },
    {
      'initial' : 'G',
      'title' : 'Direct Visit',
      'date' : 'Mar 27, 2024  11:15 AM',
      'amount' : '-₹314.00'
    }
  ];

  @override
  Widget build(BuildContext context) {

    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
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
              'Payment History',
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black
              )
          ),
          elevation: 2,
          centerTitle: true,
          shadowColor: AppColor.black,
          forceMaterialTransparency: false
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.03
        ),
        itemCount: _data.length,
          itemBuilder: (context, index){

            return Container(
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenWidth * 0.03
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 1)
                    )
                  ]
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColor.roseColor,
                  child: Text(
                    _data[index]['initial'],
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.00.sp,
                          color: AppColor.paymentMethodColor
                      )
                  )
                ),
                title: Text(
                    _data[index]['title'],
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.00.sp,
                        color: AppColor.paymentTitleColor
                    )
                ),
                subtitle: Text(
                    _data[index]['date'],
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.00.sp,
                        color: AppColor.hintTextColor
                    )
                ),
                trailing: Text(
                    _data[index]['amount'],
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.00.sp,
                        color: AppColor.lossRedColor
                    )
                )
              )
            );

          }
      )
    );

  }

}