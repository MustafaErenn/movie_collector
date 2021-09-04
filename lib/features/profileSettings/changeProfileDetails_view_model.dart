import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staj_projesi_movie_collector/features/profileSettings/changeProfileDetails.dart';
import 'package:staj_projesi_movie_collector/features/tabs/movieCollector_tab_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

abstract class ProfileSettingViewModel extends State<ProfileSettings> {
  PickedFile imageFile;
  String username;
  String ppUrl;
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPrefs();
  }

  changeDetails(String newUsername, PickedFile image) async {
    try {
      if (image != null) {
        //RESIM GUNCELLENIYORSA
        File file = File(image.path);
        await FirebaseStorage.instance
            .ref()
            .child('profileImages/${Path.basename(image.path)}')
            .putFile(file);

        String downloadURL = await FirebaseStorage.instance
            .ref('profileImages/${Path.basename(image.path)}')
            .getDownloadURL();

        FirebaseFirestore.instance
            .collection("Accounts")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          'pp': '$downloadURL',
          'username': '${newUsername.isEmpty == true ? username : newUsername}'
        }).then((value) {
          updatePrefs('${newUsername.isEmpty == true ? username : newUsername}',
                  downloadURL)
              .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieCollectorTabView(),
              ),
            ),
          );
        });
      } else {
        FirebaseFirestore.instance
            .collection("Accounts")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({
          'username': '${newUsername.isEmpty == true ? username : newUsername}'
        }).then((value) {
          updatePrefs('${newUsername.isEmpty == true ? username : newUsername}',
                  ppUrl)
              .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieCollectorTabView(),
              ),
            ),
          );
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  readPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      ppUrl = prefs.getString('pp');
    });
  }

  Future updatePrefs(String newUsername, String newPPUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pp', newPPUrl);
    prefs.setString('username', newUsername);
  }

  void openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}
