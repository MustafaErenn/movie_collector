import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/watchlistMovies/watchlistmovies.dart';
import 'package:staj_projesi_movie_collector/product/model/firestore_movie_model.dart';

abstract class WatchlistMovieViewModel extends State<WatchlistMovies> {
  final Stream<QuerySnapshot> watchlistStream = FirebaseFirestore.instance
      .collection('Saves')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('Watchlist')
      .snapshots(includeMetadataChanges: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
