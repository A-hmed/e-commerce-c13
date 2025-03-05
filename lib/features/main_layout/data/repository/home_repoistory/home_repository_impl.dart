import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/extensions/connectivity_extensions.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/main_layout/data/mappers/category_mapper.dart';
import 'package:ecommerce_app/features/main_layout/data/mappers/product_mapper.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/products_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repository/home_repoistory/datasources/home_remote_datasource/home_remote_datasource.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  Connectivity _connectivity;
  HomeRemoteDataSource _dataSource;
  CategoryMapper _categoryMapper;
  ProductMapper _productMapper;

  HomeRepositoryImpl(this._connectivity, this._productMapper,
      this._categoryMapper, this._dataSource);

  @override
  Future<ApiResult<List<Product>>> getProducts() async {
    if (await _connectivity.isConnected) {
      ApiResult<ProductsResponse> response = await _dataSource.getProducts();
      List<ProductDM> list = response.data.products ?? [];
      var newList = list.where((product) => product.price > 20);
      return SuccessApiResult(_productMapper.fromDataModels(list));
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<List<Category>>> getCategories() async {
    if (await _connectivity.isConnected) {
      ApiResult<CategoriesResponse> response =
      await _dataSource.getCategories();
      List<CategoryDM> list = response.data.categories ?? [];

      return SuccessApiResult(_categoryMapper.fromDataModels(list));
    } else {
      return ErrorApiResult(NetworkError());
    }
  }
}
