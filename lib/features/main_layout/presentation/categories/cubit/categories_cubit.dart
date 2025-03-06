import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/use_case/get_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/use_case/get_sub_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/presentation/categories/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetSubCategoriesUseCase _getSubCategoriesUseCase;

  CategoriesCubit(this._getCategoriesUseCase, this._getSubCategoriesUseCase)
      : super(CategoriesState.initial());

  Future<void> loadCategories() async {
    emit(state.copyWith(categoriesApi: LoadingApiState()));
    ApiResult<List<Category>> result = await _getCategoriesUseCase.execute();
    if (result.hasData) {
      emit(state.copyWith(categoriesApi: SuccessApiState(result.data)));
    } else {
      emit(state.copyWith(categoriesApi: ErrorApiState(result.error)));
    }
  }

  Future<void> loadSubCategories(String categoryId) async {
    emit(state.copyWith(subCategoriesApi: LoadingApiState()));
    ApiResult<List<Category>> result =
        await _getSubCategoriesUseCase.execute(categoryId);
    if (result.hasData) {
      emit(state.copyWith(subCategoriesApi: SuccessApiState(result.data)));
    } else {
      emit(state.copyWith(subCategoriesApi: ErrorApiState(result.error)));
    }
  }
}
