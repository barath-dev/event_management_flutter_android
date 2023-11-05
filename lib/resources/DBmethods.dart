import 'package:cloud_firestore/cloud_firestore.dart';

class DBmethods {
  Future<String> uploadEvent(
      {required String type,
      required String description,
      required String date_time,
      required String venue,
      required String duration,
      required String imgUrl,
      required String institue}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      firestore.collection('events').doc().set({
        'type': type,
        'description': description,
        'date_time': date_time,
        'venue': venue,
        'institution': institue,
        'duration': duration,
        'imgUrl': imgUrl,
      });
      return 'success';
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
