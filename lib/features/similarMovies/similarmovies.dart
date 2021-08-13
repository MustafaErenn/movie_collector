import 'package:flutter/material.dart';

import 'similarmovies_view.dart';

class SimilarMovies extends StatefulWidget {
  final int id;
  final String movieName;

  const SimilarMovies({Key key, this.id, this.movieName}) : super(key: key);
  SimilarMovieView createState() => new SimilarMovieView();
}
