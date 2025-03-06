import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:flutter/material.dart';

import 'category_card_item.dart';
import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  final List<Category> subCategories;
  final Category parentCategory;

  const SubCategoriesList(
      {super.key, required this.parentCategory, required this.subCategories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: <Widget>[
          // category title
          SliverToBoxAdapter(
            child: Text(
              parentCategory.name,
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          // the category card
          SliverToBoxAdapter(
            child: CategoryCardItem(
                parentCategory.name, ImageAssets.categoryCardImage),
          ),
          // the grid view of the subcategories
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                childCount: subCategories.length,
                (context, index) => SubCategoryItem(
                  title: subCategories[index].name,
                  categoryId: parentCategory.id,
                  subCategoryId: subCategories[index].id,
                  //todo: request a change from backend to add sub category image
                  image: ImageAssets.subcategoryCardImage,
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                mainAxisSpacing: AppSize.s8,
                crossAxisSpacing: AppSize.s8,
              ))
        ],
      ),
    );
  }
}
