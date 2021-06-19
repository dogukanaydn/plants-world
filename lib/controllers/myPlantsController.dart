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
      {int id, String plantName, String photo, int wateringTime}) async {
    var today = DateTime.now();
    // var timeWatered = today.add(Duration(days: wateringTime));
    var timeWatered = today.add(Duration(seconds: 6));

    DocumentReference documentReferencer = _mainCollection
        .doc(UserInformations.userUid)
        .collection('plants')
        .doc(plantName);

    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "plant_name": plantName,
      "photo": photo,
      "watering_time": wateringTime,
      "is_deleted": false,
      "is_watered": true,
      "time_added": today,
      "time_watered": today,
      "time_next_watered": timeWatered,
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

  Future<void> deletePlant({String plantName}) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(UserInformations.userUid)
        .collection('plants')
        .doc(plantName);

    Map<String, dynamic> data = <String, dynamic>{
      "is_deleted": true,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  Future<void> setWater({String plantName, int wateringTime}) async {
    var today = DateTime.now();
    var timeWatered = today.add(Duration(seconds: 6));
    DocumentReference documentReferencer = _mainCollection
        .doc(UserInformations.userUid)
        .collection('plants')
        .doc(plantName);

    Map<String, dynamic> data = <String, dynamic>{
      "is_watered": true,
      "time_watered": today,
      "time_next_watered": timeWatered,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }
}
