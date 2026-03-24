import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/active_orders.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/cancelled_orders.dart';
import 'package:aadaiz_customer_crm/src/views/my_orders/completed_orders.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: const CommonAppBar(title: 'My Orders'),
      ),
      body: Column(
        children: [

          /// TAB BAR
          TabBar(
            controller: _tabController,
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.04,
              horizontal: screenWidth * 0.016,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.00.sp,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            dividerColor: Colors.transparent,
            unselectedLabelColor: AppColor.black,
            labelColor: Colors.white,
            tabs: [
              _tabContainer(child: const Tab(text: 'Active')),
              _tabContainer(child: const Tab(text: 'Completed')),
              _tabContainer(child: const Tab(text: 'Cancelled')),
            ],
          ),

          /// TAB VIEW
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ActiveOrders(),
                CompletedOrders(),
                CancelledOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// TAB CONTAINER DESIGN
  Widget _tabContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}