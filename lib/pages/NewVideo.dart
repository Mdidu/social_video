import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

String currentUserId = auth.currentUser!.uid;

class NewVideo extends StatelessWidget {
  const NewVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            addVideo();
          },
          child: Text('new video'),
        ),
      ),
    );
  }

  Future<void> addVideo() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return firestore.collection('Video').doc().set({
      'url': 'assets/videos/video_1.mp4',
      'userId': currentUserId,
      'description': 'La première destruction de Beerus Sama était Zamasu !',
      'like': 0,
      'date': formattedDate,
      'author': 'Reath',
      'photoProfile': 'assets/images/3.jpg',
      'Comment': [
        {
          'idComment': 1,
          'username': 'Reath',
          'comment': 'Bonjour',
          'date': formattedDate,
        }
      ]
    });
  }
}
