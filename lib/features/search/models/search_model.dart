import '../../home/models/category_model.dart';
import '../../home/models/meal_model.dart';
import '../../home/models/restaurant_model.dart';

class SearchModel {
  final List<RestaurantModel> restaurants;
  final List<MealModel> meals;
  final List<CategoryModel> categories;

  SearchModel({
    required this.restaurants,
    required this.meals,
    required this.categories,
  });

  factory SearchModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return SearchModel(
      restaurants: (json["restaurants"] as List)
          .map(
            (e) => RestaurantModel.fromJson(e),
      )
          .toList(),

      meals: (json["products"] as List)
          .map(
            (e) => MealModel.fromJson(e),
      )
          .toList(),

      categories: (json["categories"] as List)
          .map(
            (e) => CategoryModel.fromJson(e),
      )
          .toList(),
    );
  }
}