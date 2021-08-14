import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme with ChangeNotifier {
  bool lightThemeEnabled = false;

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lightThemeEnabled = !lightThemeEnabled;

    prefs.setBool("lightTheme", lightThemeEnabled);
    notifyListeners();
  }
}
