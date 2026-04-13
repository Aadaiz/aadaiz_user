import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/buy_and_sell/controller/buyAndSellController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyAndSellFilter extends StatefulWidget {
  const BuyAndSellFilter({super.key});

  @override
  State<BuyAndSellFilter> createState() => _BuyAndSellFilterState();
}

class _BuyAndSellFilterState extends State<BuyAndSellFilter> {
  final BuyAndSellController controller = Get.find<BuyAndSellController>();

  final List<String> _menuCategories = ['Category'];
  int _selectedMenu = 0;
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(
          leadingclick: () => Get.back(),
          title: 'Filter',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Left Sidebar ─────────────────────────────────────
            Container(
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: AppColor.borderGrey.withAlpha(20),
                    width: 2,
                  ),
                ),
              ),
              child: ListView.builder(
                itemCount: _menuCategories.length,
                itemBuilder: (context, index) {
                  final bool isSelected = _selectedMenu == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMenu = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primary.withOpacity(0.1)
                            : Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.black.withOpacity(0.05),
                          ),
                          left: BorderSide(
                            color: isSelected
                                ? AppColor.primary
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Text(
                        _menuCategories[index],
                        style: GoogleFonts.dmSans(
                          fontSize: 12.sp,
                          color: isSelected
                              ? AppColor.primary
                              : AppColor.black,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ── Right Content ─────────────────────────────────────
            Expanded(child: _buildContentArea()),
          ],
        ),
      ),

      // ── Bottom Buttons ────────────────────────────────────────
      bottomNavigationBar: BottomAppBar(
        height: screenHeight * 0.1,
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: _resetAllFilters,
              child: Container(
                width: screenWidth / 2.3,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.borderGrey),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Reset',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: screenWidth / 2.3,
              height: screenHeight * 0.045,
              child: CommonButton(
                press: _applyFilters,
                text: 'Apply',
                borderRadius: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentArea() {
    // Only Category menu for now
    return _buildCategoryFilter();
  }

  Widget _buildCategoryFilter() {
    return Obx(() {
      final categories = controller.categoryList;

      if (categories.isEmpty) {
        return Center(
          child: Text(
            'No categories available',
            style: GoogleFonts.dmSans(
              fontSize: 13.sp,
              color: AppColor.subTitleColor,
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final bool isSelected = _selectedCategory == category;

          return InkWell(
            onTap: () {
              setState(() {
                // Tap same to deselect
                _selectedCategory =
                isSelected ? null : category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primary.withOpacity(0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? AppColor.primary
                      : AppColor.borderGrey.withOpacity(0.5),
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColor.primary
                          : AppColor.black,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  void _resetAllFilters() {
    setState(() {
      _selectedCategory = null;
    });
  }

  void _applyFilters() {

    controller.selectedCategory.value = _selectedCategory ?? '';
    controller.getBuyAndSellList(isRefresh: true,category:  controller.selectedCategory.value);
    Get.back();
  }
}