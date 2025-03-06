import 'package:ecommerce_app/core/utils/api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class CategoriesState {
  late ApiState<List<Category>> categoriesApi;
  late ApiState<List<Category>> subCategoriesApi;

  CategoriesState(
      {required this.categoriesApi, required this.subCategoriesApi});

  CategoriesState.initial() {
    categoriesApi = IdleApiState();
    subCategoriesApi = IdleApiState();
  }

  // copyWith method to allow creating a new instance with overridden properties
  CategoriesState copyWith({
    ApiState<List<Category>>? categoriesApi,
    ApiState<List<Category>>? subCategoriesApi,
  }) {
    return CategoriesState(
        categoriesApi: categoriesApi ?? this.categoriesApi,
        subCategoriesApi: subCategoriesApi ?? this.subCategoriesApi);
  }
}
