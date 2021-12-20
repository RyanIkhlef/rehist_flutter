import 'package:flutter/material.dart';

class NavBar {

  static navBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Container(
        width: 124.2,
        height: 64,
        decoration: const BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}