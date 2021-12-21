import 'package:flutter/material.dart';
import 'package:rehist/views/eventsPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'views/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
