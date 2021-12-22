import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehist/controller/association_controller.dart';

class AssociationService {
  static Future<dynamic> getLatestAssociations() {
    List<Map> summariesEvents = [];
    return AssociationController.getLatestAssociations()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        summariesEvents.add({
          'title': doc['name'],
          'description': doc['description'],
          'address': doc["address"],
          'logo': doc['logo'],
          'lat': doc['lat'],
          'long': doc['long']
        });
      }
      return summariesEvents;
    });
  }

  static Future<dynamic> getAssociations() {
    List<Map> summariesEvents = [];
    return AssociationController.getAssociations()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        summariesEvents.add({
          'title': doc['name'],
          'description': doc['description'],
          'address': doc["address"],
          'logo': doc['logo'],
          'lat': doc['lat'],
          'long': doc['long']
        });
      }
      return summariesEvents;
    });
  }
}