import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/similarMovies/model/similarmovies_model.dart';

class SimilarMovieService {
  var dio = new Dio();

  Future<List<Result>> getMovies(int page, int id, bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=XXX&page=$page&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/movie/$id/recommendations?api_key=XXX&page=$page';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      SimilarMoviesModel result = SimilarMoviesModel.fromJson(responseBody);
      return result.results;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
