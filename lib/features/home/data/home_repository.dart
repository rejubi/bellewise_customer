import '../models/home_model.dart';
import 'home_api.dart';

class HomeRepository {
  final HomeApi api = HomeApi();

  Future<HomeModel> loadHome() async {
    final response = await api.getHomeData();
    return HomeModel.fromJson(response.data);
  }
}