import 'package:flutter/material.dart';
import 'package:rehist/services/event_service.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  final TextEditingController _textController = TextEditingController();
  List<Map> initialList = [];
  List<Map> filteredList = [];

  @override
  void initState() {
    super.initState();
    EventService.getEvents().then((snapshot) => {
      initialList = snapshot
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Test search')),
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
            if (filteredList.isEmpty && _textController.text.isEmpty)
              Expanded(
                  child: ListView.builder(
                      itemCount: initialList.length,
                      itemBuilder: (BuildContext context, index) {
                        return SizedBox(
                          height: 50,
                          child: Text(initialList[index]['title']),
                        );
                      }))
            else if (filteredList.isEmpty && _textController.text.isNotEmpty)
              const Expanded(
                child: SizedBox(
                  child: Text('Aucune donnée'),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, index) {
                      return SizedBox(
                        height: 50,
                        child: Text(filteredList[index]['title']),
                      );
                    }),
              ),
          ],
        ));
  }
}