import 'package:flutter/material.dart';
import 'package:social_video/pages/LoginPage.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({Key? key, required this.onPressedFunction})
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
        child: const Text('Sign Up'),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.white,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
