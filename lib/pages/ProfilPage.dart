import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_video/pages/NewVideo.dart';
import 'package:social_video/services/SubcriptionService.dart';
import 'package:social_video/widgets/VideoWidget.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ProfilPage extends StatefulWidget {
  ProfilPage(
      {Key? key,
      this.navigatorAction = false,
      required this.username,
      required this.userId,
      required this.imageUrl})
      : super(key: key);

  final bool navigatorAction;
  final String userId;
  final String currentUserId = auth.currentUser!.uid;
  final String username;
  final String imageUrl;
  final String abonnementsTxt = "Abonnements";
  final String abonnesTxt = "Abonnés";
  final String titleTxt = "Pofile";
  final String subscribeBtnTxt = "S'abonner";
  final String unsubscribeBtnTxt = "Se désabonner";

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late List<dynamic> tiktokItems = [];
  late List<dynamic> subscriberArray = [];
  late List<dynamic> subscriptionArray = [];
  late String description = '';
  late bool alreadySubscribe = false;

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> getInformalData() async {
    DocumentReference<Map<String, dynamic>> docRef =
        firestore.collection('Users').doc(widget.userId);
    DocumentSnapshot documentSnapshot = await docRef.get();

    subscriberArray = documentSnapshot['subscriber'];
    subscriptionArray = documentSnapshot['subscription'];
    description = documentSnapshot['description'];

    if (subscriberArray.contains(currentUserId)) {
      alreadySubscribe = true;
    } else {
      alreadySubscribe = false;
    }

    if (subscriberArray.isNotEmpty || subscriptionArray.isNotEmpty) {
      setState(() {
        subscriberArray = documentSnapshot['subscriber'];
        subscriptionArray = documentSnapshot['subscription'];
        description = documentSnapshot['description'];
      });
    }
  }

  getUserVideo() async {
    Query<Map<String, dynamic>> docRef2 = firestore.collection('Video');

    var documents = await docRef2.get();
    List<dynamic> temporalArray = [];

    for (var doc in documents.docs) {
      if (doc.data()['author'] == widget.username) {
        temporalArray.add(doc.data());
        setState(() {
          tiktokItems = temporalArray;
        });
      }
    }
  }

  @override
  void initState() {
    getInformalData();
    getUserVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.navigatorAction
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
                      Text(widget.titleTxt),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(widget.titleTxt),
                      SizedBox(
                        child: IconButton(
                          onPressed: () {
                            logout();
                          },
                          icon: const Icon(
                            Icons.person_off_outlined,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(widget.imageUrl),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(widget.username),
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
                      Text(subscriptionArray.length.toString()),
                      Text(widget.abonnementsTxt),
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
                      Text(subscriberArray.length.toString()),
                      Text(widget.abonnesTxt),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            currentUserId != widget.userId
                ? alreadySubscribe
                    ? ElevatedButton(
                        onPressed: () {
                          SubscriptionService.unsubscribeToUserAccount(
                                  currentUserId, widget.userId)
                              .then((value) {
                            setState(() {
                              subscriberArray.remove(currentUserId);
                              alreadySubscribe = !alreadySubscribe;
                            });
                          });
                        },
                        child: Text(widget.unsubscribeBtnTxt),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 48, 16, 163)),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          SubscriptionService.subscribeToUserAccount(
                                  currentUserId, widget.userId)
                              .then((value) {
                            setState(() {
                              subscriberArray.add(currentUserId);
                              alreadySubscribe = !alreadySubscribe;
                            });
                          });
                        },
                        child: Text(widget.subscribeBtnTxt),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent.shade400),
                      )
                : Container(),
            const SizedBox(
              height: 15,
            ),
            Text(description),
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
                    child: widget.username == tiktokItems[index]['author']
                        ? VideoWidget(videoUrl: tiktokItems[index]['url'])
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
