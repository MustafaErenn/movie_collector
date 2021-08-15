import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/model/searchmovies_model.dart';

class SearchMovieService {
  var dio = new Dio();

  SearchMovieService() {
    dio = Dio(
      BaseOptions(baseUrl: "https://api.themoviedb.org"),
    );
  }

  Future<List<Result>> getMovies(int page, String name, bool turkLang) async {
    if (name != '') {
      String url;
      if (turkLang) {
        url =
            'https://api.themoviedb.org/3/search/movie?api_key=3af7f4422f5644de486084c74816093a&page=$page&query=$name&language=tr';
      } else {
        url =
            'https://api.themoviedb.org/3/search/movie?api_key=3af7f4422f5644de486084c74816093a&page=$page&query=$name';
      }

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final responseBody = response.data;
        SearchMoviesModel result = SearchMoviesModel.fromJson(responseBody);
        return result.results;
      }
      throw Exception("Filmler getirilirken hata oluştu");
    } else {
      return [];
    }
  }
}
