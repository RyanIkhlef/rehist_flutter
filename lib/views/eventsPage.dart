import 'package:flutter/material.dart';

import 'navigation/navDrawer.dart';
import 'navigation/navBar.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  static const String routeName = '/events';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.navBar(context),
      drawer: NavDrawer(),
      body: const Center(
        child: Text("Je suis la liste des évenements"),
      ),
    );
  }
}