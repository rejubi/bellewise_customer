class AppSettingModel {
  final String key;
  final String value;
  final String description;
  final String targetApp;
  final String targetAppDisplay;
  final String updatedAt;

  const AppSettingModel({
    required this.key,
    required this.value,
    required this.description,
    required this.targetApp,
    required this.targetAppDisplay,
    required this.updatedAt,
  });

  factory AppSettingModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return AppSettingModel(
      key: json["key"] ?? "",
      value: json["value"] ?? "",
      description: json["description"] ?? "",
      targetApp: json["target_app"] ?? "",
      targetAppDisplay:
      json["target_app_display"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}