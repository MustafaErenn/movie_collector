import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/model/moviedetails_model.dart';
import 'package:staj_projesi_movie_collector/features/surpriseMeMovie/surpriseMe.dart';
import 'package:staj_projesi_movie_collector/product/service/firestore_service.dart';
import 'package:staj_projesi_movie_collector/product/service/moviedetail_service.dart';

abstract class SurpriseMeViewModel extends State<SurpriseMe> {
  MovieDetailsModel movieDetail;
  FirestoreService firestoreService;

  bool watchlistIconBool;
  bool favoritesIconBool;
  bool watchedIconBool;

  int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMovies();

    firestoreService = FirestoreService();
  }

  Future<void> getMovies() async {
    movieDetail = await context.read<MovieDetailService>().getMovie(this.id);

    watchlistIconBool =
        await firestoreService.watchlistIcon(this.id.toString());

    favoritesIconBool =
        await firestoreService.favoritesIcon(this.id.toString());

    watchedIconBool = await firestoreService.watchedIcon(this.id.toString());
    setState(() {});
  }
}
