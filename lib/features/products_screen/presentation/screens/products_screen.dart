import 'package:ecommerce_app/core/di/di.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/widget/product_card.dart';
import 'package:ecommerce_app/features/products_screen/presentation/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/cubit/proudcts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;

  const ProductsScreen(
      {super.key, required this.categoryId, required this.subCategoryId});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsCubit _cubit = getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.loadProducts(widget.categoryId, widget.subCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const HomeScreenAppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.productsApi.isSuccess) {
              return Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: state.productsApi.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 7 / 9,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: state.productsApi.data[index],
                          );
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    )
                  ],
                ),
              );
            } else if (state.productsApi.hasError) {
              return ErrorWidget(state.productsApi.error);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
