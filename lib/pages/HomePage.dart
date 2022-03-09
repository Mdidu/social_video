import 'package:flutter/material.dart';
import 'package:social_video/widgets/BottomBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:social_video/widgets/PostContent.dart';
import 'package:social_video/widgets/VideoWidget.dart';
import 'package:social_video/widgets/floatingActionButton.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> tiktokItems = [
    {
      "video": 'assets/videos/video_1.mp4',
      "image": 'assets/images/nature.jpg',
      'author': '@Mdidu',
      'description': 'La première destruction de Beerus Sama était Zamasu !',
      'nbLike': 256830500,
      'nbComment': 128,
      'color': Colors.red
    },
    {
      "video": 'assets/videos/video_2.mp4',
      "image": 'assets/images/nature.jpg',
      'author': '@Reath',
      'description': 'La première vidéo de Reath !',
      'nbLike': 1256,
      'nbComment': 128,
      'color': Colors.blue
    },
  ];
  int prevPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // bottomAppBarColor: Colors.black,
          // iconTheme: Icon()
          ),
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: Scaffold(
        body: CarouselSlider.builder(
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: double.infinity,
            scrollDirection: Axis.vertical,
            viewportFraction: 1.0,
            // onPageChanged: (index, reason) {
            //   setState(() {
            //     tiktokItems[index]['video'].controller.play();
            //     // tiktokItems[index]['color'] = Colors.yellow;
            //     // tiktokItems[prevPage]['color'] = Colors.pink;
            //     tiktokItems[prevPage]['video'].controller.pause();
            //     prevPage = index;
            //   });
            // },
          ),
          itemCount: 2,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            width: MediaQuery.of(context).size.width,
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
          // items: tiktokItems.map((item) {
          //   return Builder(builder: (BuildContext context) {
          //     return Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: Stack(
          //         children: [
          //           VideoWidget(
          //             videoUrl: item['video'],
          //           ),
          //           PostContent(
          //             imageUrl: item['image'],
          //             author: item['author'],
          //             description: item['description'],
          //             nbLike: item['nbLike'],
          //             nbComment: item['nbComment'],
          //           ),
          //         ],
          //       ),
          //     );
          //   });
          // }).toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}

/*
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final List<Map> tiktokItems = [
    {
      "video": 'assets/videos/video_1.mp4',
      "image": 'assets/images/nature.jpg',
      'author': '@Mdidu',
      'description': 'La première destruction de Beerus Sama était Zamasu !',
      'nbLike': 256830500,
      'nbComment': 128,
    },
    {
      "video": 'assets/videos/video_2.mp4',
      "image": 'assets/images/nature.jpg',
      'author': '@Reath',
      'description': 'La première vidéo de Reath !',
      'nbLike': 1256,
      'nbComment': 128,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // bottomAppBarColor: Colors.black,
          // iconTheme: Icon()
          ),
      debugShowCheckedModeBanner: false,
      title: 'test',
      home: Scaffold(
        body: CarouselSlider.builder(
          itemCount: 2,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
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
          // items: tiktokItems.map((item) {
          //   return Builder(builder: (BuildContext context) {
          //     return Container(
          //       width: MediaQuery.of(context).size.width,
          //       child: Stack(
          //         children: [
          //           VideoWidget(
          //             videoUrl: item['video'],
          //           ),
          //           PostContent(
          //             imageUrl: item['image'],
          //             author: item['author'],
          //             description: item['description'],
          //             nbLike: item['nbLike'],
          //             nbComment: item['nbComment'],
          //           ),
          //         ],
          //       ),
          //     );
          //   });
          // }).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: double.infinity,
            scrollDirection: Axis.vertical,
            viewportFraction: 1.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}
*/