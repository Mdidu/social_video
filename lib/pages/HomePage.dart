import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_video/pages/CameraScreen.dart';
import 'package:social_video/pages/VideoSlider.dart';
import 'package:social_video/pages/ProfilPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  String userId = auth.currentUser!.uid;

  List<dynamic> pages = [
    VideoSlider(),
    const Center(child: Text('test')),
    const CameraScreen(),
    const Center(child: Text('test3'))
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late DocumentSnapshot documentSnapshot;
  late String username;
  late String imageUrl;

  @override
  void initState() {
    declareProfilPageWidget();

    super.initState();
  }

  Future<void> declareProfilPageWidget() async {
    documentSnapshot =
        await firestore.collection('Users').doc(widget.userId).get();
    username = documentSnapshot['username'];
    imageUrl = documentSnapshot['photoProfile'];

    widget.pages.add(
      ProfilPage(userId: widget.userId, username: username, imageUrl: imageUrl),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: widget.pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF141518),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: 'Comment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
