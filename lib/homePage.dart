import 'package:flutter/material.dart';

import 'navigation/navDrawer.dart';
import 'navigation/navBar.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.navBar(context),
      drawer: NavDrawer(),
      body: const Center(
        child: Text("Je suis la home page"),
      ),
    );
  }
}