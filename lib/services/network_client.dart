import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:themoviedb/view/view.dart';

class NetworkClient {
  NetworkClient._internal();

  static final NetworkClient _instance = NetworkClient._internal();
  final http.Client _client = http.Client();
  final String baseUrl = "api.themoviedb.org";

  factory NetworkClient() {
    return _instance;
  }

  void fetchDiscover({
    int page = 1,
    required Function(List<Movie>?) onSuccess,
    required Function(Object) onError,
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
      var movies = decodedResponse['results']
          .map<Movie>(
            (movie) => Movie.fromJson(movie),
          )
          .toList();
      onSuccess(movies);
    } catch (e) {
      onError(e);
    }
  }
}
