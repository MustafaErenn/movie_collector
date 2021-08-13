import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/genreMovies/genremovies.dart';
import 'package:staj_projesi_movie_collector/product/model/firestore_movie_model.dart';

import '../web_view_moviedb.dart';
import 'surpriseMe_view_model.dart';

class SurpriseMeView extends SurpriseMeViewModel {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return movieDetail == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Movie Detail',
                style: TextStyle(fontSize: 20),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                    icon: watchlistIconBool == false
                        ? Icon(Icons.remove_from_queue)
                        : Icon(Icons.add_to_queue),
                    onPressed: () async {
                      Movie movie = Movie(
                        movieId: movieDetail.id.toString(),
                        movieTitle: movieDetail.title,
                        moviePosterPath: movieDetail.posterPath,
                        movieRating: movieDetail.voteAverage.toString(),
                      );
                      await firestoreService.flipWatchlist(movie);
                      watchlistIconBool = await firestoreService
                          .watchlistIcon(this.id.toString());
                      setState(() {});
                    }),
                IconButton(
                    icon: favoritesIconBool == false
                        ? Icon(Icons.remove_circle_outline)
                        : Icon(Icons.favorite),
                    onPressed: () async {
                      Movie movie = Movie(
                        movieId: movieDetail.id.toString(),
                        movieTitle: movieDetail.title,
                        moviePosterPath: movieDetail.posterPath,
                        movieRating: movieDetail.voteAverage.toString(),
                      );
                      await firestoreService.flipFavorites(movie);
                      favoritesIconBool = await firestoreService
                          .favoritesIcon(this.id.toString());
                      setState(() {});
                    }),
                IconButton(
                    icon: watchedIconBool == false
                        ? Icon(Icons.remove_done)
                        : Icon(Icons.done_all),
                    onPressed: () async {
                      Movie movie = Movie(
                        movieId: movieDetail.id.toString(),
                        movieTitle: movieDetail.title,
                        moviePosterPath: movieDetail.posterPath,
                        movieRating: movieDetail.voteAverage.toString(),
                      );
                      await firestoreService.flipWatched(movie);
                      watchedIconBool = await firestoreService
                          .watchedIcon(this.id.toString());
                      setState(() {});
                    }),
                // IconButton(
                //   icon: Icon(Icons.read_more),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SimilarMovies(
                //           id: movieDetail.id,
                //           movieName: movieDetail.title,
                //         ),
                //       ),
                //     );
                //   },
                // )
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Center(
                child: movieDetail != null
                    ? ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${movieDetail.title}' +
                                  ' (${movieDetail.releaseDate.year})',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  //color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                                height: 475,
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500" +
                                      "${movieDetail.posterPath}",
                                ),
                                fit: BoxFit.fill),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '⭐  ${movieDetail.voteAverage.toString()}/10 ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'ℹ️  ${movieDetail.runtime.toString()} min',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: movieDetail.genres.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 6.0,
                                      top: 0.0,
                                      right: 6.0,
                                      bottom: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint("turunde film: " +
                                          movieDetail.genres[index].name);
                                      debugPrint("idsi: " +
                                          movieDetail.genres[index].id
                                              .toString());

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GenreMovies(
                                            title:
                                                movieDetail.genres[index].name,
                                            genreId:
                                                movieDetail.genres[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Chip(
                                      backgroundColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                      label: Text(
                                          '${movieDetail.genres[index].name}'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${movieDetail.overview}',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      //color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black54,
                                      padding: const EdgeInsets.all(16.0),
                                      primary: Colors.white,
                                      textStyle: const TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WebViewMovieDb(
                                              id: movieDetail.id.toString()),
                                        ),
                                      );
                                    },
                                    child: const Text('Visit TheMovieDb'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}
