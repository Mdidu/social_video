import 'package:flutter/material.dart';
import 'package:social_video/widgets/VideoWidget.dart';

class ProfilPage extends StatelessWidget {
  ProfilPage({Key? key, this.navigatorAction = false, this.username = 'Mdidu'})
      : super(key: key);

  final bool navigatorAction;
  final String username;
  Map<String, String> user = {'nbAbonnement': '25', 'nbAbonne': '9'};

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
    {
      "video": 'assets/videos/video_2.mp4',
      "image": 'assets/images/nature.jpg',
      'author': 'Reath',
      'description': 'La première vidéo de Reath !',
      'nbLike': 1256,
      'nbComment': 128
    },
    {
      "video": 'assets/videos/video_1.mp4',
      "image": 'assets/images/nature.jpg',
      'author': 'Mdidu',
      'description': 'La première destruction de Beerus Sama était Zamasu !',
      'nbLike': 256830500,
      'nbComment': 128
    },
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    // String? username = username;
    String? nbAbonnement = user["nbAbonnement"];
    String? nbAbonne = user["nbAbonne"];

    tiktokItems.retainWhere((element) => element['author'] == username);

    return Scaffold(
      // height: 400,
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            navigatorAction
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Text('Profile'),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('Profile'),
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/nature.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(username),
            const SizedBox(
              height: 15,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(nbAbonnement!),
                      const Text('Abonnements'),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                    child: VerticalDivider(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(nbAbonne!),
                      const Text('Abonnés'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("S'abonner"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent.shade400),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
                'Description très hyper archi méga giga longue ou pas !'),
            const SizedBox(
              height: 25,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (widthScreen / 3),
                ),
                itemCount: tiktokItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: username == tiktokItems[index]['author']
                        ? VideoWidget(videoUrl: tiktokItems[index]['video'])
                        : Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
