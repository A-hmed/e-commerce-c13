import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/use_case/get_products_usecase.dart';
import 'package:ecommerce_app/features/products_screen/presentation/cubit/proudcts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsCubit extends Cubit<ProductState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsCubit(this._getProductsUseCase) : super(ProductState.initial());

  Future<void> loadProducts(String categoryId, String subCategoryId) async {
    emit(state.copyWith(productsApi: LoadingApiState()));
    ApiResult<List<Product>> result =
        await _getProductsUseCase.execute(categoryId, subCategoryId);
    if (result.hasData) {
      emit(state.copyWith(productsApi: SuccessApiState(result.data)));
    } else {
      emit(state.copyWith(productsApi: ErrorApiState(result.error)));
    }
  }
}
