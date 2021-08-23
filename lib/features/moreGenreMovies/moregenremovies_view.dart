import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/moviedetails.dart';

import 'moregenremovies_view_model.dart';

class MoreGenreMovieView extends MoreGenreMovieViewModel {
  @override
  Widget build(BuildContext context) {
    debugPrint(resultGenreMovies.toString());
    return resultGenreMovies == null
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Selected Genre Movies',
              ),
            ),
            body: Center(
              child: Text('No movies in selected genres'),
            ),
          )
        : resultGenreMovies.length != 0
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Selected Genre Movies',
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 2),
                  child: GridView.builder(
                    controller: genreScrollController,
                    itemCount: resultGenreMovies.length,
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
                                MovieDetails(id: resultGenreMovies[index].id),
                          ),
                        );
                      },
                      child: Container(
                        //color: Colors.black,
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
                                    image: NetworkImage(resultGenreMovies[index]
                                                .posterPath !=
                                            null
                                        ? "https://image.tmdb.org/t/p/w500" +
                                            resultGenreMovies[index].posterPath
                                        : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "${resultGenreMovies[index].title}",
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
                                  "⭐  ${resultGenreMovies[index].voteAverage}",
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
              )
            : Center(
                child: CircularProgressIndicator(),
              );
  }
}
