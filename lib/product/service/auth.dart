import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> signIn(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot documentSnapshot =
          await _firestore.collection("Accounts").doc(user.user.uid).get();

      saveAccountDetails(documentSnapshot.get('email'),
          documentSnapshot.get('username'), documentSnapshot.get('pp'));

      return user.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future signOut() async {
    return await _auth.signOut();
  }

  Future<User> createAccount(
      String username, String email, String password, String repassword) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection("Accounts").doc(user.user.uid).set({
        'username': username,
        'email': email,
        'pp':
            'https://firebasestorage.googleapis.com/v0/b/moviecollector-b5a3b.appspot.com/o/profileImages%2Fdefault_avatar.jpg?alt=media&token=8c9507ed-6097-4bce-880d-d937a915c696'
      });

      return user.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future saveAccountDetails(String email, String username, String pp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("email", email);
    prefs.setString('pp', pp);
  }
}
