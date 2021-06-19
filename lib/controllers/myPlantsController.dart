import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_world/user/userInformations.dart';

class PlantsController {
  FirebaseFirestore _firestore;
  CollectionReference _mainCollection;

  PlantsController() {
    _firestore = FirebaseFirestore.instance;
    _mainCollection = _firestore.collection('user_plants');
  }

  Future<void> addItem(
      {int id, String plant_name, String photo, int watering_time}) async {
    var today = DateTime.now();
    var time_watered = today.add(Duration(days: watering_time));

    DocumentReference documentReferencer = _mainCollection
        .doc(UserInformations.userUid)
        .collection('plants')
        .doc(plant_name);

    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "plant_name": plant_name,
      "photo": photo,
      "is_deleted": false,
      "is_watered": true,
      "time_added": today,
      "time_watered": time_watered,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Plants item added to the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readItems() {
    Query _assetsQuery = _mainCollection
        .doc(UserInformations.userUid)
        .collection('plants')
        .where('is_deleted', isEqualTo: false);
    return _assetsQuery.snapshots();
  }

  Future<void> deletePlant({String plant_name}) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(UserInformations.userUid)
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
        .doc(UserInformations.userUid)
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
