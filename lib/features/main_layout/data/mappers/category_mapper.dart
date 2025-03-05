import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryMapper {
  Category fromDataModel(CategoryDM model) =>
      Category(
          id: model.id ?? '', name: model.name ?? '', image: model.image ?? '');

  List<Category> fromDataModels(List<CategoryDM> models) =>
      models.map(fromDataModel).toList();
}
