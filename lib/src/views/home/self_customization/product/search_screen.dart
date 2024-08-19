import 'package:aadaiz/src/utils/responsive.dart';
import 'package:aadaiz/src/views/home/self_customization/product/product_list_screen.dart';
import 'package:aadaiz/src/views/home/self_customization/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../res/components/app_bar.dart';
import '../../../../res/components/search_field.dart';
import '../../controller/home_controller.dart';
import 'filter_data_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap(3.0.hp),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomizeAppBar(
                text: 'Search',
              ),
            ),
            Gap(3.0.hp),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchField(
                controllers: HomeController.to.search,
                onChanged: (value) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    HomeController.to.search.text = value;
                  });
                },
                onSubmitted: (value) async {
                   HomeController.to.catId.value='';
                   HomeController.to.search.text=value;
                  await HomeController.to.getProductList(isRefresh: true);
                },
                hinttext: 'Search By Keyword',
              ),
            ),
            Gap(3.0.hp),
            const FilterDataWidget(),
            Gap(3.0.hp),
            ProductWidget(
                type: HomeController.to.listIndex.value,
                //id:widget.id
            ),
          ],
        ),
      ),
    );
  }
}
