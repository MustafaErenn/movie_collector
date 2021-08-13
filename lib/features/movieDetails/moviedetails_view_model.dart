import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/product/service/firestore_service.dart';
import 'package:staj_projesi_movie_collector/product/service/moviedetail_service.dart';

import 'model/moviedetails_model.dart';
import 'moviedetails.dart';

abstract class MovieDetailsViewModel extends State<MovieDetails> {
  MovieDetailsModel movieDetail;
  FirestoreService firestoreService;

  bool watchlistIconBool;
  bool favoritesIconBool;
  bool watchedIconBool;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();

    firestoreService = FirestoreService();
  }

  Future<void> getMovies() async {
    movieDetail = await context.read<MovieDetailService>().getMovie(widget.id);

    watchlistIconBool =
        await firestoreService.watchlistIcon(widget.id.toString());

    favoritesIconBool =
        await firestoreService.favoritesIcon(widget.id.toString());

    watchedIconBool = await firestoreService.watchedIcon(widget.id.toString());
    setState(() {});
  }
}
