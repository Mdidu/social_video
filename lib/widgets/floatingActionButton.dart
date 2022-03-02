import 'package:flutter/material.dart';

Widget floatingActionButton = SizedBox(
  height: 65.0,
  width: 65.0,
  child: FittedBox(
    child: FloatingActionButton(
      onPressed: () {},
      child: Container(
        height: 60,
        width: 60,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.black,
            ],
          ),
        ),
      ),
    ),
  ),
);
