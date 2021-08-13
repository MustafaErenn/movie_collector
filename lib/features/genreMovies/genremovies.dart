import 'package:flutter/material.dart';
import 'genremovies_view.dart';

class GenreMovies extends StatefulWidget {
  final String title;
  final int genreId;

  const GenreMovies({Key key, this.title, this.genreId}) : super(key: key);
  @override
  GenreMovieView createState() => new GenreMovieView();
}
