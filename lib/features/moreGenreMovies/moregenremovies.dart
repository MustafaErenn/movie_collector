import 'package:flutter/material.dart';

import 'moregenremovies_view.dart';

class MoreGenreMovies extends StatefulWidget {
  final List<int> genreIdList;

  const MoreGenreMovies({Key key, this.genreIdList}) : super(key: key);
  @override
  MoreGenreMovieView createState() => new MoreGenreMovieView();
}
