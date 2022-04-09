import 'package:flutter/material.dart';
import 'package:social_video/pages/ProfilPage.dart';
import 'package:social_video/widgets/CommentaryIcon.dart';
import 'package:social_video/widgets/LikeIcon.dart';

class PostContent extends StatelessWidget {
  List<dynamic>? like;
  List<dynamic>? comment;

  PostContent(
      {Key? key,
      required this.videoId,
      required this.imageUrl,
      required this.author,
      required this.description,
      this.like,
      this.comment})
      : super(key: key);
  final String videoId;
  final String imageUrl;
  final String author;
  final String description;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == '') return const SizedBox();
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
                        author,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
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
                      videoId: videoId,
                      commentaryArray: comment,
                    ),
                    LikeIcon(
                      videoId: videoId,
                      likeArray: like,
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
                                      username: author,
                                      imageUrl: imageUrl),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(imageUrl),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Icon(
                            Icons.add,
                            size: 15.0,
                            color: Colors.white,
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
