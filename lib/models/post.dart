import 'package:flutter/material.dart';

class User {
  final String name ;
  final String user_id ;
  final String user_imageUrl ;

  User({@required this.name,@required this.user_id,@required this.user_imageUrl});
}

class Post {
  final User user ;
  final String timeStamp;
  final String tweet;
  final List<String> attached_images;
  final List<Map<User,String>> post_comments;
  final List<User> post_likes;

  Post(
      {@required this.user,
      @required this.timeStamp,
      @required this.tweet,
      @required this.attached_images,
      @required this.post_comments,
      @required this.post_likes});
}

String dummy_tweet =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
    
User dummy_user = User(
  name: "Abhishek kumar",
  user_id: "@iamabhhishek",
  user_imageUrl: "assets/logo/icon-400.png"
);


List<Post> dummy_posts = <Post>[
  Post(
      user: dummy_user,
      timeStamp: "1d",
      tweet: dummy_tweet,
      attached_images: [
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png"
      ],
      post_comments: [
        {
         dummy_user : "This is nice comment!" ,
        },
        {
         dummy_user : "This is nice second comment!"
        }
      ],
      post_likes: [
        dummy_user,
        dummy_user,
        dummy_user,
        dummy_user,
      ]
  ),
  Post(
      user: dummy_user,
      timeStamp: "1d",
      tweet: dummy_tweet,
      attached_images: [
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png",
        "assets/logo/icon-400.png"
      ],
      post_comments: [
        {
         dummy_user : "This is nice comment!" ,
        },
        {
         dummy_user : "This is nice second comment!"
        }
      ],
      post_likes: [
        dummy_user,
        dummy_user,
        dummy_user,
        dummy_user,
      ]
  ),
];