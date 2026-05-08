import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/consulting.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/controller/consulting_controller.dart';
import 'package:aadaiz_customer_crm/src/views/consulting/designer_booked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BookDesigner extends StatefulWidget {
  final dynamic designerId;
  final String date;
  final dynamic slotId;
  final bool isOnline;
  final dynamic bookingId;
  final int amount;

  final String? contactName;
  final String? contactMobile;
  final String? area;
  final String? city;
  final String? state;
  final String? landmark;
  final String? pincode;

  const BookDesigner({
    super.key,
    required this.designerId,
    required this.date,
    required this.slotId,
    required this.isOnline,
    required this.bookingId,
    required this.amount,
    this.contactName,
    this.contactMobile,
    this.area,
    this.city,
    this.state,
    this.landmark,
    this.pincode,
  });

  @override
  State<BookDesigner> createState() => _BookDesignerState();
}

class _BookDesignerState extends State<BookDesigner> {
  final controller = ConsultingController.to;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final res = await controller.verifyPayment(
      razorpayOrderId: response.orderId ?? '',
      razorpayPaymentId: response.paymentId ?? '',
      razorpaySignature: response.signature ?? '',
      designerBookingId: widget.bookingId ?? '',
    );

    if (res['status'] == true) {
      Get.off(() => const DesignerBooked());
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => const Consulting());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      'Payment Failed',
      response.message ?? 'Something went wrong',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      'External Wallet',
      'Selected: ${response.walletName}',
    );
  }

  Future<void> _openRazorpay(String orderId, int amount) async {
    final options = {
      'key': 'rzp_live_Rpqwuk8JruzFOi',
      'amount': amount,
      'currency': 'INR',
      'order_id': orderId,
      'name': 'Aadaiz',
      'description': 'Designer Consultation',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm'],
      },
    };
    _razorpay.open(options);
  }

  Future<void> _onPayPressed() async {
    final payRes = await controller.addPayment(amount: widget.amount);

    if (payRes == null || payRes['status'] != true) {
      Get.snackbar(
        'Error',
        payRes?['message'] ?? 'Payment order failed',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final String orderId = payRes['data']['order_id'];
    final int razorAmount = (payRes['data']['amount'] as num).toInt();

    await _openRazorpay(orderId, razorAmount);
  }

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
          child: Image.asset('assets/images/back.png'),
        ),
        title: Text(
          'Booking Details',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 14.00.sp,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColor.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.033,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Designer',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.00.sp,
                  color: AppColor.black,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: screenHeight * 0.033),
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.033,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Positioned(
                            top: 7,
                            right: 7,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: AppColor.circleDotColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
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
                              color: AppColor.designerColor,
                            ),
                          ),
                          Text(
                            'Designer',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.00.sp,
                              color: AppColor.designerRoleColor,
                            ),
                          ),
                          Text(
                            '⭐️ 4.5 (135 reviews)',
                            style: GoogleFonts.dmSans(
                              fontSize: 9.00.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.designerRoleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                shape: const Border(),
                childrenPadding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                title: Text(
                  'Schedule Timings',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.00.sp,
                    color: AppColor.black,
                  ),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scheduled Date',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      Text(
                        widget.date,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      Text(
                        '${widget.slotId}',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Type',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      Text(
                        widget.isOnline ? 'Online' : 'Offline',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.00.sp,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 0,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.01,
        ),
        color: Colors.transparent,
        child: Obx(
              () => ListTile(
            contentPadding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            dense: true,
            tileColor: AppColor.primary,
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              'Total',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 12.00.sp,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              '₹${widget.amount}.00',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 13.00.sp,
                color: Colors.white,
              ),
            ),
            trailing: InkWell(
              onTap: controller.paymentLoading.value ? null : _onPayPressed,
              child: Container(
                height: screenHeight * 0.066,
                width: screenWidth * 0.35,
                padding:
                EdgeInsets.symmetric(horizontal: screenWidth * 0.033),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.paymentLoading.value
                    ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child:
                    CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/ic_pay.png',
                      width: screenWidth * 0.066,
                    ),
                    Text(
                      'Payment',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.00.sp,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}