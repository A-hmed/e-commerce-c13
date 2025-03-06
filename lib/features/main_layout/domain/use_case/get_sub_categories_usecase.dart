import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubCategoriesUseCase {
  final HomeRepository _repo;

  GetSubCategoriesUseCase(this._repo);

  Future<ApiResult<List<Category>>> execute(String categoryId) =>
      _repo.getSubCategories(categoryId);
}
