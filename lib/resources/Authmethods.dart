import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authmethods {
  Future<String> signUpuser(
      {required String email,
      required String password,
      required int year,
      required String name,
      required String institute,
      // required String passingOutYear,
      required String uniqueId}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'uid': cred.user!.uid,
        'email': email,
        'year': year,
        'uniqueId': uniqueId,
        'institute': institute,
        'notifications': [],
        'events registered': [],
        'events_registered': 0,
      });
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(cred.user!.email)
          .set({
        'notifications': [],
      });
      return 'success';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // Restart.restartApp();
      return 'success';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
