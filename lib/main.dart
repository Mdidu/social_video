import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_video/pages/HomePage.dart';
import 'package:social_video/pages/HomePageNotAuth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      runApp(const HomePageNotAuth());
    } else {
      runApp(HomePage());
    }
  });
}
