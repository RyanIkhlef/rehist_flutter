import 'package:flutter/material.dart';
import 'package:rehist/eventsPage.dart';

import 'homePage.dart';

void main() {
  runApp(const MyApp());
}
Map<String, WidgetBuilder> routes = {
  "/": (context) => HomePage(),
  "/events": (context) => EventsPage()
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rehist',
        theme: ThemeData(
          primaryColor: const Color(0xFF33658a),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0x00f6ae2d)),
          fontFamily: "work sans",
        ),
        routes: routes,
        initialRoute: "/",
    );
  }
}
