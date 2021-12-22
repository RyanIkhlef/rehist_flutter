import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rehist/controller/event_controller.dart';

class EventService {
  static Future<dynamic> getLatestEvents() {
    List<Map> summariesEvents = [];
    return EventController.getLatestEvents()
        .then((QuerySnapshot querySnapshot) {

      for (var doc in querySnapshot.docs) {
        var date = (doc['date_begin'] as Timestamp).toDate();
        String dateToShow = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
        summariesEvents.add({'title': doc['name'], 'description': doc['description'], 'date': dateToShow, 'logo': doc['logo'], 'long': doc['long'], 'lat': doc['lat']});
      }
      return summariesEvents;
    });
  }

  static Future<dynamic> getEvents() {
    List<Map> summariesEvents = [];
    return EventController.getLatestEvents()
        .then((QuerySnapshot querySnapshot) {

      for (var doc in querySnapshot.docs) {
        var date = (doc['date_begin'] as Timestamp).toDate();
        String dateToShow = date.day.toString() + "/" + date.month.toString() + "/" + date.year.toString();
        summariesEvents.add({'title': doc['name'], 'description': doc['description'], 'date': dateToShow, 'logo': doc['logo'], 'long': doc['long'], 'lat': doc['lat']});
      }
      return summariesEvents;
    });
  }
}