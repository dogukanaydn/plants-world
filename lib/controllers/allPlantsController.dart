import 'package:cloud_firestore/cloud_firestore.dart';

class AllPlantsController {
  FirebaseFirestore _firestore;
  CollectionReference _mainCollection;

  AllPlantsController() {
    _firestore = FirebaseFirestore.instance;
    _mainCollection = _firestore.collection('all_plants');
  }

  Stream<QuerySnapshot> readItems() {
    return _mainCollection.snapshots();
  }
}
