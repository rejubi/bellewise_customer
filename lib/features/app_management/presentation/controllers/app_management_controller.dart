import 'package:flutter/foundation.dart';

import '../../data/models/announcement_model.dart';
import '../../data/models/app_content_model.dart';
import '../../data/models/faq_model.dart';
import '../../data/repositories/app_management_repository.dart';

class AppManagementController
    extends ChangeNotifier {

  AppManagementController({
    AppManagementRepository? repository,
  }) : _repository =
      repository ?? AppManagementRepository();

  final AppManagementRepository _repository;

  bool isLoading = false;
  String? errorMessage;

  List<AppContentModel> contents = [];
  List<FaqModel> faqs = [];
  List<AnnouncementModel> announcements = [];

  Future<void> loadAll() async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getContent(),
        _repository.getFaqs(),
        _repository.getAnnouncements(),
      ]);

      contents =
      results[0] as List<AppContentModel>;

      faqs =
      results[1] as List<FaqModel>;

      announcements =
      results[2]
      as List<AnnouncementModel>;
    } catch (e) {
      errorMessage =
      "Unable to load app information.";
      debugPrint(
        "App Management Error: $e",
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<AppContentModel?> getContentBySlug(
      String slug,
      ) async {
    try {
      return await _repository
          .getContentBySlug(slug);
    } catch (e) {
      debugPrint(
        "Content Error: $e",
      );

      return null;
    }
  }
}