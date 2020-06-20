import 'package:flutter/foundation.dart';
import 'package:twitter_clone/core/models/userModel.dart';

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
