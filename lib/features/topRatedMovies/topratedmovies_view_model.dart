import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/product/service/toprated_service.dart';
import 'model/topratedmovies_model.dart';
import 'topratedmovies.dart';
import 'package:provider/provider.dart';

abstract class TopRatedMovieViewModel extends State<TopRatedMovies> {
  List<Result> topRatedMovies = [];
  List<Result> _oldResult = [];
  List<Result> resultTopRatedMovies = [];
  ScrollController topRatedScrollController;
  int resultTopRatedPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultTopRatedPage = 1;
    getMovies(resultTopRatedPage);
    topRatedScrollController = ScrollController();
    topRatedScrollController.addListener(() {
      if (topRatedScrollController.position.atEdge) {
        if (topRatedScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultTopRatedPage++;
            getMovies(resultTopRatedPage);
          });
        }
      }
    });
  }

  Future<void> getMovies(int page) async {
    topRatedMovies = await context.read<TopRatedService>().getMovies(page);
    if (listEquals(_oldResult, topRatedMovies) == false) {
      resultTopRatedMovies += topRatedMovies;
    } else {
      resultTopRatedMovies = resultTopRatedMovies;
    }
    _oldResult = topRatedMovies;
    setState(() {});
  }
}
