import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAPI {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference _ref;

  DatabaseAPI(this.path) {
    _ref = _db.collection(path);
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return _ref.snapshots();
  }

  // Document data scrapping .
  Future<QuerySnapshot> getAllDocuments() async {
    return await _ref.getDocuments();
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return _ref.document(id).get();
  }
  Future<DocumentReference> addDocumentInCollection(Map data) {
    return _ref.add(data);
  }
  Future<void> updateDocumentInCollection(Map data, String id) {
    return _ref.document(id).updateData(data);
  }
  Future<void> removeDocumentInCollection(String id) {
    return _ref.document(id).delete();
  }
}
