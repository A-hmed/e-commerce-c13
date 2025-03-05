import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepository _repo;

  GetCategoriesUseCase(this._repo);

  Future<ApiResult<List<Category>>> execute() => _repo.getCategories();
}
