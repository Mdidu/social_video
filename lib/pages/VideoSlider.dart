import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_video/pages/ProfilPage.dart';
import 'package:social_video/widgets/PostContent.dart';
import 'package:social_video/widgets/VideoWidget.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class VideoSlider extends StatelessWidget {
  late String userId;

  VideoSlider({Key? key}) : super(key: key);

  double initialPosition = 0.0;
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('Video').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            child: Center(
              child: Text('Loading...'),
            ),
          );
        }
        return CarouselSlider.builder(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: double.infinity,
            scrollDirection: Axis.vertical,
            viewportFraction: 1.0,
          ),
          itemCount: snapshot.data!.size,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            QueryDocumentSnapshot<Object?> documentSnapshot =
                snapshot.data!.docs[itemIndex];

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  initialPosition = details.globalPosition.dx;
                },
                onPanUpdate: (DragUpdateDetails details) {
                  distance = details.globalPosition.dx - initialPosition;
                },
                onPanEnd: (DragEndDetails details) {
                  if (initialPosition > distance) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilPage(
                          navigatorAction: true,
                          username: documentSnapshot['author'],
                          imageUrl: documentSnapshot['photoProfile'],
                        ),
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    VideoWidget(
                      videoUrl: documentSnapshot['url'],
                    ),
                    PostContent(
                      videoId: documentSnapshot.id,
                      imageUrl: documentSnapshot['photoProfile'],
                      author: documentSnapshot['author'],
                      description: documentSnapshot['description'],
                      like: documentSnapshot['like'],
                      comment: documentSnapshot['Comment'],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
