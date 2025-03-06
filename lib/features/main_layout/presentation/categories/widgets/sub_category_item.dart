import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final String categoryId;
  final String subCategoryId;

  const SubCategoryItem(
      {super.key,
      required this.title,
      required this.image,
      required this.categoryId,
      required this.subCategoryId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductsScreen(
                      categoryId: categoryId,
                      subCategoryId: subCategoryId,
                    )));
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    border: Border.all(color: ColorManager.primary, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(color: ColorManager.primary),
          )
        ],
      ),
    );
  }
}
