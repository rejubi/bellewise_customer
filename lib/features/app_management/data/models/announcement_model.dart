class AnnouncementModel {
  final int id;
  final String title;
  final String message;
  final String targetApp;
  final String targetAppDisplay;
  final String? publishAt;
  final String? expiresAt;
  final String createdAt;
  final String updatedAt;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
    required this.targetApp,
    required this.targetAppDisplay,
    required this.publishAt,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnnouncementModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AnnouncementModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      message: json["message"] ?? "",
      targetApp: json["target_app"] ?? "",
      targetAppDisplay:
      json["target_app_display"] ?? "",
      publishAt: json["publish_at"],
      expiresAt: json["expires_at"],
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}