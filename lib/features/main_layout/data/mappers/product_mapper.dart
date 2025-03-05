import 'package:ecommerce_app/features/main_layout/data/mappers/category_mapper.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductMapper {
  CategoryMapper _categoryMapper;

  ProductMapper(this._categoryMapper);

  Product fromDataModel(ProductDM productDM) {
    return Product(
      sold: productDM.sold ?? 0,
      images: productDM.images ?? [],
      ratingsQuantity: productDM.ratingsQuantity ?? 0,
      id: productDM.id ?? '',
      title: productDM.title ?? '',
      description: productDM.description ?? '',
      quantity: productDM.quantity ?? 0,
      price: productDM.price ?? 0,
      imageCover: productDM.imageCover ?? '',
      category: productDM.category != null
          ? _categoryMapper.fromDataModel(productDM.category!)
          : null,
      brand: productDM.brand != null
          ? _categoryMapper.fromDataModel(productDM.brand!)
          : null,
      ratingsAverage: productDM.ratingsAverage ?? 0,
    );
  }

  List<Product> fromDataModels(List<ProductDM> models) =>
      models.map(fromDataModel).toList();
}
