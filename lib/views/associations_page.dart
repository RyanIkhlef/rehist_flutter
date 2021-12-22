import 'package:flutter/material.dart';
import 'package:rehist/services/association_service.dart';

class AssociationsPage extends StatefulWidget {
  @override
  AssociationsPageState createState() => AssociationsPageState();
}

class AssociationsPageState extends State<AssociationsPage> {
  TextEditingController _textController = TextEditingController();
  List<Map> initialList = [];
  List<Map> filteredList = List<Map>.empty();

  void initState() {
    super.initState();
    AssociationService.getAssociations().then((snapshot) =>
    {
      initialList = snapshot,
      setState(() {
        filteredList = initialList;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rechercher une association')),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Rechercher un événement ...'
              ),
              controller: _textController,
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  filteredList = initialList
                      .where((element) =>
                      element['title'].toLowerCase().contains(text))
                      .toList();
                });
              },
            ),
            if (filteredList.length == 0 && _textController.text.isEmpty)
              Expanded(
                  child: ListView.builder(
                      itemCount: initialList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Card(
                            child: ListTile(
                                title: Text(initialList[index]['title']),
                                subtitle: Text(
                                  initialList[index]['description'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        initialList[index]['logo']))
                                ));
                      }))
            else
              if (filteredList.length == 0 && _textController.text.isNotEmpty)
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
                        return Card(
                            child: ListTile(
                                title: Text(filteredList[index]['title']),
                                subtitle: Text(
                                  filteredList[index]['description'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        filteredList[index]['logo']))
                                ));
                      }),
                ),
          ],
        ));
  }
}