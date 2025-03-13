import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/extensions/int_extensions.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/core/utils/shared_prefrences_helper.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_response.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart_repository/data_sources/cart_remote_data_source/cart_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final Dio _dio;
  final String cartUrl = "/api/v1/cart";
  final SharedPreferencesHelper _prefs;

  CartRemoteDataSourceImpl(this._dio, this._prefs);

  @override
  Future<ApiResult<CartResponse>> getCart() async {
    try {
      Response serverResponse = await _dio.get(
        cartUrl,

        /// Manually setting token is not recommended
        // options: Options(
        //   headers: {"token": await _prefs.getToken()}
        // )
      );
      CartResponse myResponse = CartResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<CartResponse>> addProductToCart(String id) async {
    //try {
    Response serverResponse = await _dio.post(cartUrl, data: {"productId": id});
    //CartResponse myResponse = CartResponse.fromJson(serverResponse.data);

    if (serverResponse.statusCode!.isSuccess) {
      return getCart(); //todo: fix me update add to cart response to be the same as other apis
    } else {
      return ErrorApiResult(ServerError(serverResponse.data["message"]));
    }
    // } catch (e) {
    //   return ErrorApiResult(ServerError());
    // }
  }

  @override
  Future<ApiResult<CartResponse>> removeProductToCart(String id) async {
    try {
      Response serverResponse = await _dio.delete(
        "$cartUrl/$id",
      );
      CartResponse myResponse = CartResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<CartResponse>> updateProductQuantity(
      String id, int quantity) async {
    try {
      Response serverResponse =
          await _dio.put("$cartUrl/$id", data: {"count": quantity});
      CartResponse myResponse = CartResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }
}
