import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/use_case/get_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/use_case/get_products_usecase.dart';
import 'package:ecommerce_app/features/main_layout/presentation/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase _getProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  HomeCubit(this._getProductsUseCase, this._getCategoriesUseCase)
      : super(HomeState.initial());

  Future<void> loadCategories() async {
    emit(state.copyWith(categoriesApi: LoadingApiState()));
    ApiResult<List<Category>> result = await _getCategoriesUseCase.execute();
    if (result.hasData) {
      emit(state.copyWith(categoriesApi: SuccessApiState(result.data)));
    } else {
      emit(state.copyWith(categoriesApi: ErrorApiState(result.error)));
    }
  }

  Future<void> loadProducts() async {
    emit(state.copyWith(productsApi: LoadingApiState()));
    ApiResult<List<Product>> result = await _getProductsUseCase.execute();
    if (result.hasData) {
      emit(state.copyWith(productsApi: SuccessApiState(result.data)));
    } else {
      emit(state.copyWith(productsApi: ErrorApiState(result.error)));
    }
  }
}
