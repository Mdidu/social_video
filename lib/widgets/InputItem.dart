import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  const InputItem(
      {Key? key,
      required this.controllerField,
      required this.hintText,
      this.obscureText = false})
      : super(key: key);

  final TextEditingController controllerField;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1,
          color: Colors.black45,
        ),
      ),
      child: SizedBox(
        height: 40,
        width: 250,
        child: Center(
          child: TextField(
            controller: controllerField,
            textAlign: TextAlign.center,
            obscureText: obscureText,
            // style: GoogleFonts.comfortaa(
            //   fontSize: 20,
            //   color: Colors.white,
            //   fontWeight: FontWeight.bold,
            // ),
            decoration: InputDecoration(
              hintText: hintText,
              // hintStyle: GoogleFonts.comfortaa(
              //   color: Colors.white,
              // ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
