import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/searchmovies.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/service/searchmovie_service.dart';
import 'model/searchmovies_model.dart';

abstract class SearchMovieViewModel extends State<SearchMovies> {
  TextEditingController controller;

  List<Result> searchMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultSearchMovies = [];
  ScrollController searchScrollController;
  int resultPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
    resultPage = 1;

    searchScrollController = ScrollController();
    searchScrollController.addListener(() {
      if (searchScrollController.position.atEdge) {
        if (searchScrollController.position.pixels == 0) {
          print("Top");
        } else {
          setState(() {
            resultPage++;
            getMovies(resultPage, controller.text);
          });
        }
      }
    });

    controller.addListener(() {
      setState(() {
        resultSearchMovies = [];
        searchMovies = [];
        getMovies(resultPage, controller.text);
      });

      if (controller.text == '') {
        debugPrint('TEMIZLENDI');
        setState(() {
          resultSearchMovies = [];
          getMovies(resultPage, controller.text);
        });
      }
    });
  }

  Future<void> getMovies(int page, String name) async {
    debugPrint('GET MOVİES CALİSTİ');
    searchMovies =
        await context.read<SearchMovieService>().getMovies(page, name);
    if (listEquals(_oldResult, searchMovies) == false) {
      searchMovies.sort((b, a) => a.voteAverage.compareTo(b.voteAverage));
      resultSearchMovies += searchMovies;
    } else {
      resultSearchMovies = resultSearchMovies;
    }
    _oldResult = searchMovies;
    setState(() {});
  }
}
