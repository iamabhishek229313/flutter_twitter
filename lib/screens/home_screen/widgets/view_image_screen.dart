import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class ViewImageScreen extends StatefulWidget {
  final String imageUrl;

  const ViewImageScreen({Key key, this.imageUrl}) : super(key: key);
  @override
  _ViewImageScreenState createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width ,
            height: 300.0,
            color: Colors.grey[700],
          ),
          PhotoView(imageProvider: NetworkImage(widget.imageUrl)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              AppIcon.reply,
                              size: 22.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("90",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          AppIcon.retweet,
                          size: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              AppIcon.heartEmpty,
                              size: 22.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("22",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    )))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.share,
                            size: 21.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade400,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
