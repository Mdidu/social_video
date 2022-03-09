import 'package:flutter/material.dart';
import 'package:social_video/widgets/BottomBar.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text('test'),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
