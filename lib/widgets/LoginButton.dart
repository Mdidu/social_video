import 'package:flutter/material.dart';
import 'package:social_video/pages/LoginPage.dart';

class loginButton extends StatelessWidget {
  const loginButton({Key? key, required this.onPressedFunction})
      : super(key: key);

  final Function onPressedFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          onPressedFunction();
        },
        child: const Text('Log in'),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Colors.black,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}