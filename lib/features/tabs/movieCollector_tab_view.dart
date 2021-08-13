import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/latestMovies/latestmovies.dart';
import 'package:staj_projesi_movie_collector/features/popularMovies/popularmovies.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/searchmovies.dart';
import 'package:staj_projesi_movie_collector/features/topRatedMovies/topratedmovies.dart';

class MovieCollectorTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: buildBottomAppBar(),
          body: TabBarView(
            children: [
              TopRatedMovies(),
              PopularMovies(),
              LatestMovies(),
              SearchMovies(),

              // TopRatedMovies(),
              // PopularMovies(),
              // LatestMovies(),
              // SearchMovies(),
            ],
          ),
        ));
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      color: Colors.black54,
      child: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.star_rate),
            text: 'Top Rated',
          ),
          Tab(
            icon: Icon(Icons.auto_awesome),
            text: 'Popular',
          ),
          Tab(
            icon: Icon(Icons.fiber_new_rounded),
            text: 'Latest',
          ),
          Tab(
            icon: Icon(Icons.search),
            text: 'Search',
          ),
        ],
      ),
    );
  }
}
