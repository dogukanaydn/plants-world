import 'package:cloud_firestore/cloud_firestore.dart';

class PlantsController {
  FirebaseFirestore _firestore;
  CollectionReference _mainCollection;

  PlantsController() {
    _firestore = FirebaseFirestore.instance;
    _mainCollection = _firestore.collection('user_plants');
  }

  Future<void> addItem({int id, String plant_name, String photo}) async {
    DocumentReference documentReferencer = _mainCollection
        .doc('o3d0fB74NdeaQNmvrw2SItbbo152')
        .collection('plants')
        .doc(plant_name);

    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "plant_name": plant_name,
      "photo": photo,
      "is_deleted": false,
      "is_watered": true,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Plants item added to the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readItems() {
    Query _assetsQuery = _mainCollection
        .doc('o3d0fB74NdeaQNmvrw2SItbbo152')
        .collection('plants')
        .where('is_deleted', isEqualTo: false);
    return _assetsQuery.snapshots();
  }

  Future<void> deletePlant({String plant_name}) async {
    DocumentReference documentReferencer = _mainCollection
        .doc('o3d0fB74NdeaQNmvrw2SItbbo152')
        .collection('plants')
        .doc(plant_name);

    Map<String, dynamic> data = <String, dynamic>{
      "is_deleted": true,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  Future<void> setWater({String plant_name}) async {
    DocumentReference documentReferencer = _mainCollection
        .doc('o3d0fB74NdeaQNmvrw2SItbbo152')
        .collection('plants')
        .doc(plant_name);

    Map<String, dynamic> data = <String, dynamic>{
      "is_watered": true,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }
}
