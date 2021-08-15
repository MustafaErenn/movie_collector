import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/drawer/mainDrawer.dart';
import 'package:staj_projesi_movie_collector/features/movieDetails/moviedetails.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'searchmovies_view_model.dart';
import 'package:provider/provider.dart';

class SearchMovieView extends SearchMovieViewModel {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<CurrentLanguage>().turkishLang == true
            ? 'Film Ara'
            : 'Search Movie'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: resultSearchMovies != null
              ? ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: context
                                          .watch<CurrentLanguage>()
                                          .turkishLang ==
                                      true
                                  ? "Film ismi giriniz"
                                  : "Enter a movie name",
                              icon: Icon(Icons.drive_file_rename_outline),
                            ),
                            maxLines: 1,
                            style: TextStyle(fontSize: 20),
                            onChanged: (String currentText) {
                              print('$currentText');
                            },
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 4,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 2),
                        child: GridView.builder(
                          controller: searchScrollController,
                          itemCount: resultSearchMovies.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  builder: (context) => MovieDetails(
                                      id: resultSearchMovies[index].id),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              //color: Colors.black,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black38),
                              child: Column(
                                // physics: ClampingScrollPhysics(),
                                // shrinkWrap: true,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                          image: NetworkImage(resultSearchMovies[
                                                          index]
                                                      .posterPath !=
                                                  null
                                              ? "https://image.tmdb.org/t/p/w500" +
                                                  resultSearchMovies[index]
                                                      .posterPath
                                              : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png'),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "${resultSearchMovies[index].title}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 17.5,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "⭐  ${resultSearchMovies[index].voteAverage}",
                                        style: TextStyle(
                                            fontSize: 17.5,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: MainDrawer(),
        ),
      ),
    );
  }
}
