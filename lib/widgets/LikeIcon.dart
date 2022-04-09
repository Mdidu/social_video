import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/FormatNumber.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class LikeIcon extends StatefulWidget {
  LikeIcon({Key? key, required this.videoId, this.likeArray}) : super(key: key);
  final String videoId;
  final List<dynamic>? likeArray;
  String userId = auth.currentUser!.uid;

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  late List<dynamic>? likeArray = widget.likeArray;
  late Color colorIcon;
  late bool isAlreadyLike;

  _LikeIconState();

  bool checkIfVideoAlreadyLike() {
    for (var element in likeArray!) {
      if (element == widget.userId) return true;
    }

    return false;
  }

  Future<void> getLikeArray() async {
    DocumentReference<Map<String, dynamic>> docRef =
        firestore.collection('Video').doc(widget.videoId);

    DocumentSnapshot documentSnapshot = await docRef.get();
    
    likeArray = documentSnapshot['like'];
  }

  @override
  void initState() {
    getLikeArray();
    isAlreadyLike = checkIfVideoAlreadyLike();
    colorIcon = isAlreadyLike ? Colors.red : Colors.white;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nbLike = likeArray!.isNotEmpty ? likeArray!.length : 0;

    return Column(
      children: [
        IconButton(
          onPressed: () {
            print(isAlreadyLike);
            if (!isAlreadyLike) {
              firestore.collection('Video').doc(widget.videoId).update({
                'like': FieldValue.arrayUnion([widget.userId])
              }).then((value) {
                setState(() {
                  likeArray!.add(widget.userId);
                  isAlreadyLike = true;
                  colorIcon = Colors.red;
                });
              });
            } else {
              firestore.collection('Video').doc(widget.videoId).update({
                'like': FieldValue.arrayRemove([widget.userId])
              }).then((value) {
                setState(() {
                  likeArray!.remove(widget.userId);
                  isAlreadyLike = false;
                  colorIcon = Colors.white;
                });
              });
            }
          },
          icon: Icon(
            Icons.favorite,
            size: 36.0,
            color: colorIcon,
          ),
        ),
        Text(
          FormatNumber().displayNbValue(nbLike),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  addLike() async {}
}
