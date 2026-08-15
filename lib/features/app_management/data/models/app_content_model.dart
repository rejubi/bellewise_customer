class AppContentModel {
  final int id;
  final String contentType;
  final String contentTypeDisplay;
  final String title;
  final String slug;
  final String content;
  final String targetApp;
  final String targetAppDisplay;
  final String updatedAt;

  const AppContentModel({
    required this.id,
    required this.contentType,
    required this.contentTypeDisplay,
    required this.title,
    required this.slug,
    required this.content,
    required this.targetApp,
    required this.targetAppDisplay,
    required this.updatedAt,
  });

  factory AppContentModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AppContentModel(
      id: json["id"] ?? 0,
      contentType: json["content_type"] ?? "",
      contentTypeDisplay:
      json["content_type_display"] ?? "",
      title: json["title"] ?? "",
      slug: json["slug"] ?? "",
      content: json["content"] ?? "",
      targetApp: json["target_app"] ?? "",
      targetAppDisplay:
      json["target_app_display"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}