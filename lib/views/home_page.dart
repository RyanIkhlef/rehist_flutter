import 'package:flutter/material.dart';
import 'package:rehist/services/event_service.dart';
import 'package:rehist/services/association_service.dart';
import 'package:rehist/views/events_page.dart';

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

  _nextEvents(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Prochains événements",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
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
        _showAll(context, "/events"),
      ],
    );
  }

  _eventList(BuildContext context) {
    return SizedBox(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: EventService.getLatestEvents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List<Widget> cards = [];
            for(var data in snapshot.data) {
              cards.add(_eventCard(data));
            }
            return ListView(children: cards);
          }
          else if(snapshot.hasError) {
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
    String address = doc["address"];
    String logoUrl = doc["logo"];
    Image logo;
    if(logoUrl != "") {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo,
                  SizedBox(
                    width: 275,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 100,
                    width: 75,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            date,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(address,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: Colors.grey),)
                        ]),
                  ),
                ]),
          ]),
    );
  }

  _lastAssociations(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Dernières associations",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
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
        _showAll(context, "/associations"),
      ],
    );
  }

  _associationList(BuildContext context) {
    return SizedBox(
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: AssociationService.getLatestAssociations(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            List<Widget> cards = [];
            for(var data in snapshot.data) {
              cards.add(_associationCard(data));
            }
            return ListView(children: cards);
          }
          else if(snapshot.hasError) {
            return const Text("Erreur");
          } else {
            return const Text("fetching...");
          }
        },
      ),
    );
  }

  _associationCard(doc) {
    String title = doc["title"];
    String description = doc["description"];
    String address = doc["address"];
    String logoUrl = doc["logo"];
    Image logo;
    if(logoUrl != "") {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo,
                  SizedBox(
                    width: 275,
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 100,
                    width: 75,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(address,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(color: Colors.grey),)
                        ]),
                  ),
                ]),
          ]),
    );
  }

  _showAll(BuildContext context, String route) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
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
    );
  }
}