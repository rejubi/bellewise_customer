import '../models/announcement_model.dart';
import '../models/app_content_model.dart';
import '../models/app_setting_model.dart';
import '../models/faq_model.dart';
import '../services/app_management_service.dart';

class AppManagementRepository {
  AppManagementRepository({
    AppManagementService? service,
  }) : _service =
      service ?? AppManagementService.instance;

  final AppManagementService _service;

  Future<List<AppContentModel>> getContent() async {
    final data = await _service.getContent();

    return data
        .map(
          (item) => AppContentModel.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  Future<AppContentModel> getContentBySlug(
      String slug,
      ) async {
    final data =
    await _service.getContentBySlug(slug);

    return AppContentModel.fromJson(data);
  }

  Future<List<FaqModel>> getFaqs() async {
    final data = await _service.getFaqs();

    return data
        .map(
          (item) => FaqModel.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  Future<List<AnnouncementModel>>
  getAnnouncements() async {
    final data =
    await _service.getAnnouncements();

    return data
        .map(
          (item) => AnnouncementModel.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }

  Future<List<AppSettingModel>>
  getSettings() async {
    final data =
    await _service.getSettings();

    return data
        .map(
          (item) => AppSettingModel.fromJson(
        Map<String, dynamic>.from(item),
      ),
    )
        .toList();
  }
}