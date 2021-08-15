import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/currentgenremovie_service.dart';

import 'genremovies.dart';
import 'model/genreMovies_model.dart';

abstract class GenreMovieViewModel extends State<GenreMovies> {
  List<Result> currentGenreMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultGenreMovies = [];
  ScrollController genreScrollController;
  int resultPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultPage = 1;
    getCurrentGenreMovies(resultPage, widget.genreId);
    genreScrollController = ScrollController();
    genreScrollController.addListener(() {
      if (genreScrollController.position.atEdge) {
        if (genreScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPage++;
            getCurrentGenreMovies(resultPage, widget.genreId);
          });
        }
      }
    });
  }

  Future<void> getCurrentGenreMovies(int page, int genre) async {
    currentGenreMovies = await context
        .read<CurrentGenreService>()
        .getMovies(page, genre, context.read<CurrentLanguage>().turkishLang);
    if (listEquals(_oldResult, currentGenreMovies) == false) {
      resultGenreMovies += currentGenreMovies;
    } else {
      resultGenreMovies = resultGenreMovies;
    }
    _oldResult = currentGenreMovies;
    setState(() {});
  }
}
