import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/extensions/connectivity_extension.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/main_layout/data/mappers/category_mapper.dart';
import 'package:ecommerce_app/features/main_layout/data/mappers/product_mapper.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/products_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repository/home_repository/datasources/home_remote_datasource.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repoistory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _dataSource;
  final Connectivity _connectivity;
  final CategoryMapper _categoryMapper;
  final ProductMapper _productMapper;

  HomeRepositoryImpl(this._dataSource, this._connectivity, this._categoryMapper,
      this._productMapper);

  @override
  Future<ApiResult<List<Category>>> getCategories() async {
    if (await _connectivity.isConnected) {
      ApiResult<CategoriesResponse> response =
          await _dataSource.getCategories();
      if (response.hasData) {
        List<CategoryDM> models = response.data.categories ?? [];
        return SuccessApiResult(_categoryMapper.fromDataModels(models));
      } else {
        return ErrorApiResult(response.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<List<Product>>> getProducts() async {
    if (await _connectivity.isConnected) {
      ApiResult<ProductsResponse> response = await _dataSource.getProducts();
      if (response.hasData) {
        List<ProductDM> models = response.data.data ?? [];
        return SuccessApiResult(_productMapper.fromDataModels(models));
      } else {
        return ErrorApiResult(response.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }
}
