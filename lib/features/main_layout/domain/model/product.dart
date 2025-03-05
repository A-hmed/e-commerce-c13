import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class Product {
  Product({this.sold = 0,
    this.images = const [],
    this.ratingsQuantity = 0,
    required this.id,
    this.title = '',
    this.description = '',
    this.quantity = 0,
    this.price = 0,
    this.imageCover = '',
    this.category,
    this.brand,
    this.ratingsAverage = 0});

  num sold;
  List<String> images;
  num ratingsQuantity;
  String id;
  String title;
  String description;
  num quantity;
  num price;
  String imageCover;
  Category? category;
  Category? brand;
  num ratingsAverage;
}
