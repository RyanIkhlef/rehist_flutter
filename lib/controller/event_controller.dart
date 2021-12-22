import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _EVENT_TABLE = "/event";

  static getLatestEvents() {
    return _firestore
        .collection(_EVENT_TABLE)
        .orderBy("date_begin")
        .limit(3)
        .get();
  }
}