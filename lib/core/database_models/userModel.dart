import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';



/// This data will be under the each document.


class User {
  String name;
  String email_id;
  String user_imageUrl;

  User(
      {@required this.name,
      @required this.email_id,
      @required this.user_imageUrl});

  User.fromSnapshot(DocumentSnapshot snapshot):
        this.name = snapshot['user']['name'],
        this.email_id = snapshot['user']['email_id'],
        this.user_imageUrl = snapshot['user']['user_imageUrl'];

  toJson() {
    return {"name": name, "email_id": email_id, "user_imageUrl": user_imageUrl};
  }
}