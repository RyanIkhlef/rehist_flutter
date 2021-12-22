import 'package:cloud_firestore/cloud_firestore.dart';

class AssociationController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _eventTable = "/association";

  static getLatestAssociations() {
    return _firestore
        .collection(_eventTable)
        .orderBy("created")
        .limit(3)
        .get();
  }
}