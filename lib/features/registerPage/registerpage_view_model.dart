import 'package:flutter/material.dart';
import 'package:staj_projesi_movie_collector/product/service/auth.dart';

import 'registerpage.dart';

abstract class RegisterPageViewModel extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  AuthService authService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService = AuthService();
  }
}
