import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';

class HomeState {
  late ApiState<List<Category>> categoriesApi;
  late ApiState<List<Product>> productsApi;

  HomeState({required this.categoriesApi, required this.productsApi});

  HomeState.initial() {
    categoriesApi = IdleApiState();
    productsApi = IdleApiState();
  }

  // copyWith method to allow creating a new instance with overridden properties
  HomeState copyWith({
    ApiState<List<Category>>? categoriesApi,
    ApiState<List<Product>>? productsApi,
  }) {
    return HomeState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
