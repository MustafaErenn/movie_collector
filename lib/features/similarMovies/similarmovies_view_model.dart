import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/similarmovies_service.dart';
import 'model/similarmovies_model.dart';
import 'similarmovies.dart';

abstract class SimilarMovieViewModel extends State<SimilarMovies> {
  List<Result> similarMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultSimilarMovies = [];
  ScrollController similarScrollController;
  int resultPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultPage = 1;
    getMovies(resultPage, widget.id);
    similarScrollController = ScrollController();
    similarScrollController.addListener(() {
      if (similarScrollController.position.atEdge) {
        if (similarScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPage++;
            getMovies(resultPage, widget.id);
          });
        }
      }
    });
  }

  Future<void> getMovies(int page, int id) async {
    similarMovies = await context
        .read<SimilarMovieService>()
        .getMovies(page, id, context.read<CurrentLanguage>().turkishLang);
    if (listEquals(_oldResult, similarMovies) == false) {
      resultSimilarMovies += similarMovies;
    } else {
      resultSimilarMovies = resultSimilarMovies;
    }
    _oldResult = similarMovies;
    setState(() {});
  }
}
