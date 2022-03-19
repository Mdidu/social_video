import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:social_video/pages/ProfilPage.dart';
import 'package:social_video/widgets/PostContent.dart';
import 'package:social_video/widgets/VideoWidget.dart';

class VideoSlider extends StatelessWidget {
  VideoSlider({Key? key}) : super(key: key);
  List<Map> tiktokItems = [
    {
      "video": 'assets/videos/video_1.mp4',
      "image": 'assets/images/nature.jpg',
      'author': 'Mdidu',
      'description': 'La première destruction de Beerus Sama était Zamasu !',
      'nbLike': 256830500,
      'nbComment': 128
    },
    {
      "video": 'assets/videos/video_2.mp4',
      "image": 'assets/images/nature.jpg',
      'author': 'Reath',
      'description': 'La première vidéo de Reath !',
      'nbLike': 1256,
      'nbComment': 128
    },
  ];
  double initialPosition = 0.0;
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: double.infinity,
        scrollDirection: Axis.vertical,
        viewportFraction: 1.0,
      ),
      itemCount: 2,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          SizedBox(
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
                    username: tiktokItems[itemIndex]['author'],
                  ),
                ),
              );
            }
          },
          child: Stack(
            children: [
              // Container(
              //   color: tiktokItems[itemIndex]['color'],
              // ),
              VideoWidget(
                videoUrl: tiktokItems[itemIndex]['video'],
              ),
              PostContent(
                imageUrl: tiktokItems[itemIndex]['image'],
                author: tiktokItems[itemIndex]['author'],
                description: tiktokItems[itemIndex]['description'],
                nbLike: tiktokItems[itemIndex]['nbLike'],
                nbComment: tiktokItems[itemIndex]['nbComment'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
