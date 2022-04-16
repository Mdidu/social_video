import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_video/widgets/InputItem.dart';
import 'package:social_video/widgets/SignupButton.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final emailField = TextEditingController();
  final usernameField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputItem(
          controllerField: emailField,
          hintText: 'Email',
        ),
        const SizedBox(
          height: 35,
        ),
        InputItem(
          controllerField: usernameField,
          hintText: 'Username',
        ),
        const SizedBox(
          height: 35,
        ),
        InputItem(
          controllerField: passwordField,
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(
          height: 35,
        ),
        SignupButton(
          onPressedFunction: () => signup(),
        ),
      ],
    );
  }

  void signup() {
    try {
      auth
          .createUserWithEmailAndPassword(
            email: emailField.text.trim(),
            password: passwordField.text.trim(),
          )
          .then(
            (value) => addUser(
              value.user!.uid,
              usernameField.text.trim(),
            ),
          );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addUser(String userId, String username) async {
    return firestore
        .collection('Users')
        .doc(userId)
        .set({
          'username': username,
          'subscriber': 0,
          'subscription': 0,
          'photoProfile': ''
        })
        .then((value) => print('Utilisateur ajouté'))
        .catchError((error) => print('Error : $error'));
  }
}
