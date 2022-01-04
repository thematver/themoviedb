import 'package:themoviedb/model/movie.dart';
import 'package:themoviedb/services/movies_client.dart';

class MoviesRepository {
  final MoviesClient _client = MoviesClient();

  Future<List<Movie>> fetchDiscovery({
    required int page,
  }) async {
    return await _client.fetchDiscover(page: page);
  }

  Future<List<Movie>> search({
    int page = 1,
    String? query = "",
  }) async {
    return await _client.search(query: query!, page: page);
  }
}
