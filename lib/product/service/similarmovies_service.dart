import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/similarMovies/model/similarmovies_model.dart';

class SimilarMovieService {
  var dio = new Dio();

  Future<List<Result>> getMovies(int page, int id) async {
    String url =
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=3af7f4422f5644de486084c74816093a&language=en-US&page=$page';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      SimilarMoviesModel result = SimilarMoviesModel.fromJson(responseBody);
      return result.results;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
