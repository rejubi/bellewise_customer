import '../models/search_model.dart';
import 'search_api.dart';

class SearchRepository {
  final SearchApi api = SearchApi();

  Future<SearchModel> search(
      String query,
      ) async {
    final response = await api.search(query);

    return SearchModel.fromJson(
      response.data,
    );
  }
}