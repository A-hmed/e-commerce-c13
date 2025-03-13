import 'package:ecommerce_app/features/cart/data/model/response/cart_entry.dart';
import 'package:ecommerce_app/features/cart/domain/Cart.dart';
import 'package:ecommerce_app/features/main_layout/data/mappers/product_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:injectable/injectable.dart';

import '../model/response/cart_response.dart';

@injectable
class CartMapper {
  ProductMapper _productMapper;

  CartMapper(this._productMapper);

  Cart fromDataModel(CartResponse response) {
    List<CartEntry> cartEntries = response.cartDM?.products ?? [];
    Cart appCart = Cart(
        products: cartEntries.map(cartEntryToProduct).toList(),
        totalCartPrice: (response.cartDM?.totalCartPrice ?? 0).toDouble(),
        numberOfCartItems: (response.numOfCartItems ?? 0).toInt());
    return appCart;
  }

  Product cartEntryToProduct(CartEntry entry) {
    Product product = _productMapper.fromDataModel(entry.product!);
    product.totalPriceCart = (entry.price ?? 0).toDouble();
    product.totalItemsInCart = (entry.count ?? 0).toInt();
    return product;
  }
}
