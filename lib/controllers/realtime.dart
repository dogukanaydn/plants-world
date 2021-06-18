import 'package:firebase_database/firebase_database.dart';

class RealtimeDB {
  final databaseReference = FirebaseDatabase.instance.reference();

  void updateData() {
    databaseReference.child('water').update({'isWatered': 'true'});
  }
}
