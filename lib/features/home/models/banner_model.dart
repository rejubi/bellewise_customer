class BannerModel {
  final int id;
  final String image;
  final String title;

  const BannerModel({
    required this.id,
    required this.image,
    required this.title,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image: json['image'],
      title: json['title'],
    );
  }
}