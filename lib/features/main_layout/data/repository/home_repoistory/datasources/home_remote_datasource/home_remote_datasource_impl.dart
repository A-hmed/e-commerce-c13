import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/extensions/int_extensions.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/products_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repository/home_repoistory/datasources/home_remote_datasource/home_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio _dio;
  final String _productsUrl = '/api/v1/products';
  final String _categoriesUrl = '/api/v1/categories';

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<ApiResult<ProductsResponse>> getProducts() async {
    try {
      Response serverResponse = await _dio.get(_productsUrl);
      ProductsResponse myResponse =
      ProductsResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(myResponse);
      } else {
        return ErrorApiResult(ServerError());
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<CategoriesResponse>> getCategories() async {
    try {
      Response serverResponse = await _dio.get(_categoriesUrl);
      CategoriesResponse myResponse =
      CategoriesResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(myResponse);
      } else {
        return ErrorApiResult(ServerError());
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }
}
