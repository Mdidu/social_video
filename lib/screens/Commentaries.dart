import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class Commentaries extends StatefulWidget {
  Commentaries({Key? key, required this.videoId, this.value = const []})
      : super(key: key);
  String videoId;
  List? value;
  bool inputIsEmpty = true;

  @override
  State<Commentaries> createState() => _CommentariesState();
}

class _CommentariesState extends State<Commentaries> {
  final commentField = TextEditingController();
  bool inputIsEmpty = true;
  late List? value;
  bool test = false;

  _CommentariesState();

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nbComment = value!.length;
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: nbComment >= 20 ? 20 : widget.value!.length,
        itemBuilder: (BuildContext context, int index) {
          var currentComment = value![index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              index == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text('$nbComment commentaires'),
                        const SizedBox()
                      ],
                    )
                  : const SizedBox(),
              value != null
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentComment['username'],
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(currentComment['comment']),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            currentComment['date'],
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    )
                  : const Text('Aucun commentaire ! Go être le premier !!'),
            ],
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.black45,
                  ),
                ),
                child: TextField(
                  controller: commentField,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Entrez votre commentaire",
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    if (inputIsEmpty && text.isNotEmpty && text.length == 1) {
                      setState(() {
                        inputIsEmpty = false;
                      });
                    } else if (!inputIsEmpty && text.isEmpty) {
                      setState(() {
                        inputIsEmpty = true;
                      });
                    }
                  },
                ),
              ),
            ),
            inputIsEmpty
                ? const SizedBox(
                    width: 15,
                  )
                : IconButton(
                    onPressed: () {
                      addCommentary();
                    },
                    icon: const Icon(
                      Icons.arrow_circle_up,
                      color: Color.fromARGB(255, 224, 55, 43),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  addCommentary() async {
    String userId = auth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> docRef =
        firestore.collection('Users').doc(userId);
    DocumentSnapshot documentSnapshot = await docRef.get();

    if (!documentSnapshot.exists) return;

    // print(documentSnapshot.data());
    // print(documentSnapshot['username']);
    String username = documentSnapshot['username'];
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    var newComment = {
      'username': username,
      'comment': commentField.text.trim(),
      'date': formattedDate,
    };

    firestore.collection('Video').doc(widget.videoId).update({
      'Comment': FieldValue.arrayUnion([newComment])
    }).then((value) {
      commentField.clear();
      setState(() {
        this.value!.add(newComment);
      });
    });
  }

  @override
  void dispose() {
    commentField.dispose();
    super.dispose();
  }
}
