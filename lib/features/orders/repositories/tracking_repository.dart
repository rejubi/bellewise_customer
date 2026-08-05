import '../../../core/api/api_client.dart';
import '../models/tracking_model.dart';

class TrackingRepository {
  Future<TrackingModel> getTracking(
      int orderId,
      ) async {
    final response = await ApiClient.dio.get(
      "/orders/$orderId/tracking/",
    );

    return TrackingModel.fromJson(
      response.data,
    );
  }
}