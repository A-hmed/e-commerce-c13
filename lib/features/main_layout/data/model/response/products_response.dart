import 'package:ecommerce_app/features/main_layout/data/model/response/meta_data.dart';

import 'product_dm.dart';

class ProductsResponse {
  ProductsResponse({
    this.results,
    this.metadata,
    this.products,
  });

  ProductsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
    json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      products = [];
      json['data'].forEach((v) {
        products?.add(ProductDM.fromJson(v));
      });
    }
  }

  num? results;
  Metadata? metadata;
  List<ProductDM>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (products != null) {
      map['data'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
