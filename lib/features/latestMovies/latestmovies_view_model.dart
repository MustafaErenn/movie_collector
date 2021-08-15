import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/latestMovies/latestmovies.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/latest_service.dart';
import 'model/latestmovie_model.dart';

abstract class LatestMovieViewModel extends State<LatestMovies> {
  List<Result> latestMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultLatestMovies = [];
  ScrollController latestScrollController;
  int resultPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultPage = 1;
    getMovies(resultPage);
    latestScrollController = ScrollController();
    latestScrollController.addListener(() {
      if (latestScrollController.position.atEdge) {
        if (latestScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPage++;
            getMovies(resultPage);
          });
        }
      }
    });
  }

  Future<void> getMovies(int page) async {
    latestMovies = await context
        .read<LatestService>()
        .getMovies(page, context.read<CurrentLanguage>().turkishLang);
    if (listEquals(_oldResult, latestMovies) == false) {
      // latestMovies.sort((b, a) => a.releaseDate.compareTo(b.releaseDate));
      resultLatestMovies += latestMovies;
    } else {
      resultLatestMovies = resultLatestMovies;
    }
    _oldResult = latestMovies;

    setState(() {});
  }
}
