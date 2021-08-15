import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/moviedetails.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'watchedmovies_view_model.dart';
import 'package:provider/provider.dart';

class WatchedMovieView extends WatchedMovieViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.watch<CurrentLanguage>().turkishLang == true
              ? 'İzlediklerin'
              : 'Watched',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: watchedStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 2),
              child: GridView.builder(
                //controller: _latestScrollController,
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    debugPrint(snapshot.data.docs[index]['movieId'].toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetails(
                            id: int.parse(
                                snapshot.data.docs[index]['movieId'])),
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500" +
                                        snapshot.data.docs[index]
                                            ["moviePosterPath"])),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              "${snapshot.data.docs[index]["movieTitle"]}",
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
                              "⭐  ${snapshot.data.docs[index]["movieRating"]}",
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
            );
          }
        },
      ),
    );
  }
}
