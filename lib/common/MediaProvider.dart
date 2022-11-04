import 'dart:async';
import 'package:movie_app/model/Media.dart';
import 'package:movie_app/common/HttpHandler.dart';

abstract class MediaProvider {
  // Future<List<Media>> fetchMedia();
  Future<List<Media>> fetchMedia(String category);
}

class MoviesProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchMovies(category: category);
  }
}

class SeriesProvider extends MediaProvider {
  HttpHandler _client = HttpHandler.get();
  @override
  Future<List<Media>> fetchMedia(String category) {
    return _client.fetchSeries(category: category);
  }
}

enum MediaType { movie, serie }
