
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
import 'package:intl/intl.dart';
class EventFilter extends StatefulWidget {
  const EventFilter({super.key});

  @override
  State<EventFilter> createState() => _EventFilterState();
}

class _EventFilterState extends State<EventFilter> {
  final MaterialController controller = Get.find<MaterialController>();

  final List<String> _categories = [
    'Date & Time',
    'Location',

  ];
  List<String> locations = [
    "Chennai",
    "Coimbatore",
  ];

  List<String> selectedLocations = [];
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
      appBar:  PreferredSize(
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
              onTap: (){
                _resetAllFilters();
              },
              child: Container(
                width: screenWidth / 2.3,
                height: screenHeight*0.045,
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
              height: screenHeight*0.045,
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
      return _buildDateFilter();
    } else {
      return _buildLocationFilter();
    }
  }

  Widget _buildDateFilter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const Icon(Icons.date_range, size: 18),
              const SizedBox(width: 8),
              Text(
                "Event Between",
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [


              Expanded(
                child: InkWell(
                  onTap: () => _pickFromDate(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            fromDate == null
                                ? "May 25, 2024"
                                : DateFormat('MMM dd, yyyy').format(fromDate!),
                            style: GoogleFonts.dmSans(fontSize: 12.sp),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 18)
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),


              Expanded(
                child: InkWell(
                  onTap: () => _pickToDate(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            toDate == null
                                ? "May 26, 2024"
                                : DateFormat('MMM dd, yyyy').format(toDate!),
                            style: GoogleFonts.dmSans(fontSize: 12.sp),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 18)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> _pickFromDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        fromDate = picked;

        if (toDate != null && toDate!.isBefore(picked)) {
          toDate = null;
        }
      });
    }
  }
  Future<void> _pickToDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? fromDate ?? DateTime.now(),
      firstDate: fromDate ?? DateTime.now(),
      lastDate: DateTime(2100),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        toDate = picked;
      });
    }
  }
  Widget _buildLocationFilter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(locations.length, (index) {

          final String city = locations[index];

          return CheckboxListTile(checkColor: AppColor.white,
            hoverColor: AppColor.orangeColor,
            activeColor: AppColor.minusColor,
            value: selectedLocations.contains(city),
            title: Text(
              city,
              style: GoogleFonts.dmSans(fontSize: 13.sp),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                if (value!) {
                  selectedLocations.add(city);
                } else {
                  selectedLocations.remove(city);
                }
              });
            },
          );
        }),
      ),
    );
  }
  void _resetAllFilters() {
    setState(() {
      _selectedCategory = 0;


    });
  }

  void _applyFilters() {


  }

}


