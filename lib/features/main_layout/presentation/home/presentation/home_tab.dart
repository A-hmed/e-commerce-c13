import 'dart:async';

import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/widget/product_card.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/presentation/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/presentation/home/presentation/cubit/home_state.dart';
import 'package:ecommerce_app/features/main_layout/presentation/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart' show ImageAssets;
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;
  final HomeCubit _cubit = getIt();

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
    _cubit.loadProducts();
    _cubit.loadCategories();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAdsWidget(
            adsImages: adsImages,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          BlocBuilder<HomeCubit, HomeState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state.categoriesApi.hasError) {
                  return ErrorWidget(state.categoriesApi.error);
                } else if (state.categoriesApi.isSuccess) {
                  return buildCategoriesSection(state.categoriesApi.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          BlocBuilder<HomeCubit, HomeState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state.productsApi.hasError) {
                  return ErrorWidget(state.productsApi.error);
                } else if (state.productsApi.isSuccess) {
                  return buildProductsSection(state.productsApi.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }

  Column buildProductsSection(List<Product> products) {
    return Column(
      children: [
        CustomSectionBar(
          sectionNname: 'Most Selling Products',
          function: () {},
        ),
        SizedBox(
          child: SizedBox(
            height: 360.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                );
              },
              itemCount: 20,
            ),
          ),
        ),
      ],
    );
  }

  Column buildCategoriesSection(List<Category> categories) {
    return Column(
      children: [
        CustomSectionBar(sectionNname: 'Categories', function: () {}),
        SizedBox(
          height: 270.h,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomCategoryWidget(
                category: categories[index],
              );
            },
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
        ),
        // SizedBox(height: 12.h),

        SizedBox(height: 12.h),
      ],
    );
  }
}
