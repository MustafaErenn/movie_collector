import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/favoritesMovies/favoritesmovies.dart';

abstract class FavoriteMovieViewModel extends State<FavoritesMovies> {
  final Stream<QuerySnapshot> favoritesStream = FirebaseFirestore.instance
      .collection('Saves')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('Favorites')
      .snapshots(includeMetadataChanges: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
