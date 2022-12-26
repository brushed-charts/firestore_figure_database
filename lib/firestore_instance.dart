import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstance {
  late final FirebaseFirestore _instance;
  FirestoreInstance({FirebaseFirestore? instance, bool useEmulator = true}) {
    _instance = instance ?? FirebaseFirestore.instance;
    if (useEmulator) _instance.useFirestoreEmulator('localhost', 8080);
  }

  FirebaseFirestore get getInstance => _instance;
}
