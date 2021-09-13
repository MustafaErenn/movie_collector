import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/genreMovies/model/genreMovies_model.dart';

class CurrentGenreService {
  var dio = new Dio();

  CurrentGenreService() {
    dio = Dio(
      BaseOptions(baseUrl: "https://api.themoviedb.org"),
    );
  }

  Future<List<Result>> getMovies(int page, int genre, bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/discover/movie?api_key=XXX&with_genres=$genre&page=$page&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/discover/movie?api_key=XXX&with_genres=$genre&page=$page';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      GenreMoviesModel result = GenreMoviesModel.fromJson(responseBody);
      return result.results;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
