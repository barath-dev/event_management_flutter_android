// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DBmethods {
  Future<String> uploadEvent(
      {required String type,
      required String event,
      required String description,
      required String date_time,
      required String venue,
      required String inst,
      required String duration,
      required String imgUrl,
      required String id}) async {
    try {
      String eid = Uuid().v4();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('events').doc(eid).set({
        'type': type,
        'description': description,
        'date_time': date_time,
        'duration': duration,
        'venue': venue,
        'institution': inst,
        'eid': eid,
        'event': event,
        'id': id,
        'imgUrl': imgUrl,
        'requests': [],
      });
      return 'success';
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> createCoordinator(
      {required String coordinatorEmail,
      required String coordinatorName,
      required String password,
      required String Institute}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: coordinatorEmail, password: password);

      await FirebaseFirestore.instance
          .collection('coordinators')
          .doc(Institute)
          .set({
        'name': coordinatorName,
        'email': coordinatorEmail,
        'eid': [],
        'techinical_events': [],
        'non_techinical_events': [],
        'students_participating': 0,
        'students_registered': 0,
        'students_registered_list': [],
        'inisitute': Institute,
      });
    } catch (e) {
      return e.toString();
    }
    return 'success';
  }

  Future<String> getInstiuteName() async {
    try {
      String institute = '';
      await FirebaseFirestore.instance
          .collection('coordinators')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((value) {
        institute = value['inisitute'];
      });
      return institute;
    } catch (e) {
      return e.toString();
    }
  }
}
