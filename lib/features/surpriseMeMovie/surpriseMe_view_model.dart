import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/model/moviedetails_model.dart';
import 'package:staj_projesi_movie_collector/features/similarMovies/model/similarmovies_model.dart';
import 'package:staj_projesi_movie_collector/features/surpriseMeMovie/surpriseMe.dart';
import 'package:staj_projesi_movie_collector/product/service/firestore_service.dart';
import 'package:staj_projesi_movie_collector/product/service/moviedetail_service.dart';
import 'package:staj_projesi_movie_collector/product/service/similarmovies_service.dart';

abstract class SurpriseMeViewModel extends State<SurpriseMe> {
  MovieDetailsModel movieDetail;
  FirestoreService firestoreService;

  bool watchlistIconBool;
  bool favoritesIconBool;
  bool watchedIconBool;
  List<Result> _similarMovies = [];
  int id;
  String firebaseMovieTitle;
  var rng = new Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomMovieFromFs().then((value) => getMovies());

    firestoreService = FirestoreService();
  }

  Future getRandomMovieFromFs() async {
    debugPrint('önce burası calist');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Saves')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Favorites')
        .get();

    List<String> movieIdList = [];

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      movieIdList.add(querySnapshot.docs[i]['movieId']);
    }

    int randomId = int.parse(movieIdList[rng.nextInt(movieIdList.length)]);
    _similarMovies =
        await context.read<SimilarMovieService>().getMovies(1, randomId);

    debugPrint('favorilerden secilen rastgele film id: ' + randomId.toString());
    debugPrint('benzeri seçilen film id: ' +
        _similarMovies[rng.nextInt(_similarMovies.length)].id.toString());

    setState(() {
      this.id = _similarMovies[rng.nextInt(_similarMovies.length)].id;
    });
  }

  Future<void> getMovies() async {
    debugPrint('sonra burasi');
    movieDetail = await context.read<MovieDetailService>().getMovie(this.id);

    watchlistIconBool =
        await firestoreService.watchlistIcon(this.id.toString());

    favoritesIconBool =
        await firestoreService.favoritesIcon(this.id.toString());

    watchedIconBool = await firestoreService.watchedIcon(this.id.toString());
    setState(() {});
  }
}
