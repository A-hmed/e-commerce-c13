import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/cart/domain/Cart.dart';

abstract class CartRepository {
  Future<ApiResult<Cart>> getCart();

  Future<ApiResult<Cart>> addProductToCart(String id);

  Future<ApiResult<Cart>> removeProductToCart(String id);

  Future<ApiResult<Cart>> updateProductQuantity(String id, int quantity);
}
