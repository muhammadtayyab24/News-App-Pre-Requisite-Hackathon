import 'package:news_app/models/category_models.dart';

List<CategoryModels> getCategories() {
  // ignore: deprecated_member_use
  List<CategoryModels> category = <CategoryModels>[];
  CategoryModels categoryModels = new CategoryModels();

  categoryModels.categoryName = "Business";
  categoryModels.imageUrl = "assets/images/entrepreneur-g9f32bdb94_1920.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName = "health";
  categoryModels.imageUrl = "assets/images/health.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName = "Sports";
  categoryModels.imageUrl = "assets/images/sports.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName = "entertainment";
  categoryModels.imageUrl = "assets/images/entertainment.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName = "technology";
  categoryModels.imageUrl = "assets/images/popular-news.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  categoryModels.categoryName = "science";
  categoryModels.imageUrl = "assets/images/science.jpg";
  category.add(categoryModels);
  categoryModels = new CategoryModels();

  return category;
}
