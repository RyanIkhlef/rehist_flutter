import 'package:flutter/material.dart';
import 'package:rehist/services/event_service.dart';
class EventsPage extends StatefulWidget {
  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  TextEditingController _textController = TextEditingController();
  List<Map> initialList = [];
  List<Map> filteredList = [];

  void initState() {
    super.initState();
    EventService.getEvents().then((snapshot) => {
      initialList = snapshot
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Test search')),
        body: Column(
          children: <Widget>[
            TextField(
              controller: _textController,
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  filteredList = initialList
                      .where((element) => element['title'].toLowerCase().contains(text))
                      .toList();
                });
              },
            ),
            if (filteredList.length == 0 && _textController.text.isEmpty)
              Expanded(
                  child: ListView.builder(
                      itemCount: initialList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          height: 50,
                          child: Text(initialList[index]['title']),
                        );
                      }))
            else if (filteredList.length==0 && _textController.text.isNotEmpty)
              Expanded(
                child: Container(
                  child: Text('Aucune donnée'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        height: 50,
                        child: Text(filteredList[index]['title']),
                      );
                    }),
              ),
          ],
        ));
  }
}