import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/latestMovies/model/latestmovie_model.dart';

class LatestService {
  var dio = new Dio();

  Future<List<Result>> getMovies(int page, bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/movie/now_playing?api_key=XXX&page=$page&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/movie/now_playing?api_key=XXX&page=$page';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;

      LatestMoviesModel result = LatestMoviesModel.fromJson(responseBody);

      return result.results;
    } else {
      throw Exception('Filmler getirilemedi');
    }
  }
}
