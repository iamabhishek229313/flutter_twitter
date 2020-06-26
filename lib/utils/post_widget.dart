import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:twitter_clone/core/models/postModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/view_image_screen.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class PostWidget extends StatefulWidget {
  @required
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  void _handleBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (builder) {
          return Column(
            children: [
              Container(
                height: 150.0,
                color: Colors.amber,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                          image: widget.post.user.user_imageUrl,
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
                      widget.post.user.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "HelveticaNeue",
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        '@' + widget.post.user.email_id,
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
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          Flexible(
                            child: Text(
                              timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.post.timeStamp)),
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
                        onTap: _handleBottomSheet,
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
                      style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                          color: Colors.black,
                          fontSize: 16.0),
                    ),
                    // Will do in the new example.
                    (widget.post.attached_image == null)
                        ? Container()
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.27,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[200],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewImageScreen(
                                              imageUrl:
                                                  widget.post.attached_image,
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
                          onTap: () {},
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
                                  child: Text("90",
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
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(
                                AppIcon.heartEmpty,
                                size: 19.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text("22",
                                      style: TextStyle(fontSize: 16.0)))
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
  }
}
