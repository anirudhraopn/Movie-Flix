import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetDetails extends GetxController {
  List<dynamic> _nowPlayingItems = [].obs();
  List<dynamic> _topRatedItems = [].obs();

  late List<dynamic> _allMovies;
  static const baseUrl = 'https://api.themoviedb.org/3/movie';
  static const String imageUrl = 'https://image.tmdb.org/t/p/w342';
  static const backdropUrl = 'https://image.tmdb.org/t/p/original';
  static const apiKey = 'a07e22bc18f5cb106bfe4cc1f83ad8ed';
  final nowPlayingUrl = '$baseUrl/now_playing?api_key=$apiKey';

  final topRatedUrl = '$baseUrl/top_rated?api_key=$apiKey';

  List<dynamic> get nowPlayingItems {
    return _nowPlayingItems;
  }

  List<dynamic> get topRatedItems {
    return _topRatedItems;
  }

  Future<void> getDetailsNowPlaying() async {
    try {
      final response = await http.get(
        Uri.parse(nowPlayingUrl),
      );

      final extractedData = jsonDecode(response.body);
      // print(extractedData['results']);
      _nowPlayingItems = (extractedData['results']);
      // print(_nowPlayingItems);
      update();
    } catch (e) {
      // print(e);
      rethrow;
    }

    // print(e);
  }

  void deleteMovie(int id) {
    _nowPlayingItems.removeWhere((element) => element['id'] == id);
    _topRatedItems.removeWhere((element) => element['id'] == id);
    update();
  }

  List get allMovies {
    return _allMovies;
  }

  Future<void> getDetailsTopRated() async {
    final response = await http.get(
      Uri.parse(topRatedUrl),
    );

    final extractedData = jsonDecode(response.body);
    _topRatedItems = (extractedData['results']);
    _allMovies = [
      ..._nowPlayingItems,
      ..._topRatedItems,
    ];
    update();
    // print(_topRatedItems);
  }
}
