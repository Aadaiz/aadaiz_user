import 'package:aadaiz_customer_crm/src/res/components/common_button.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/utils/utils.dart';
import 'package:aadaiz_customer_crm/src/views/material/controller/material_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final MaterialController controller = Get.find<MaterialController>();

  final List<String> _categories = [
    'Fabrics',
    'Colors',
    'Price Range',
    'Ratings',
  ];
bool isPriceChoosed=false;
  int _selectedCategory = 0;
  int _selectedColor = 0;
  int _selectedFabric=0;
 String? choosedColorCode;
 String? choosedCategory;


  // For Price Range
  RangeValues _priceRange = const RangeValues(0, 1000);
  final double _minPrice = 0;
  final double _maxPrice = 10000;

  // For Ratings
  final List<double> _ratingOptions = [5.0, 4.0, 3.0, 2.0, 1.0];
  double? _selectedRating;

  @override
  void initState() {
    super.initState();
    controller.getFilterCategory();
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
          child: InkWell(onTap: (){
            Get.back();
          }, child: Image.asset('assets/images/back.png')),
        ),

        title: Text(
          'Filter',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColor.black,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: AppColor.black,
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Sidebar Categories
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
    if (_selectedCategory == 2) {
      return _buildPriceRangeFilter();
    } else if (_selectedCategory == 3) {
      return _buildRatingFilter();
    } else {
      return Obx(() {
        if (controller.filterLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: _getItemCount(),
          itemBuilder: (context, index) {
            return _buildGridItem(index);
          },
        );
      });
    }
  }

  Widget _buildPriceRangeFilter() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Price Range',
            style: GoogleFonts.dmSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Drag the handles to set your preferred price range',
            style: GoogleFonts.dmSans(
              fontSize: 12.sp,
              color: AppColor.greyTitleColor,
            ),
          ),
          const SizedBox(height: 30),

          // Price Range Slider
          RangeSlider(
            values: _priceRange,
            min: _minPrice,
            max: _maxPrice,
            divisions: 100,
            labels: RangeLabels(
              '\₹${_priceRange.start.round()}',
              '\₹${_priceRange.end.round()}',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _priceRange = values;
                isPriceChoosed = true;
              });
            },
            activeColor: AppColor.primary,
            inactiveColor: AppColor.borderGrey,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRatingFilter() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Rating',
            style: GoogleFonts.dmSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose minimum rating',
            style: GoogleFonts.dmSans(
              fontSize: 12.sp,
              color: AppColor.greyTitleColor,
            ),
          ),
          const SizedBox(height: 30),

          // Rating Options
          Column(
            children:
                _ratingOptions.map((rating) {
                  return _buildRatingOption(rating);
                }).toList(),
          ),

          const SizedBox(height: 30),

          // Clear Rating Option
          InkWell(
            onTap: () {
              setState(() {
                _selectedRating = null;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _selectedRating == null
                          ? AppColor.primary
                          : AppColor.borderGrey,
                ),
                borderRadius: BorderRadius.circular(8),
                color:
                    _selectedRating == null
                        ? AppColor.primary.withOpacity(0.1)
                        : Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.clear_all,
                    color:
                        _selectedRating == null
                            ? AppColor.primary
                            : AppColor.greyTitleColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Show All Ratings',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      color:
                          _selectedRating == null
                              ? AppColor.primary
                              : AppColor.greyTitleColor,
                      fontWeight:
                          _selectedRating == null
                              ? FontWeight.w600
                              : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingOption(double rating) {
    final bool isSelected = _selectedRating == rating;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedRating = rating;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.borderGrey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColor.primary.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            // Star Rating Display
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating.floor() ? Icons.star : Icons.star_border,
                  color: AppColor.starColor,
                  size: 20,
                );
              }),
            ),

            const SizedBox(width: 8),

            // Rating Text
            Text(
              rating == 5
                  ? '5.0 & above'
                  : '${rating.toStringAsFixed(1)} & above',
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                color: AppColor.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),

            const Spacer(),

            // Check Icon for selected
            if (isSelected)
              Icon(Icons.check, color: AppColor.primary, size: 20),
          ],
        ),
      ),
    );
  }

  int _getItemCount() {
    if (_selectedCategory == 1) {
      return controller.filterListColors.length;
    }
    return controller.filterListCategories.length;
  }

  Widget _buildGridItem(int index) {
    if (_selectedCategory == 1) {
      final colorCode = controller.filterListColors[index];

      return InkWell(
        onTap: (){
          setState(() {
            _selectedColor = index;
            choosedColorCode=colorCode;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: HexColor(colorCode),
            border: Border.all(
              color:
                  _selectedColor == index ? AppColor.primary : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 20,
                color: AppColor.unSelectColor.withOpacity(0.1),
              ),
            ],
          ),
        ),
      );
    }

    final category = controller.filterListCategories[index];

    return InkWell(
      onTap: () {
        setState(() {
          _selectedFabric = index;
          choosedCategory=category.category;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(
            color:
                _selectedFabric == index ? AppColor.primary : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 20,
              color: AppColor.unSelectColor.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  category.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.category!,
              style: GoogleFonts.dmSans(
                fontSize: 7.sp,
                color: AppColor.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _resetAllFilters() {
    setState(() {
      _selectedCategory = 0;
      _selectedColor = 0;
      _selectedFabric=0;
      _selectedRating = null;
      isPriceChoosed=false;
      _priceRange = const RangeValues(0, 1000);
      choosedColorCode=null;
      choosedCategory=null;
    });
  }

  void _applyFilters() {
    controller.getMaterials(
        rating: _selectedRating != null
            ? _selectedRating.toString()
            : null,

        minPrice: isPriceChoosed
            ? _priceRange.start.round().toString()
            : null,

        maxPrice: isPriceChoosed
            ? _priceRange.end.round().toString()
            : null,
      color: choosedColorCode,
      category:choosedCategory ,isRefresh: true
    );

    Get.back();
  }

}

class HexColor extends Color {
  HexColor(final String hex) : super(_parse(hex));

  static int _parse(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return int.parse(hex, radix: 16);
  }
}
