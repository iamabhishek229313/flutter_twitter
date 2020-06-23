import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/core/models/userModel.dart';

class Post {
  User user;
  int timeStamp;
  String tweet;
  String attached_image;
  List<Map<User, String>> post_comments;
  List<User> post_likes;

  Post(
      {@required this.user,
      @required this.timeStamp,
      @required this.tweet,
      @required this.attached_image,
      @required this.post_comments,
      @required this.post_likes});

  Post.fromSnapshot(DocumentSnapshot snapshot)
       : this.user = User.fromSnapshot(snapshot),
        this.timeStamp = snapshot['timeStamp'],
        this.tweet = snapshot['tweet'],
        this.attached_image = snapshot['attached_image'],
        this.post_comments = snapshot['post_comments'],
        this.post_likes = snapshot['post_likes'];

  toJson() {
    return {
      "user": user.toJson(),
      "timeStamp": timeStamp,
      "tweet": tweet,
      "attached_image": attached_image,
      "post_comments": post_comments,
      "post_likes": post_likes
    };
  }
}
