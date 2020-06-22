import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/models/postModel.dart';
import 'package:twitter_clone/core/models/userModel.dart';
import 'package:twitter_clone/utils/bottom_button.dart';
import 'package:twitter_clone/utils/colors.dart';
import 'package:twitter_clone/utils/constant_icons.dart';

class WritingPanel extends StatefulWidget {
  final FirebaseUser user;

  const WritingPanel({Key key, this.user}) : super(key: key);

  @override
  _WritingPanelState createState() => _WritingPanelState();
}

class _WritingPanelState extends State<WritingPanel> {
  TextEditingController _tweetController;
  DatabaseAPI _dbAPIofPosts;
  @override
  void initState() {
    super.initState();
    _tweetController = TextEditingController();
    _dbAPIofPosts = DatabaseAPI("posts");
  }

  @override
  void dispose() {
    _tweetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
            child: RaisedButton(
              elevation: 0.0,
              disabledColor: AppColors.logoBlue.withAlpha(100),
              child: Text("Tweet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              onPressed: _tweetController.text.isEmpty
                  ? null
                  : () {
                      User user = User(
                          name: widget.user.displayName,
                          email_id: widget.user.email,
                          user_imageUrl: widget.user.photoUrl);

                      _dbAPIofPosts.addDocumentInCollection(Post(
                              attached_images: null,
                              user: user,
                              post_comments: null,
                              timeStamp: DateTime.now().millisecondsSinceEpoch,
                              post_likes: null,
                              tweet: _tweetController.text)
                          .toJson());
                      Navigator.pop(context);
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
        leading: Transform.rotate(
          angle: 40,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pop(context),
            iconSize: 35.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CircleAvatar(
                      radius: 23.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.user.photoUrl,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  )),
              new Expanded(
                  flex: 12,
                  child: Center(
                    child: _image != null
                        ? Container(child: Image.file(_image))
                        : TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: _tweetController,
                            cursorColor: AppColors.logoBlue,
                            decoration: InputDecoration(
                              hintText: 'What\'s happening?',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.multiline,
                            // maxLength: 280, : To hide the letter count .
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(280)
                            ],
                            maxLines: 50,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'HelveticaNeue',
                                fontSize: 21.0,
                                fontWeight: FontWeight.w500),
                          ),
                  )),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Divider(
                    thickness: 1.2,
                    height: 1.0,
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon: Icon(AppIcon.image),
                                color: Colors.blue,
                                onPressed: getImage),
                            CircularPercentIndicator(
                              radius: 35.0,
                              progressColor: _tweetController.text.length < 125
                                  ? Colors.green
                                  : (_tweetController.text.length >= 125 &&
                                          _tweetController.text.length < 220)
                                      ? Colors.amber
                                      : _tweetController.text.length >= 220
                                          ? Colors.redAccent
                                          : Colors.transparent,
                              lineWidth: 3.0,
                              percent: _tweetController.text.length / 280,
                              center: Text((280 - _tweetController.text.length)
                                  .toString()),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
