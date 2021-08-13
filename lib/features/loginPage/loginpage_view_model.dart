import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/features/loginPage/loginpage.dart';
import 'package:staj_projesi_movie_collector/product/service/auth.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService = AuthService();
  }
}
