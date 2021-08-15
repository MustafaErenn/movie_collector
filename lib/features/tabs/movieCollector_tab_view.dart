import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/latestMovies/latestmovies.dart';
import 'package:staj_projesi_movie_collector/features/popularMovies/popularmovies.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/searchmovies.dart';
import 'package:staj_projesi_movie_collector/features/topRatedMovies/topratedmovies.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:provider/provider.dart';

class MovieCollectorTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: buildBottomAppBar(context),
          body: TabBarView(
            children: [
              TopRatedMovies(),
              PopularMovies(),
              LatestMovies(),
              SearchMovies(),
            ],
          ),
        ));
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.black54,
      child: TabBar(
        tabs: [
          Container(
            height: 50.0,
            child: Tab(
              icon: Icon(Icons.star_rate),
              child: Text(
                context.watch<CurrentLanguage>().turkishLang == true
                    ? 'En iyiler'
                    : 'Top Rated',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Container(
            height: 50.0,
            child: Tab(
              icon: Icon(Icons.auto_awesome),
              child: Text(
                context.watch<CurrentLanguage>().turkishLang == true
                    ? "Popüler"
                    : 'Popular',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Container(
            height: 50.0,
            child: Tab(
              icon: Icon(Icons.fiber_new_rounded),
              child: Text(
                context.watch<CurrentLanguage>().turkishLang == true
                    ? 'En yeniler'
                    : 'Latest',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Container(
            height: 60.0,
            child: Tab(
              icon: Icon(Icons.search),
              child: Text(
                context.watch<CurrentLanguage>().turkishLang == true
                    ? 'Arama'
                    : 'Search',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
