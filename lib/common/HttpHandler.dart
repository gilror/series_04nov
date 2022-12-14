import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/common/Constants.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/model/Media.dart';

class HttpHandler {
  static final _httpHandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org";
  final String _languaje = "es-MX";

  static HttpHandler get() {
    return _httpHandler;
  }

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.get(uri);
    return json.decode(response.body);
  }

  Future<List<Media>> fetchMovies({String? category}) async {
    var uri = new Uri.https(_baseUrl, "3/movie/$category",
        {'api_key': API_KEY, 'page': "1", 'language': _languaje});

    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.movie))
        .toList()));
  }

  Future<List<Media>> fetchSeries({String? category}) async {
    var uri = new Uri.https(_baseUrl, "3/tv/$category",
        {'api_key': API_KEY, 'page': "1", 'language': _languaje});

    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.serie))
        .toList()));
  }
}
