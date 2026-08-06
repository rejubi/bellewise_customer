import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';
import '../models/tracking_model.dart';

class TrackingRepository {
  Future<TrackingModel> getTracking(
      int orderId,
      ) async {
    final response = await ApiClient.dio.get(
      Endpoints.orderTracking(orderId),
    );

    return TrackingModel.fromJson(
      response.data,
    );
  }
}