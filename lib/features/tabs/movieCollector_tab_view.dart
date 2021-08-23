import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/latestMovies/latestmovies.dart';
import 'package:staj_projesi_movie_collector/features/popularMovies/popularmovies.dart';
import 'package:staj_projesi_movie_collector/features/searchByGenreMovies/searchbygenre.dart';
import 'package:staj_projesi_movie_collector/features/searchMovies/searchmovies.dart';
import 'package:staj_projesi_movie_collector/features/topRatedMovies/topratedmovies.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:staj_projesi_movie_collector/product/service/local_notification_service.dart';

class MovieCollectorTabView extends StatefulWidget {
  @override
  _MovieCollectorTabViewState createState() => _MovieCollectorTabViewState();
}

class _MovieCollectorTabViewState extends State<MovieCollectorTabView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocalNotificationService.initialize(context);

    /// uygulama kapalıyken gelen bildirim
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          Navigator.of(context).pushNamed(message.data["page"]);
        }
      },
    );

    ///Foreground-> yani uygulama içinde gezinirken gelecek bildirimleri dinler.
    FirebaseMessaging.onMessage.listen(
      (message) {
        debugPrint("NOTIFY BODY: " + message.notification.body);
        debugPrint("NOTIFY TITLE: " + message.notification.title);

        LocalNotificationService.display(message);
      },
    );

    ///Uygulama arka planda ama çalışıyorken,kullanıcı bildirime tıklarsa
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        final routeFromMessage = message.data["page"];
        Navigator.of(context).pushNamed(routeFromMessage);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          bottomNavigationBar: buildBottomAppBar(context),
          body: TabBarView(
            children: [
              TopRatedMovies(),
              PopularMovies(),
              LatestMovies(),
              SearchMovies(),
              SearchByGenre(),
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
                style: TextStyle(fontSize: 8),
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
          Container(
            height: 50.0,
            child: Tab(
              icon: Icon(Icons.wifi),
              child: Text(
                context.watch<CurrentLanguage>().turkishLang == true
                    ? 'Tür'
                    : 'Genre',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
