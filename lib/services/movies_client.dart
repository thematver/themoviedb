import 'dart:convert';

import 'package:themoviedb/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:themoviedb/view/view.dart';

class MoviesClient {
  MoviesClient._internal();

  static final MoviesClient _instance = MoviesClient._internal();
  final http.Client _client = http.Client();
  final String baseUrl = "api.themoviedb.org";

  factory MoviesClient() {
    return _instance;
  }

  Future<List<Movie>> fetchDiscover({
    int page = 1,
  }) async {
    try {
      var response = await _client.get(
        Uri.https(baseUrl, '/3/discover/movie', {
          "api_key": Constants.apiKey,
          "page": page.toString(),
          "language": "ru-RU",
        }),
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse['results']
          .map<Movie>(
            (movie) => Movie.fromJson(movie),
          )
          .toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Movie>> search({
    int page = 1,
    required String query,
  }) async {
    if (query == "") return Future.error("An empty query");
    try {
      var response = await _client.get(
        Uri.https(baseUrl, '/3/search/movie', {
          "api_key": Constants.apiKey,
          "page": page.toString(),
          "language": "ru-RU",
          "query": query,
        }),
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

      return decodedResponse['results']
          .map<Movie>(
            (movie) => Movie.fromJson(movie),
          )
          .toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
