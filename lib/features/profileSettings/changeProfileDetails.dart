import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staj_projesi_movie_collector/features/tabs/movieCollector_tab_view.dart';
import 'package:path/path.dart' as Path;

import 'changeProfileDetails_view.dart';

class ProfileSettings extends StatefulWidget {
  @override
  ProfileSettingsView createState() => ProfileSettingsView();
}
