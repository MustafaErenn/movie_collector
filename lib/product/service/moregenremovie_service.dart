import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:staj_projesi_movie_collector/features/moreGenreMovies/model/moreGenreMovies_model.dart';

class MoreGenreService {
  var dio = new Dio();

  MoreGenreService() {
    dio = Dio(
      BaseOptions(baseUrl: "https://api.themoviedb.org"),
    );
  }

  Future<List<Result>> getMovies(
      int page, List<int> genreList, bool turkLang) async {
    String url;
    String genreUrl = '';
    String virgul = ",";

    for (int i = 0; i < genreList.length; i++) {
      genreUrl = (genreList[i].toString() + virgul) + genreUrl;
    }

    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/discover/movie?api_key=XXX&with_genres=$genreUrl&page=$page&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/discover/movie?api_key=XXX&with_genres=$genreUrl&page=$page';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      MoreGenreModel result = MoreGenreModel.fromJson(responseBody);
      return result.results;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
