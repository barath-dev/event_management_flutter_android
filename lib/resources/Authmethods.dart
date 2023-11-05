import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authmethods {
  Future<String> signUpuser(
      {required String email,
      required String password,
      required String name,
      required String institute,
      required String passingOutYear,
      required String uniqueId}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential cred= await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('users').add({
        'name': name,
        'uid': cred.user!.uid,
        'email': email,
        'uniqueId': uniqueId,
        'institute': institute,
        'passingOutYear': passingOutYear,
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
      return 'success';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
