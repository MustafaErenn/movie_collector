import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

      Fluttertoast.showToast(
        msg: "Removed from your watchlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      DocumentSnapshot documentSnapshot = await _firestore
          .collection("Saves")
          .doc(_auth.currentUser.uid)
          .collection("Watched")
          .doc(movie.movieId)
          .get();
      if (documentSnapshot.exists) {
        Fluttertoast.showToast(
          msg: "You already watched this movie.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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

        Fluttertoast.showToast(
          msg: "Added to watchlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
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

      Fluttertoast.showToast(
        msg: "Removed from your favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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

      Fluttertoast.showToast(
        msg: "Added to favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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

      Fluttertoast.showToast(
        msg: "Removed from your watched list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
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

        Fluttertoast.showToast(
          msg: "Removing from watchlist because you added movie to watched.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
        Fluttertoast.showToast(
          msg: "Added to watched list",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
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
