import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';

abstract class HomeRepository {
  Future<ApiResult<List<Product>>> getProducts();

  Future<ApiResult<List<Category>>> getCategories();
}