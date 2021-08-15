import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:staj_projesi_movie_collector/features/topRatedMovies/model/topratedmovies_model.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';

class TopRatedService {
  var dio = new Dio();

  Future<List<Result>> getMovies(int page, bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/movie/top_rated?api_key=3af7f4422f5644de486084c74816093a&page=$page&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/movie/top_rated?api_key=3af7f4422f5644de486084c74816093a&page=$page';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;

      TopRatedMoviesModel result = TopRatedMoviesModel.fromJson(responseBody);

      return result.results;
    } else {
      throw Exception("Filmler getirilemedi");
    }
  }
}
