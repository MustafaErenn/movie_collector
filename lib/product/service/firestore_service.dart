import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/product/model/firestore_movie_model.dart';

class FirestoreService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future flipWatchlist(Movie movie) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Saves")
        .doc(_auth.currentUser.uid)
        .collection("Watchlist")
        .doc(movie.movieId)
        .get();

    if (documentSnapshot.exists) {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Watchlist")
          .doc(movie.movieId)
          .delete();
    } else {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Watchlist")
          .doc(movie.movieId)
          .set({
        "movieId": movie.movieId.toString(),
        "movieTitle": movie.movieTitle.toString(),
        "moviePosterPath": movie.moviePosterPath.toString(),
        "movieRating": movie.movieRating.toString(),
      });
    }
  }

  Future<bool> watchlistIcon(String id) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Saves")
        .doc(_auth.currentUser.uid)
        .collection("Watchlist")
        .doc(id)
        .get();
    if (documentSnapshot.exists) {
      return false;
    } else {
      return true; // add
    }
  }

  Future flipFavorites(Movie movie) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection('Saves')
        .doc(_auth.currentUser.uid)
        .collection("Favorites")
        .doc(movie.movieId)
        .get();

    if (documentSnapshot.exists) {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Favorites")
          .doc(movie.movieId)
          .delete();
    } else {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Favorites")
          .doc(movie.movieId)
          .set({
        "movieId": movie.movieId.toString(),
        "movieTitle": movie.movieTitle.toString(),
        "moviePosterPath": movie.moviePosterPath.toString(),
        "movieRating": movie.movieRating.toString(),
      });
    }
  }

  Future<bool> favoritesIcon(String id) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Saves")
        .doc(_auth.currentUser.uid)
        .collection("Favorites")
        .doc(id)
        .get();

    if (documentSnapshot.exists) {
      return false;
    } else {
      return true; // add
    }
  }

  Future flipWatched(Movie movie) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Saves")
        .doc(_auth.currentUser.uid)
        .collection("Watched")
        .doc(movie.movieId)
        .get();

    if (documentSnapshot.exists) {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Watched")
          .doc(movie.movieId)
          .delete();
    } else {
      await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Watched")
          .doc(movie.movieId)
          .set({
        "movieId": movie.movieId.toString(),
        "movieTitle": movie.movieTitle.toString(),
        "moviePosterPath": movie.moviePosterPath.toString(),
        "movieRating": movie.movieRating.toString(),
      });
    }
  }

  Future<bool> watchedIcon(String id) async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection("Saves")
        .doc(_auth.currentUser.uid)
        .collection("Watched")
        .doc(id)
        .get();

    if (documentSnapshot.exists) {
      return false;
    } else {
      return true;
    }
  }
}
