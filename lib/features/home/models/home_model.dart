import 'category_model.dart';
import 'meal_model.dart';
import 'restaurant_model.dart';

class HomeModel {
  final Map<String, dynamic> customer;
  final List<CategoryModel> categories;
  final List<RestaurantModel> restaurants;
  final List<MealModel> meals;
  final List banners;
  final int notifications;

  HomeModel({
    required this.customer,
    required this.categories,
    required this.restaurants,
    required this.meals,
    required this.banners,
    required this.notifications,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      customer: json["customer"],
      categories: (json["categories"] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      restaurants: (json["featured_restaurants"] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList(),
      meals: (json["featured_products"] as List)
          .map((e) => MealModel.fromJson(e))
          .toList(),
      banners: json["banners"],
      notifications: json["notifications_count"],
    );
  }
}