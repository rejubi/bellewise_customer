import '../data/search_repository.dart';
import '../models/search_model.dart';

class SearchApiController {
  final SearchRepository repository = SearchRepository();

  Future<SearchModel> search(String query) {
    return repository.search(query);
  }
}