import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/products_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<CategoriesResponse>> getCategories();

  Future<ApiResult<ProductsResponse>> getProducts(
      String? parentCategory, String? subCategory);

  Future<ApiResult<CategoriesResponse>> getSubCategories(String categoryId);
}
