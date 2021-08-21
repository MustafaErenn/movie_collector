import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/searchmovies.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/delay_service.dart';
import 'package:staj_projesi_movie_collector/product/service/searchmovie_service.dart';
import 'model/searchmovies_model.dart';

abstract class SearchMovieViewModel extends State<SearchMovies> {
  TextEditingController controller;

  List<Result> searchMovies = [];
  List<Result> _oldResult = [];

  List<Result> resultSearchMovies = [];
  ScrollController searchScrollController;
  int resultPage;

  final Debouncer onSearchDebouncer =
      new Debouncer(delay: new Duration(milliseconds: 2000));
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
            getMovies(resultPage, controller.text.trim());
          });
        }
      }
    });

    controller.addListener(() {
      this.onSearchDebouncer.debounce(() {
        setState(() {
          resultSearchMovies = [];
          searchMovies = [];
          resultPage = 1;
          getMovies(resultPage, controller.text.trim());
        });

        if (controller.text.isEmpty) {
          setState(() {
            resultSearchMovies = [];
            resultPage = 1;
            getMovies(resultPage, controller.text.trim());
          });
        }
      });
    });
  }

  Future<void> getMovies(int page, String name) async {
    searchMovies = await context
        .read<SearchMovieService>()
        .getMovies(page, name, context.read<CurrentLanguage>().turkishLang);
    if (listEquals(_oldResult, searchMovies) == false) {
      resultSearchMovies += searchMovies;
    } else {
      resultSearchMovies = resultSearchMovies;
    }
    _oldResult = searchMovies;
    setState(() {});
  }
}
