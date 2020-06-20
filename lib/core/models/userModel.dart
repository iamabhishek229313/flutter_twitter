import 'package:flutter/foundation.dart';

class User {
  String id;
  String name;
  String email_id;
  String user_imageUrl;

  User(
      {@required this.name,
      @required this.email_id,
      @required this.user_imageUrl});

  User.fromMap(Map snapshot, String id)
      : id = id ?? '',
        this.name = snapshot['name'],
        this.email_id = snapshot['email_id'],
        this.user_imageUrl = snapshot['user_imageUrl'];

  toJson() {
    return {"name": name, "email_id": email_id, "user_imageUrl": user_imageUrl};
  }
}