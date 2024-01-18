// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DBmethods {
  Future<String> uploadEvent(
      {required String event,
      required String description,
      required DateTime date_time,
      required String venue,
      required String inst,
      required String link,
      required String duration,
      required String imgUrl,
      required String id}) async {
    try {
      String eid = const Uuid().v4();
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('events').doc(eid).set({
        'description': description,
        'date_time': date_time,
        'link': link,
        'duration': duration,
        'venue': venue,
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

  // int getParticipatedEvents() {
  //   int participatedEvents = 0;
  //   FirebaseFirestore.instance
  //       .collection('events')
  //       .where('requests',
  //           arrayContains: FirebaseAuth.instance.currentUser!.email)
  //       .where('date_time', isLessThan: DateTime.now().toString());
  //   return participatedEvents;
  // }

  Future<String> getName() async {
    String name = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      name = value['name'];
    });
    log(name);
    return name;
  }

  Future<bool> hasRegistered(String eid) async {
    bool hasRegistered = false;
    await FirebaseFirestore.instance
        .collection('events')
        .doc(eid)
        .get()
        .then((value) {
      hasRegistered =
          value['requests'].contains(FirebaseAuth.instance.currentUser!.email);
    });
    return hasRegistered;
  }
}
