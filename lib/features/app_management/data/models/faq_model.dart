class FaqModel {
  final int id;
  final String question;
  final String answer;
  final String category;
  final String targetApp;
  final String targetAppDisplay;
  final int displayOrder;
  final String updatedAt;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.targetApp,
    required this.targetAppDisplay,
    required this.displayOrder,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return FaqModel(
      id: json["id"] ?? 0,
      question: json["question"] ?? "",
      answer: json["answer"] ?? "",
      category: json["category"] ?? "",
      targetApp: json["target_app"] ?? "",
      targetAppDisplay:
      json["target_app_display"] ?? "",
      displayOrder: json["display_order"] ?? 0,
      updatedAt: json["updated_at"] ?? "",
    );
  }
}
