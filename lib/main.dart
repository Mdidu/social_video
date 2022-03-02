import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_video/pages/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
