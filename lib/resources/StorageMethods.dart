// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding umage to firebase storage
  Future<String> uploadImagetoStorage(Uint8List file) async {
    Reference ref = _storage
        .ref()
        .child('images')
        .child(_auth.currentUser!.uid)
        .child('${const Uuid().v4()}.jpg');

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapShot = await uploadTask;
    String url = await snapShot.ref.getDownloadURL();
    return url;
  }
}
