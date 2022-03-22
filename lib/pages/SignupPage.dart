import 'package:flutter/material.dart';
import 'package:social_video/widgets/SignupForm.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
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
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SignupForm(),
          ],
        ),
      ),
    );
  }
}
