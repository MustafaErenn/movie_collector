import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staj_projesi_movie_collector/features/loginPage/loginpage.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/searchmovie_service.dart';
import 'features/tabs/movieCollector_tab_view.dart';
import 'product/model/theme_toggle.dart';
import 'product/service/currentgenremovie_service.dart';
import 'product/service/firestore_service.dart';
import 'product/service/latest_service.dart';
import 'product/service/moviedetail_service.dart';
import 'product/service/popular_service.dart';
import 'product/service/similarmovies_service.dart';
import 'product/service/toprated_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<LatestService>(create: (context) => LatestService()),
      Provider<SearchMovieService>(create: (context) => SearchMovieService()),
      Provider<PopularService>(create: (context) => PopularService()),
      Provider<TopRatedService>(create: (context) => TopRatedService()),
      Provider<CurrentGenreService>(create: (context) => CurrentGenreService()),
      Provider<MovieDetailService>(create: (context) => MovieDetailService()),
      Provider<SimilarMovieService>(create: (context) => SimilarMovieService()),
      ChangeNotifierProvider<CurrentTheme>(create: (context) => CurrentTheme()),
      ChangeNotifierProvider<CurrentLanguage>(
          create: (context) => CurrentLanguage()),
      ChangeNotifierProvider<FirestoreService>(
          create: (context) => FirestoreService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callPrefs();
  }

  void callPrefs() async {
    prefs = await SharedPreferences.getInstance();

    debugPrint('current Theme : ' + prefs.getBool('lightTheme').toString());
    debugPrint('current lang : ' + prefs.getBool('turkishLanguage').toString());

    context.read<CurrentTheme>().lightThemeEnabled =
        (prefs.getBool('lightTheme') == null
            ? false
            : prefs.getBool('lightTheme'));

    context.read<CurrentLanguage>().turkishLang =
        (prefs.getBool('turkishLanguage') == null
            ? false
            : prefs.getBool('turkishLanguage'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: context.watch<CurrentLanguage>().turkishLang == true
            ? 'Film Koleksiyoncusu'
            : 'Movie Collector',
        theme: context.watch<CurrentTheme>().lightThemeEnabled == true
            ? ThemeData.light()
            : ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Beklenmeyen bir hata'),
              );
            } else if (snapshot.hasData) {
              if (FirebaseAuth.instance.currentUser == null) {
                print('HİÇ KULLANICI GİRİŞİ YAPILMAMIŞ!');
                return LoginPage();
              } else {
                print('KULLANICI GİRİŞ YAPMIŞ DAHA ONCEDEN');
                return MovieCollectorTabView();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        //MovieCollectorTabView(),
        );
  }
}
