import 'package:dio/dio.dart';
import 'package:staj_projesi_movie_collector/features/searchByGenreMovies/model/searchbygenre_model.dart';

class SearchByGenreService {
  var dio = new Dio();

  // ignore: non_constant_identifier_names
  SearchMovieService() {
    dio = Dio(
      BaseOptions(baseUrl: "https://api.themoviedb.org"),
    );
  }

  Future<List<Genre>> getMovies(bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=3af7f4422f5644de486084c74816093a&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=3af7f4422f5644de486084c74816093a';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      GenreModel result = GenreModel.fromJson(responseBody);
      return result.genres;
    }
    throw Exception("Kategoriler getirilirken hata oluştu");
  }
}
