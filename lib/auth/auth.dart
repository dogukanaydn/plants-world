import 'package:firebase_auth/firebase_auth.dart';
import 'package:plants_world/user/userInformations.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    UserInformations.userUid = user.uid;

    print("user idsi: ${UserInformations.userUid}");

    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    User user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    UserInformations.userUid = user.uid;
    print("user idsi: ${UserInformations.userUid}");
    return user.uid;
  }

  Future<String> currentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
