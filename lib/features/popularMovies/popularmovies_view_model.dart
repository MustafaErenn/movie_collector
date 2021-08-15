import 'package:staj_projesi_movie_collector/features/popularMovies/popularmovies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/popular_service.dart';
import 'model/popularmovies_model.dart';

abstract class PopularMovieViewModel extends State<PopularMovies> {
  List<Result> popularMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultPopularMovies = [];

  ScrollController popularScrollController;

  int resultPopularPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies(resultPopularPage);
    resultPopularPage = 1;
    getMovies(resultPopularPage);
    popularScrollController = ScrollController();
    popularScrollController.addListener(() {
      if (popularScrollController.position.atEdge) {
        if (popularScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPopularPage++;
            getMovies(resultPopularPage);
          });
        }
      }
    });
  }

  Future<void> getMovies(int page) async {
    popularMovies = await context
        .read<PopularService>()
        .getMovies(page, context.read<CurrentLanguage>().turkishLang);
    if (listEquals(_oldResult, popularMovies) == false) {
      resultPopularMovies += popularMovies;
    } else {
      resultPopularMovies = resultPopularMovies;
    }
    _oldResult = popularMovies;
    setState(() {});
  }
}
