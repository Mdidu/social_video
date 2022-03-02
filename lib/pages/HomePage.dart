import 'package:flutter/material.dart';
import 'package:social_video/widgets/BottomBar.dart';
import 'package:social_video/widgets/floatingActionButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Colors.red,
          child: Center(
            child: Text('test'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
