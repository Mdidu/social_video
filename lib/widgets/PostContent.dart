import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_video/pages/ProfilPage.dart';
import 'package:social_video/widgets/CommentaryIcon.dart';
import 'package:social_video/widgets/LikeIcon.dart';
import '../services/SubcriptionService.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class PostContent extends StatefulWidget {
  List<dynamic>? like;
  List<dynamic>? comment;

  PostContent(
      {Key? key,
      required this.videoId,
      required this.userId,
      required this.imageUrl,
      required this.author,
      required this.description,
      this.like,
      this.comment})
      : super(key: key);
  final String videoId;
  final String userId;
  final String currentUserId = auth.currentUser!.uid;
  final String imageUrl;
  final String author;
  final String description;

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  late List<dynamic> subscriptionArray = [];
  late bool alreadySubscribe = false;

  getDataSubscriptionAccount() async {
    DocumentReference<Map<String, dynamic>> docRef =
        firestore.collection('Users').doc(widget.currentUserId);
    DocumentSnapshot documentSnapshot = await docRef.get();

    subscriptionArray = documentSnapshot['subscription'];

    if (subscriptionArray.isNotEmpty &&
        subscriptionArray.contains(widget.userId)) {
      setState(() {
        alreadySubscribe = true;
      });
    }
  }

  @override
  void initState() {
    getDataSubscriptionAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl == '') return const SizedBox();
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.author,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommentaryIcon(
                      videoId: widget.videoId,
                      commentaryArray: widget.comment,
                    ),
                    LikeIcon(
                      videoId: widget.videoId,
                      likeArray: widget.like,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilPage(
                                      navigatorAction: true,
                                      userId: widget.userId,
                                      username: widget.author,
                                      imageUrl: widget.imageUrl),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(widget.imageUrl),
                            ),
                          ),
                        ),
                        alreadySubscribe ||
                                widget.currentUserId == widget.userId
                            ? Container()
                            : Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.add,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    SubscriptionService.subscribeToUserAccount(
                                            widget.currentUserId, widget.userId)
                                        .then((value) {
                                      setState(() {
                                        subscriptionArray
                                            .add(widget.currentUserId);
                                        alreadySubscribe = !alreadySubscribe;
                                      });
                                    });
                                  },
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
