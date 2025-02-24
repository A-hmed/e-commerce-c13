import 'category_dm.dart';
import 'meta_data.dart';

class CategoriesResponse {
  CategoriesResponse({
    this.results,
    this.metadata,
    this.categories,
  });

  CategoriesResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      categories = [];
      json['data'].forEach((v) {
        categories?.add(CategoryDM.fromJson(v));
      });
    }
  }

  num? results;
  Metadata? metadata;
  List<CategoryDM>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (categories != null) {
      map['data'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
