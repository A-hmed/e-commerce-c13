import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';

class Cart {
  double totalCartPrice;
  int numberOfCartItems;
  List<Product> products;

  Cart(
      {required this.products,
      required this.totalCartPrice,
      required this.numberOfCartItems});
}
