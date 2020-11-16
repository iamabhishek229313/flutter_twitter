import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/bloc/fake_loading/fake_loading_bloc.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/database_models/postModel.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/view_image_screen.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';
import 'package:twitter_clone/utils/some_const.dart';

class PostWidget extends StatefulWidget {
  @required
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  DatabaseAPI _dbAPIforPost;
  SharedPreferences _prefs;
  bool youLiked;

  @override
  void initState() {
    super.initState();
    _dbAPIforPost = DatabaseAPI("posts");
    youLiked = false;
  }

  void _handleBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (builder) {
          return Container(
            // height: MediaQuery.of(context).size.height * 0.38,
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 55.0,
                    height: 6.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.blueGrey[400])),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    size: 28.0,
                  ),
                  title: Text("Delete this Post"),
                  onTap: () {
                    /// Here we're going to delete the post.
                    BlocProvider.of<FakeLoadingBloc>(context).add(TriggerChange.TRUE);
                    _dbAPIforPost.removeDocumentInCollectionById(widget.post.docID);
                    if (widget.post.attached_image != null) {
                      String filePath = widget.post.attached_image
                          .toString()
                          .replaceAll(
                              new RegExp(
                                  'https://firebasestorage.googleapis.com/v0/b/test-flutter-twitter.appspot.com/o/twitter_clone%2F'),
                              '')
                          .split('?')[0];

                      FirebaseStorage.instance
                          .ref()
                          .child('twitter_clone/${filePath}')
                          .delete()
                          .then((_) => print('Successfully deleted $filePath storage item'));
                    }
                    Future.delayed(Duration(milliseconds: 1200), () {
                      BlocProvider.of<FakeLoadingBloc>(context).add(TriggerChange.FALSE);
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  getPost_UserDetail() async {
    // This function is meant to be for distinguishing the
    // relationship b/w current user and the post.
    /// [Like] -- Whether a person is liked that post or not.
    /// [Recent Retweets] -- recent replies to retweets. (Future thing)
    _prefs = await SharedPreferences.getInstance();
    String userID = _prefs.getString(AppConstants.userID);

    for (int i = 0; i < widget.post.post_likes.length; ++i) {
      if (userID == widget.post.post_likes[i]) {
        youLiked = true;
        return youLiked;
      }
    }
    youLiked = false;
    return youLiked;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPost_UserDetail(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return Container(
            height: 300.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: widget.post.user.photoURL ?? custom_discord,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          widget.post.user.firstName == '' ? "Anonymous" : widget.post.user.firstName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: "HelveticaNeue", fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            '@' + widget.post.user.emailAddress,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            //crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(6.0),
                                height: 3.0,
                                width: 3.0,
                                decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                              ),
                              Flexible(
                                child: Text(
                                  timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.post.timeStamp)),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "HelveticaNeue",
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              var currentUser = BlocProvider.of<CurrentUserBloc>(context).state;

                              /// If the user want's to delete its post then.
                              if (currentUser.emailAddress == widget.post.user.emailAddress) _handleBottomSheet();
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.tweet,
                          style: TextStyle(fontFamily: 'HelveticaNeue', color: Colors.black, fontSize: 16.0),
                        ),
                        // Will do in the new example.
                        (widget.post.attached_image == null)
                            ? Container()
                            : Container(
                                height: MediaQuery.of(context).size.height * 0.27,
                                decoration:
                                    BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10.0)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewImageScreen(
                                                  imageUrl: widget.post.attached_image,
                                                )));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: widget.post.attached_image,
                                        fit: BoxFit.fitHeight,
                                      )),
                                ),
                              ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => CommentScreen(
                                          postdocID: widget.post.docID,
                                        )));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    AppIcon.reply,
                                    size: 19.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(widget.post.post_comments.length.toString(),
                                          style: TextStyle(fontSize: 16.0)))
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(
                                AppIcon.retweet,
                                size: 19.0,
                                color: Colors.grey,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onLongPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => PostLikeScreen(
                                          docIDList: widget.post.post_likes,
                                        )));
                              },
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (youLiked) {
                                        await Firestore.instance
                                            .collection("posts")
                                            .document(widget.post.docID)
                                            .updateData({
                                          "post_likes": FieldValue.arrayRemove([_prefs.getString(AppConstants.userID)])
                                        });
                                        log("Removed from likes");
                                      } else {
                                        await Firestore.instance
                                            .collection("posts")
                                            .document(widget.post.docID)
                                            .updateData({
                                          "post_likes": FieldValue.arrayUnion([_prefs.getString(AppConstants.userID)])
                                        });
                                        log("Added likes");
                                      }
                                      setState(() {
                                        // you_liked = false;
                                      });
                                    },
                                    child: Icon(
                                      (youLiked) ? AppIcon.heartFill : AppIcon.heartEmpty,
                                      size: 19.0,
                                      color: (youLiked) ? Colors.pinkAccent.shade400 : Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (_) => PostLikeScreen(
                                                      docIDList: widget.post.post_likes,
                                                    )));
                                          },
                                          child: Text(widget.post.post_likes.length.toString(),
                                              style: TextStyle(fontSize: 16.0))))
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.share,
                                  size: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0.4,
              height: 20.0,
              color: Colors.blueGrey[200],
            ),
          ],
        );
      },
    );
  }
}

class CommentScreen extends StatefulWidget {
  final String postdocID;

  const CommentScreen({Key key, @required this.postdocID}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  String currentUserID;
  List<User> _respectiveUsers;
  Post post;
  TextEditingController _cmntController;
  ProgressDialog _pr;

  @override
  void initState() {
    super.initState();
    _respectiveUsers = <User>[];
    _cmntController = TextEditingController();
    _pr = ProgressDialog(context);
  }

  getAllComments() async {
    DocumentSnapshot ds = await Firestore.instance.collection("posts").document(widget.postdocID).get();
    final _prefs = await SharedPreferences.getInstance();

    currentUserID = _prefs.getString(AppConstants.userID);

    post = Post.fromSnapshot(ds, ds.documentID);

    _respectiveUsers.clear();
    for (int i = 0; i < post.post_comments.length; ++i) {
      DocumentSnapshot ds = await Firestore.instance.collection("users").document(post.post_comments[i].userID).get();
      _respectiveUsers.add(User.fromJson(ds.data));
    }
    log("Respective users length : " + _respectiveUsers.length.toString());
    return _respectiveUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getAllComments(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  if (_respectiveUsers.length == 0)
                    return Container(
                      constraints: BoxConstraints.expand(),
                      child: Center(
                        child: Text(
                          "No Comments yet.",
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _respectiveUsers.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: (post.post_comments[index].userID != currentUserID)
                            ? null
                            : () async {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    builder: (builder) {
                                      return Container(
                                        // height: MediaQuery.of(context).size.height * 0.38,
                                        margin: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                width: 55.0,
                                                height: 6.0,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.blueGrey[400])),
                                            ListTile(
                                              leading: Icon(
                                                Icons.delete_outline,
                                                size: 28.0,
                                              ),
                                              title: Text("Delete comment"),
                                              onTap: () async {
                                                await Firestore.instance
                                                    .collection("posts")
                                                    .document(widget.postdocID)
                                                    .updateData({
                                                  "post_comments":
                                                      FieldValue.arrayRemove([post.post_comments[index].toJson()])
                                                });

                                                log("Comment Removed!");
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                setState(() {});
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 2.0)],
                                ),
                                child: CircleAvatar(
                                  radius: 23.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: _respectiveUsers[index].photoURL,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                "@" + _respectiveUsers[index].username,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                              ),
                              subtitle: Text(
                                post.post_comments[index].comment,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            ),
                            Divider(
                              endIndent: 8.0,
                              indent: 8.0,
                              height: 0.0,
                              color: Colors.grey.shade200,
                              thickness: 1.2,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Material(
              elevation: 25.0,
              color: Colors.grey.shade200,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.circular(50.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: TextField(
                                  controller: _cmntController,
                                  style: TextStyle(fontSize: 16.0),
                                  decoration: InputDecoration(
                                      hintText: "Comment ...",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.grey,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          RaisedButton(
                            onPressed: () async {
                              /// Will [Add a Comment in db] from user.
                              if (_cmntController.text.length == 0) {
                                return;
                              } else {
                                final _prefs = await SharedPreferences.getInstance();
                                Comment cmnt = Comment(
                                    comment: _cmntController.text, userID: _prefs.getString(AppConstants.userID));
                                await Firestore.instance.collection("posts").document(widget.postdocID).updateData({
                                  "post_comments": FieldValue.arrayUnion([cmnt.toJson()])
                                });
                                setState(() {
                                  _cmntController.clear();
                                });

                                log("Comment Added!");
                              }
                            },
                            elevation: 0.0,
                            child: Text("Comment",
                                style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          )
                        ],
                      ))),
            )
          ],
        ));
  }
}

class PostLikeScreen extends StatefulWidget {
  final List<String> docIDList;

  const PostLikeScreen({Key key, @required this.docIDList}) : super(key: key);
  @override
  _PostLikeScreenState createState() => _PostLikeScreenState();
}

class _PostLikeScreenState extends State<PostLikeScreen> {
  List<User> _userList;

  @override
  void initState() {
    super.initState();
    _userList = <User>[];
  }

  getAllUserData() async {
    for (int i = 0; i < widget.docIDList.length; ++i) {
      DocumentSnapshot ds = await Firestore.instance.collection("users").document(widget.docIDList[i]).get();
      _userList.add(User.fromJson(ds.data));
    }
    return _userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        shadowColor: Colors.grey.shade200,
        title: Text("Likes"),
      ),
      body: FutureBuilder(
        future: getAllUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Container(
              constraints: BoxConstraints.expand(),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          if (_userList.length == 0) {
            return Container(
              constraints: BoxConstraints.expand(),
              child: Center(
                child: Text(
                  "No likes yet.",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
                ),
              ),
            );
          } else
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _userList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (builder, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey.shade300, spreadRadius: 2.0)],
                        ),
                        child: CircleAvatar(
                          radius: 23.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: _userList[index].photoURL,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        "@" + _userList[index].username,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _userList[index].firstName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: (BlocProvider.of<CurrentUserBloc>(context).state.username == _userList[index].username)
                          ? null
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: RaisedButton(
                                onPressed: () {
                                  /// Will [Follow] that person.
                                },
                                elevation: 0.0,
                                child: Text("Follow",
                                    style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                    ),
                    Divider(
                      endIndent: 8.0,
                      indent: 8.0,
                      height: 0.0,
                      color: Colors.grey.shade200,
                      thickness: 1.2,
                    )
                  ],
                );
              },
            );
        },
      ),
    );
  }
}
