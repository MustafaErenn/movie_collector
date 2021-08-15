import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentLanguage extends ChangeNotifier {
  bool turkishLang = false;

  void toggleLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    turkishLang = !turkishLang;

    prefs.setBool("turkishLanguage", turkishLang);
    notifyListeners();
  }
}
