import 'package:flutter/material.dart';
import 'package:social_video/widgets/ContentItemValueCounted.dart';

class PostContent extends StatelessWidget {
  const PostContent(
      {Key? key,
      required this.imageUrl,
      required this.author,
      required this.description,
      required this.nbLike,
      required this.nbComment})
      : super(key: key);
  final String imageUrl;
  final String author;
  final String description;
  final int nbLike;
  final int nbComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Following',
                style: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 20),
              Text(
                'For you',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        size: 36.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ContentItemValueCounted(
                      nbValue: nbComment,
                      icon: Icons.message_outlined,
                    ),
                    ContentItemValueCounted(
                      nbValue: nbLike,
                      icon: Icons.favorite,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(imageUrl),
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
                      height: 15,
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
