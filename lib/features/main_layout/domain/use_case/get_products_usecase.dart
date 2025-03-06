import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository _repo;

  GetProductsUseCase(this._repo);

  Future<ApiResult<List<Product>>> execute(
          [String? parentCategory, String? subCategory]) =>
      _repo.getProducts(parentCategory, subCategory);
}
