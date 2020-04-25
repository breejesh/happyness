import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Firestore _db = Firestore.instance;

  FirestoreService() {}

}

FirestoreService firestoreService = FirestoreService();