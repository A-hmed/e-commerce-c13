import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:flutter/material.dart';

import 'category_item.dart';

class CategoriesList extends StatefulWidget {
  final List<Category> categories;
  final Function onCategoryClick;

  const CategoriesList(
      {super.key, required this.categories, required this.onCategoryClick});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // Index of the currently selected category
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.onCategoryClick(widget.categories[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.containerGray,
        border: Border(
            // set the border for only 3 sides
            top: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            left: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            bottom: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3))),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
      ),

      // the categories items list
      child: ClipRRect(
        // clip the corners of the container that hold the list view
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
        child: ListView.builder(
          itemCount: widget.categories.length,
          itemBuilder: (context, index) => CategoryItem(
              index,
              "${widget.categories[index].name}",
              selectedIndex == index,
              onItemClick),
        ),
      ),
    );
  }

  // callback function to change the selected index
  onItemClick(int index) {
    widget.onCategoryClick(widget.categories[index]);
    setState(() {
      selectedIndex = index;
    });
  }
}
