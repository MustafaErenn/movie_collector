import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/model/moviedetails_model.dart';

class MovieDetailService {
  var dio = new Dio();

  Future<MovieDetailsModel> getMovie(int id, bool turkLang) async {
    String url;
    if (turkLang) {
      url =
          'https://api.themoviedb.org/3/movie/$id?api_key=XXX&language=tr';
    } else {
      url =
          'https://api.themoviedb.org/3/movie/$id?api_key=XXX';
    }

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final responseBody = response.data;
      MovieDetailsModel result = MovieDetailsModel.fromJson(responseBody);
      return result;
    }
    throw Exception("Filmler getirilirken hata oluştu");
  }
}
