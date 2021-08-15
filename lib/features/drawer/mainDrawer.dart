import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staj_projesi_movie_collector/features/favoritesMovies/favoritesmovies.dart';
import 'package:staj_projesi_movie_collector/features/loginPage/loginpage.dart';
import 'package:staj_projesi_movie_collector/features/profileSettings/changeProfileDetails.dart';
import 'package:staj_projesi_movie_collector/features/surpriseMeMovie/surpriseMe.dart';
import 'package:staj_projesi_movie_collector/features/tabs/movieCollector_tab_view.dart';
import 'package:staj_projesi_movie_collector/features/watchedMovies/watchedmovies.dart';
import 'package:staj_projesi_movie_collector/features/watchlistMovies/watchlistmovies.dart';
import 'package:staj_projesi_movie_collector/product/model/lang_toggle.dart';
import 'package:staj_projesi_movie_collector/product/model/theme_toggle.dart';
import 'package:staj_projesi_movie_collector/product/service/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String email;
  String username;
  String ppUrl;
  _readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      username = prefs.getString('username');
      ppUrl = prefs.getString('pp');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readPrefs();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();

    return username == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: ListView(children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.0, right: 12.0),
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileSettings(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage('${this.ppUrl}'),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        context.watch<CurrentLanguage>().turkishLang == true
                            ? "Kullanıcı Adı: ${this.username}"
                            : "Username: ${this.username}",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        "E-mail: ${this.email}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WatchlistMovies(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.add_to_queue,
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "İzleme Listesi"
                      : "Watchlist",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesMovies(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.favorite_outline_outlined,
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "Favoriler"
                      : "Favorites",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WatchedMovies(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.done_all,
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "İzlediklerin"
                      : "Watched",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurpriseMe(),
                    ),
                  );
                },
                leading: Icon(
                  Icons.wb_incandescent_outlined,
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "Beni Şaşırt!"
                      : "Surprise Me!",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  _authService.signOut().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        ),
                      );
                  ;
                },
                leading: Icon(
                  Icons.logout,
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "Çıkış Yap"
                      : "Log Out",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                trailing: Switch(
                  value: context.watch<CurrentTheme>().lightThemeEnabled,
                  onChanged: (bool value) {
                    context.read<CurrentTheme>().toggleTheme();
                  },
                ),
                title: Text(
                  context.watch<CurrentLanguage>().turkishLang == true
                      ? "Açık Tema"
                      : "Light Theme",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                trailing: Switch(
                  value: context.watch<CurrentLanguage>().turkishLang,
                  onChanged: (bool value) {
                    context.read<CurrentLanguage>().toggleLang();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieCollectorTabView()),
                    );
                  },
                ),
                title: Text(
                  "Türkçe",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ]),
          );
  }
}
