import '../data/home_repository.dart';
import '../models/home_model.dart';

class HomeController {
  final HomeRepository repository = HomeRepository();

  Future<HomeModel> loadHome() {
    return repository.loadHome();
  }
}