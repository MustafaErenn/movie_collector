import 'package:flutter/material.dart';

import 'moviedetails_view.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  const MovieDetails({Key key, this.id}) : super(key: key);

  @override
  MovieDetailsView createState() => new MovieDetailsView();
}
