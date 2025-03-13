import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class Product {
  String id;
  num sold;
  List<String> images;
  num ratingsQuantity;
  String title;
  String description;
  num quantity;
  num price;
  String imageCover;
  Category? category;
  num ratingsAverage;
  int? totalItemsInCart;
  double? totalPriceCart;

  Product({
    this.sold = 0,
    this.images = const [],
    this.ratingsQuantity = 0,
    required this.id,
    this.title = "",
    this.description = "",
    this.quantity = 0,
    this.price = 0,
    this.imageCover = "",
    this.category,
    this.ratingsAverage = 0,
    this.totalItemsInCart = 0,
    this.totalPriceCart = 0,
  });
}
