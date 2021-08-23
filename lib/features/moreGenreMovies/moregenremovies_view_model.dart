import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/moreGenreMovies/model/moreGenreMovies_model.dart';
import 'package:staj_projesi_movie_collector/features/moreGenreMovies/moregenremovies.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/moregenremovie_service.dart';

abstract class MoreGenreMovieViewModel extends State<MoreGenreMovies> {
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
    debugPrint("initstate" + widget.genreIdList.toString());
    getCurrentGenreMovies(resultPage, widget.genreIdList);
    genreScrollController = ScrollController();
    genreScrollController.addListener(() {
      if (genreScrollController.position.atEdge) {
        if (genreScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPage++;
            getCurrentGenreMovies(resultPage, widget.genreIdList);
          });
        }
      }
    });
  }

  Future<void> getCurrentGenreMovies(int page, List<int> genreIdList) async {
    currentGenreMovies = await context.read<MoreGenreService>().getMovies(
        page, genreIdList, context.read<CurrentLanguage>().turkishLang);
    debugPrint("CURRENT GENRE " + currentGenreMovies.toString());
    if (currentGenreMovies.length != 0) {
      if (listEquals(_oldResult, currentGenreMovies) == false) {
        resultGenreMovies += currentGenreMovies;
      } else {
        resultGenreMovies = resultGenreMovies;
      }
      _oldResult = currentGenreMovies;
    } else {
      resultGenreMovies = null;
      debugPrint('ELSETEYİM');
    }

    setState(() {});
  }
}
