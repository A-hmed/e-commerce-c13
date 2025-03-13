import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/extensions/connectivity_extension.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/cart/data/mappers/cart_mapper.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_response.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repository/data_sources/cart_remote_data_source/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/domain/Cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  final Connectivity _connectivity;
  final CartMapper _cartMapper;

  CartRepositoryImpl(
      this._cartRemoteDataSource, this._connectivity, this._cartMapper);

  @override
  Future<ApiResult<Cart>> addProductToCart(String id) async {
    if (await _connectivity.isConnected) {
      ApiResult<CartResponse> result =
          await _cartRemoteDataSource.addProductToCart(id);
      if (result.hasData) {
        return SuccessApiResult(_cartMapper.fromDataModel(result.data));
      } else {
        return ErrorApiResult(result.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<Cart>> getCart() async {
    if (await _connectivity.isConnected) {
      ApiResult<CartResponse> result = await _cartRemoteDataSource.getCart();
      if (result.hasData) {
        return SuccessApiResult(_cartMapper.fromDataModel(result.data));
      } else {
        return ErrorApiResult(result.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<Cart>> removeProductToCart(String id) async {
    if (await _connectivity.isConnected) {
      ApiResult<CartResponse> result =
          await _cartRemoteDataSource.removeProductToCart(id);
      if (result.hasData) {
        return SuccessApiResult(_cartMapper.fromDataModel(result.data));
      } else {
        return ErrorApiResult(result.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<Cart>> updateProductQuantity(String id, int quantity) async {
    if (await _connectivity.isConnected) {
      ApiResult<CartResponse> result =
          await _cartRemoteDataSource.updateProductQuantity(id, quantity);
      if (result.hasData) {
        return SuccessApiResult(_cartMapper.fromDataModel(result.data));
      } else {
        return ErrorApiResult(result.error);
      }
    } else {
      return ErrorApiResult(NetworkError());
    }
  }
}
