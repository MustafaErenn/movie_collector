import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
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
  bool fsBool;
  var rng = new Random();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomMovieFromFs().then((value) => getMovies());

    firestoreService = FirestoreService();
  }

  Future getRandomMovieFromFs() async {
    QuerySnapshot favoriteQuerySnapshot = await FirebaseFirestore.instance
        .collection('Saves')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Favorites')
        .get();

    if (favoriteQuerySnapshot.docs.length != 0) {
      List<String> favoritesMovieIdList = [];
      List<String> favoritesMovieNameList = [];

      for (int i = 0; i < favoriteQuerySnapshot.docs.length; i++) {
        favoritesMovieIdList.add(favoriteQuerySnapshot.docs[i]['movieId']);
        favoritesMovieNameList.add(favoriteQuerySnapshot.docs[i]['movieTitle']);
      }

      var zipped = zip([favoritesMovieIdList, favoritesMovieNameList]).toList();
      int randomNumber = rng.nextInt(favoritesMovieIdList.length);
      int randomId = int.parse(zipped[randomNumber][0]);

      _similarMovies =
          await context.read<SimilarMovieService>().getMovies(1, randomId);
      _similarMovies +=
          await context.read<SimilarMovieService>().getMovies(2, randomId);
      debugPrint(
          'favorilerden secilen rastgele film id: ' + randomId.toString());

      int newId;
      while (true) {
        int randomIndex = rng.nextInt(_similarMovies.length);
        String similarMovieId = _similarMovies[randomIndex].id.toString();
        debugPrint('benzeri seçilen film id: ' + similarMovieId);
        if (!favoritesMovieIdList.contains(similarMovieId)) {
          newId = int.parse(similarMovieId);
          break;
        }
      }

      setState(() {
        firebaseMovieTitle = zipped[randomNumber][1];
        fsBool = true;
        this.id = newId;
      });
    } else {
      setState(() {
        debugPrint('hic favori yok ');
        fsBool = false;
      });
    }
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
