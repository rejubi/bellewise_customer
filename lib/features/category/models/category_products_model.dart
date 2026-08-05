class CategoryProductsModel {
  final CategoryInfo category;
  final List<CategoryProduct> products;

  CategoryProductsModel({
    required this.category,
    required this.products,
  });

  factory CategoryProductsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CategoryProductsModel(
      category: CategoryInfo.fromJson(
        json["category"],
      ),
      products: (json["products"] as List)
          .map(
            (e) => CategoryProduct.fromJson(e),
      )
          .toList(),
    );
  }
}

class CategoryInfo {
  final int id;
  final String name;
  final String description;
  final String? image;

  CategoryInfo({
    required this.id,
    required this.name,
    required this.description,
    this.image,
  });

  factory CategoryInfo.fromJson(
      Map<String, dynamic> json,
      ) {
    return CategoryInfo(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      image: json["image"],
    );
  }
}

class CategoryProduct {
  final int id;
  final int vendorId;
  final String vendorName;

  final String name;
  final String description;

  final double price;
  final double? discountPrice;

  final String? image;

  final bool available;

  CategoryProduct({
    required this.id,
    required this.vendorId,
    required this.vendorName,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    this.image,
    required this.available,
  });

  factory CategoryProduct.fromJson(
      Map<String, dynamic> json,
      ) {
    return CategoryProduct(
      id: json["id"],

      vendorId: json["vendor_id"] ?? 0,

      vendorName: json["vendor"] ?? "",

      name: json["name"] ?? "",

      description: json["description"] ?? "",

      price: double.parse(
        json["price"].toString(),
      ),

      discountPrice: json["discount_price"] == null
          ? null
          : double.parse(
        json["discount_price"].toString(),
      ),

      image: json["image"],

      available: json["is_available"] ?? true,
    );
  }
}