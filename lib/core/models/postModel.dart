import 'package:flutter/material.dart';

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

class Post {
  User user;
  int timeStamp;
  String tweet;
  List<String> attached_images;
  List<Map<User, String>> post_comments;
  List<User> post_likes;

  Post(
      {@required this.user,
      @required this.timeStamp,
      @required this.tweet,
      @required this.attached_images,
      @required this.post_comments,
      @required this.post_likes});

  Post.fromMap(Map snapshot, User user)
      : this.user = snapshot['user'],
        this.timeStamp = snapshot['timeStamp'],
        this.tweet = snapshot['tweet'],
        this.attached_images = snapshot['attached_images'],
        this.post_comments = snapshot['post_comments'],
        this.post_likes = snapshot['post_likes'];

  toJson() {
    return {
      "user": user,
      "timeStamp": DateTime.now().millisecondsSinceEpoch,
      "tweet": tweet,
      "attached_images": attached_images,
      "post_comments": post_comments,
      "post_likes": post_likes
    };
  }
}
