import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';

class ProductState {
  late ApiState<List<Product>> productsApi;

  ProductState({required this.productsApi});

  ProductState.initial() {
    productsApi = IdleApiState();
  }

  // copyWith method to allow creating a new instance with overridden properties
  ProductState copyWith({
    ApiState<List<Product>>? productsApi,
  }) {
    return ProductState(
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
