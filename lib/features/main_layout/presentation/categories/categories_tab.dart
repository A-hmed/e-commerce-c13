import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/presentation/categories/cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/presentation/categories/cubit/home_state.dart';
import 'package:ecommerce_app/features/main_layout/presentation/categories/widgets/categories_list.dart';
import 'package:ecommerce_app/features/main_layout/presentation/categories/widgets/sub_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  CategoriesCubit _categoriesCubit = getIt();
  Category? selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesCubit.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p12),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
          bloc: _categoriesCubit,
          builder: (context, state) {
            if (state.categoriesApi.isSuccess) {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CategoriesList(
                        categories: state.categoriesApi.data,
                        onCategoryClick: (Category category) {
                          selectedCategory = category;
                          _categoriesCubit.loadSubCategories(category.id);
                        }),
                  ),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        bloc: _categoriesCubit,
                        builder: (context, state) {
                          if (state.subCategoriesApi.isSuccess) {
                            return SubCategoriesList(
                              subCategories: state.subCategoriesApi.data,
                              parentCategory: selectedCategory!,
                            );
                          } else if (state.subCategoriesApi.hasError) {
                            return ErrorWidget(state.subCategoriesApi.error);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  )
                ],
              );
            } else if (state.categoriesApi.hasError) {
              return ErrorWidget(state.categoriesApi.error);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
