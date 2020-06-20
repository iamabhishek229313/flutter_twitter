import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAPI {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference _ref;

  DatabaseAPI(this.path) {
    _ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return _ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return _ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return _ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return _ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return _ref.document(id).updateData(data);
  }

}
