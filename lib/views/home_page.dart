// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'navigation/nav_drawer.dart';
import 'navigation/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.navBar(context),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          _banner(context),
          const Padding(padding: EdgeInsets.only(bottom: 40)),
          _nextEvents(),
          _eventList(context),
        ],
      ),
    );
  }

  _banner(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: const Align(
        child: SizedBox(
          width: 300,
          child: Text(
            "Retrouvez tous les événements et associations de reconstitution historique",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/rehist_banner.png"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Color(0x4D000000), BlendMode.luminosity),
        ),
      ),
    );
  }

  _nextEvents() {
    return Row(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Prochains événements",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  print('Pressed');
                },
                child: Row(
                  children: const [
                    Text("Voir tous",
                      style: TextStyle(color: Color(0xfff6ae2d)),
                      textAlign: TextAlign.start,),
                    Image(
                      image: AssetImage("assets/images/right_arrow.png"),
                      width: 25,
                      height: 25,
                      alignment: Alignment.centerLeft,
                      color: Color(0xfff6ae2d),
                    ),
                  ],
                ),
              ),
            )
        ),
      ],
    );
  }

  _eventList(BuildContext context) {
    return SizedBox(
      height: 392,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          const ListTile(title: Text("Event 1"),),
          ListBody(children: const [Text("description")],)
        ],
      ),
    );
  }
}
