import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/searchbygenre_service.dart';
import 'package:provider/provider.dart';
import 'model/searchbygenre_model.dart';
import 'searchbygenre.dart';

abstract class SearchByGenreViewModel extends State<SearchByGenre> {
  List<Genre> allGenres = [];
  List<int> selectedItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getGenres();
  }

  Future<void> getGenres() async {
    allGenres = await context
        .read<SearchByGenreService>()
        .getMovies(context.read<CurrentLanguage>().turkishLang);

    setState(() {});
  }
}
