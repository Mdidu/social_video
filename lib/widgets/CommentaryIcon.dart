import 'package:flutter/material.dart';
import 'package:social_video/screens/Commentaries.dart';

import '../services/FormatNumber.dart';

class CommentaryIcon extends StatelessWidget {
  const CommentaryIcon(
      {Key? key,
      required this.videoId,
      this.commentaryArray})
      : super(key: key);
  final String videoId;
  final List<dynamic>? commentaryArray;

  @override
  Widget build(BuildContext context) {
    var nbCommentary =
        commentaryArray!.isNotEmpty ? commentaryArray!.length : 0;
    return Column(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Commentaries(videoId: videoId, value: commentaryArray),
              ),
            );
          },
          icon: const Icon(
            Icons.message_outlined,
            size: 36.0,
            color: Colors.white,
          ),
        ),
        Text(
          FormatNumber().displayNbValue(nbCommentary),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
