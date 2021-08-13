import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/drawer/mainDrawer.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/moviedetails.dart';
import 'popularmovies_view_model.dart';

class PopularMovieView extends PopularMovieViewModel {
  Widget build(BuildContext context) {
    return resultPopularMovies.length != 0
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Popular Movies',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 2),
              child: GridView.builder(
                controller: popularScrollController,
                itemCount: resultPopularMovies.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetails(id: resultPopularMovies[index].id),
                      ),
                    );
                    print('${resultPopularMovies[index].id}');
                  },
                  child: Container(
                    //color: Colors.black54,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black38),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500" +
                                        resultPopularMovies[index].posterPath),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "${resultPopularMovies[index].title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "⭐   ${resultPopularMovies[index].voteAverage}",
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            drawer: Drawer(
                child: SafeArea(
              child: MainDrawer(),
            )),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
