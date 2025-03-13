import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_response.dart';

abstract class CartRemoteDataSource {
  Future<ApiResult<CartResponse>> getCart();

  Future<ApiResult<CartResponse>> addProductToCart(String id);

  Future<ApiResult<CartResponse>> removeProductToCart(String id);

  Future<ApiResult<CartResponse>> updateProductQuantity(
      String id, int quantity);
}
