import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          ListTile(
            title: const Text("Accueil",
                style: TextStyle(fontSize: 24)
            ),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ListTile(
            title: const Text(
                "Associations",
                style: TextStyle(fontSize: 24)
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
                "Evénements",
                style: TextStyle(fontSize: 24)
            ),
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
          )
        ],
      ),
    );
  }
}