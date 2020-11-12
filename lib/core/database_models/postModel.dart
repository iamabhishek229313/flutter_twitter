import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';

/// These are the documents .
class Post {
  String docID;
  User user;
  int timeStamp;
  String tweet;
  String attached_image;
  List<Map<User, String>> post_comments;
  List<String> post_likes;

  Post(
      {this.docID = "",
      @required this.user,
      @required this.timeStamp,
      @required this.tweet,
      @required this.attached_image,
      @required this.post_comments,
      @required this.post_likes});

  Post.fromSnapshot(DocumentSnapshot snapshot, String docID)
      : this.docID = docID,
        this.user = User.fromJson(snapshot["user"]),
        this.timeStamp = snapshot['timeStamp'],
        this.tweet = snapshot['tweet'],
        this.attached_image = snapshot['attached_image'],
        this.post_comments = snapshot['post_comments'],
        this.post_likes = (snapshot['post_likes'] as List).map((e) => e.toString()).toList();

  toJson() {
    return {
      "id": docID,
      "user": user.toJson(),
      "timeStamp": timeStamp,
      "tweet": tweet,
      "attached_image": attached_image,
      "post_comments": post_comments,
      "post_likes": post_likes.map((e) => e).toList()
    };
  }
}
