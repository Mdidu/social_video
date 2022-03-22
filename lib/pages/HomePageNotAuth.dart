import 'package:flutter/material.dart';
import 'package:social_video/pages/LoginPage.dart';
import 'package:social_video/pages/SignupPage.dart';
import 'package:social_video/widgets/LoginButton.dart';
import 'package:social_video/widgets/SignupButton.dart';

class HomePageNotAuth extends StatelessWidget {
  const HomePageNotAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          body: SizedBox(
            // width: double.infinity - 40,
            // width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  child: Text(
                    'Welcome to Social Video app',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: const Text(
                    "We are happy to have you back with us ! Just log in or register if you haven't done so already !",
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                loginButton(
                  onPressedFunction: () => goToLoginPage(context),
                ),
                const SizedBox(
                  height: 25,
                ),
                SignupButton(
                  onPressedFunction: () => goToSignupPage(context),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void goToLoginPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void goToSignupPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupPage(),
      ),
    );
  }
}
