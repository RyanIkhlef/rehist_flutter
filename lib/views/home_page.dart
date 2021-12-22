import 'package:flutter/material.dart';

import 'navigation/nav_drawer.dart';
import 'navigation/nav_bar.dart';
import 'package:rehist/services/event_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.navBar(context),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _banner(context),
            const Padding(padding: EdgeInsets.only(bottom: 40)),
            _nextEvents(context),
            _eventList(context),
            _lastAssociations(context),
            _associationList(context),
          ],
        ),
      ),
    );
  }

  _banner(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
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
          colorFilter: ColorFilter.mode(
              Color(0x4D000000), BlendMode.luminosity),
        ),
      ),
    );
  }

  _nextEvents(BuildContext context) {
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
        new FlatButton(
            onPressed: () {
              print("button maps");
              Navigator.pushNamed(context, "/mapsEvents");
            },
            child: new Text("Maps")
        ),
        _showAll(),
      ],
    );
  }

  _eventList(BuildContext context) {
    return SizedBox(
      height: 350,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: FutureBuilder(
        future: EventService.getLatestEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Widget> cards = [];
            for (var data in snapshot.data) {
              cards.add(_eventCard(data));
            }
            return ListView(children: cards);
          }
          else if (snapshot.hasError) {
            return const Text("Erreur");
          } else {
            return const Text("fetching...");
          }
        },
      ),
    );
  }

  _eventCard(doc) {
    String title = doc["title"];
    String description = doc["description"];
    String date = doc["date"];
    String logoUrl = doc["logo"];
    Image logo;
    if (logoUrl != "") {
      logo = Image.network(doc['logo'],
        width: 70,
        height: 70,
      );
    } else {
      logo = const Image(
        image: AssetImage("assets/images/default_logo.png"),
        width: 70,
        height: 70,
      );
    }

    return Card(
      child: ListBody(
        children: [
          Row(
            children: [
              logo,
              SizedBox(
                width: 275,
                height: 100,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Text(
                  date,
                  textAlign: TextAlign.end
              ),
            ],
          ),
        ],
      ),
    );
  }

  _lastAssociations(BuildContext context) {
    return Row(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Dernières associations",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        new FlatButton(
            onPressed: () {
              print("button maps");
              Navigator.pushNamed(context, "/mapsAssociations");
            },
            child: new Text("Maps")
        ),
        _showAll()
      ],
    );
  }

  _associationList(BuildContext context) {
    return SizedBox(
      height: 350,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: ListView(
        children: [
          const ListTile(title: Text("Association 1"),),
          ListBody(children: const [Text("description")],),
          const ListTile(title: Text("Association 2"),),
          ListBody(children: const [Text("description")],),
          const ListTile(title: Text("Association 3"),),
          ListBody(children: const [Text("description")],),
        ],
      ),
    );
  }

  _showAll() {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {},
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
    );
  }
}
