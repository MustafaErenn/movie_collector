import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/drawer/mainDrawer.dart';
import 'package:staj_projesi_movie_collector/features/moreGenreMovies/moregenremovies.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';

import 'searchbygenre_view_model.dart';
import 'package:provider/provider.dart';

class SearchByGenreView extends SearchByGenreViewModel {
  Widget build(BuildContext context) {
    return allGenres.length != 0
        ? Scaffold(
            appBar: AppBar(
              title: Text(context.watch<CurrentLanguage>().turkishLang == true
                  ? 'Film Türüne Göre Ara'
                  : 'Search Movie by Genre'),
              actions: selectedItems.length != 0
                  ? [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoreGenreMovies(
                                genreIdList: selectedItems,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.send),
                      ),
                    ]
                  : [],
            ),
            drawer: Drawer(
              child: SafeArea(
                child: MainDrawer(),
              ),
            ),
            body: SafeArea(
              child: ListView.builder(
                  itemCount: allGenres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Card(
                        child: Container(
                          color: (selectedItems.contains(allGenres[index].id))
                              ? Colors.blue.withOpacity(0.5)
                              : Colors.transparent,
                          child: ListTile(
                            title: Text('${allGenres[index].name}'),
                            onLongPress: () {
                              if (!selectedItems
                                  .contains(allGenres[index].id)) {
                                setState(() {
                                  selectedItems.add(allGenres[index].id);
                                });
                              }
                            },
                            onTap: () {
                              if (selectedItems.contains(allGenres[index].id)) {
                                setState(() {
                                  selectedItems.removeWhere(
                                      (val) => val == allGenres[index].id);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(context.watch<CurrentLanguage>().turkishLang == true
                  ? 'Film Türüne Göre Ara'
                  : 'Search Movie by Genre'),
            ),
            drawer: Drawer(
              child: SafeArea(
                child: MainDrawer(),
              ),
            ),
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
