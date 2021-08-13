import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/drawer/mainDrawer.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/moviedetails.dart';

import 'latestmovies_view_model.dart';

class LatestMovieView extends LatestMovieViewModel {
  Widget build(BuildContext context) {
    return resultLatestMovies.length != 0
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Latest Movies',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 2),
              child: GridView.builder(
                controller: latestScrollController,
                itemCount: resultLatestMovies.length,
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
                            MovieDetails(id: resultLatestMovies[index].id),
                      ),
                    );
                    print('${resultLatestMovies[index].id}');
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
                                        resultLatestMovies[index].posterPath),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "${resultLatestMovies[index].title}",
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
                              "⭐   ${resultLatestMovies[index].voteAverage}",
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
