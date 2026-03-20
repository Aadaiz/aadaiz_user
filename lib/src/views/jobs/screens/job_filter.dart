import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/jobs/controller/jobs_controller.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JobFilter extends StatefulWidget {
  const JobFilter({super.key});

  @override
  State<JobFilter> createState() => _JobFilterState();
}

class _JobFilterState extends State<JobFilter> {
  final JobsController controller = Get.find<JobsController>();

  final List<String> _categories = ['Salary', 'Type','Category'];

  List<String> selectedJocCategory = [];


  List<String> selectedLocations = [];
  List<String> selectedSalary = [];
  List<String> selectedType = [];
  List<String> selectedCategory = [];

  int _selectedCategory = 0;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Utils.getActivityScreenHeight(context);
    final double screenWidth = Utils.getActivityScreenWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: 'Filter'),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: AppColor.borderGrey.withAlpha(20),
                    width: 2,
                  ),
                ),
              ),
              width: Get.width * 0.3,
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _selectedCategory == index
                                ? AppColor.primary.withOpacity(0.1)
                                : Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.black.withOpacity(0.05),
                          ),
                          left: BorderSide(
                            color:
                                _selectedCategory == index
                                    ? AppColor.primary
                                    : Colors.transparent,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.dmSans(
                          fontSize: 12.sp,
                          color:
                              _selectedCategory == index
                                  ? AppColor.primary
                                  : AppColor.black,
                          fontWeight:
                              _selectedCategory == index
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(child: _buildContentArea()),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        height: screenHeight * 0.1,
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                _resetAllFilters();
              },
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
    if (_selectedCategory == 0) {
      return _buildSalaryType();
    } else if (_selectedCategory == 1) {
      return _buildJobType();
    }
    else {
      return _buildJobCategory();
    }

  }





  Widget _buildJobType() {
    return Obx(() {
      final typeList = controller.jobFilterData.value?.type ?? [];

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(typeList.length, (index) {
            final String item = typeList[index];

            return CheckboxListTile(
              checkColor: AppColor.white,
              activeColor: AppColor.minusColor,
              value: selectedType.contains(item),
              title: Text(item, style: GoogleFonts.dmSans(fontSize: 13.sp)),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  value! ? selectedType.add(item) : selectedType.remove(item);
                });
              },
            );
          }),
        ),
      );
    });
  }
  Widget _buildSalaryType() {
    return Obx(() {
      if (controller.jobFilterListLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final salaryList = controller.jobFilterData.value?.salary ?? [];

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(salaryList.length, (index) {
            final String item = salaryList[index];

            return CheckboxListTile(
              checkColor: AppColor.white,
              activeColor: AppColor.minusColor,
              value: selectedSalary.contains(item),
              title: Text(item, style: GoogleFonts.dmSans(fontSize: 13.sp)),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  value! ? selectedSalary.add(item) : selectedSalary.remove(item);
                });
              },
            );
          }),
        ),
      );
    });
  }
  Widget _buildJobCategory() {
    return Obx(() {
      final categoryList = controller.jobFilterData.value?.category ?? [];

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(categoryList.length, (index) {
            final item = categoryList[index].jobCategory ?? '';

            return CheckboxListTile(
              checkColor: AppColor.white,
              activeColor: AppColor.minusColor,
              value: selectedJocCategory.contains(item),
              title: Text(item, style: GoogleFonts.dmSans(fontSize: 13.sp)),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  value!
                      ? selectedJocCategory.add(item)
                      : selectedJocCategory.remove(item);
                });
              },
            );
          }),
        ),
      );
    });
  }

  void _resetAllFilters() {
    setState(() {
      selectedSalary.clear();
      selectedType.clear();
      selectedJocCategory.clear();
      _selectedCategory = 0;
    });
  }
  void _applyFilters() {
    Get.back();

    controller.getJobData(
      true,
      jobType: selectedType.isNotEmpty ? selectedType.first : null,
      jobCategory: selectedJocCategory.isNotEmpty
          ? selectedJocCategory.first
          : null,
      salary: selectedSalary.isNotEmpty ? selectedSalary.first : null,
    );
  }
}
