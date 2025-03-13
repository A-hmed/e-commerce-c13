import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';

class CartEntry {
  CartEntry({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  CartEntry.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product =
        json['product'] != null ? ProductDM.fromJson(json['product']) : null;
    price = json['price'];
  }

  num? count;
  String? id;
  ProductDM? product;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['_id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = price;
    return map;
  }
}
