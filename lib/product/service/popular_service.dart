import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/popularMovies/model/popularmovies_model.dart';

class PopularService {
  var dio = new Dio();

  Future<List<Result>> getMovies(int page) async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=3af7f4422f5644de486084c74816093a&page=$page';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      PopularMoviesModel result = PopularMoviesModel.fromJson(responseBody);
      return result.results;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
