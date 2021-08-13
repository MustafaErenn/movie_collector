import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/watchedMovies/watchedmovies.dart';

abstract class WatchedMovieViewModel extends State<WatchedMovies> {
  final Stream<QuerySnapshot> watchedStream = FirebaseFirestore.instance
      .collection('Saves')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('Watched')
      .snapshots(includeMetadataChanges: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
