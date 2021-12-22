import 'package:cloud_firestore/cloud_firestore.dart';

class EventController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _eventTable = "/event";

  static getLatestEvents() {
    return _firestore
        .collection(_eventTable)
        .orderBy("date_begin")
        .limit(3)
        .get();
  }
}