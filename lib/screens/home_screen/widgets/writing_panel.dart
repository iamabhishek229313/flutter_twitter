import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/database/database_api.dart';
import 'package:twitter_clone/core/models/postModel.dart';
import 'package:twitter_clone/core/models/userModel.dart';
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

  File _image;
  ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _tweetController = TextEditingController();
    _dbAPIofPosts = DatabaseAPI("posts");
    _picker = ImagePicker();
  }

  @override
  void dispose() {
    _tweetController.dispose();
    super.dispose();
  }

  Future getGalleryImage() async {
    final pickedFile = await _picker?.getImage(source: ImageSource.gallery);
    print("Picked File is : " + pickedFile.toString());
    setState(() {
      _image = pickedFile == null ? _image : File(pickedFile.path);
    });
  }

  Future getCameraImage() async {
    final pickedFile = await _picker?.getImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile == null ? _image : File(pickedFile.path);
    });
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
      body: Container(
        child: Stack(
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
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
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'HelveticaNeue',
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            _image == null
                                ? Container()
                                : Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.27,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.file(
                                            _image,
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _image = null;
                                            });
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      240, 240, 240, 0.6)),
                                              child: Icon(
                                                Icons.delete_forever,
                                                size: 35.0,
                                              )),
                                        ),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomBar(context))
          ],
        ),
      ),
    );
  }

  Container bottomBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      color: Colors.white,
      child: Container(
        child: Column(
          children: [
            Divider(
              thickness: 1.2,
              height: 1.0,
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [selectImage(), characterCount()],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Row selectImage() {
    return Row(
      children: [
        IconButton(
          icon: Icon(AppIcon.camera),
          onPressed: getCameraImage,
          color: AppColors.logoBlue,
        ),
        IconButton(
            icon: Icon(AppIcon.image),
            color: AppColors.logoBlue,
            onPressed: getGalleryImage),
      ],
    );
  }

  CircularPercentIndicator characterCount() {
    return CircularPercentIndicator(
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
      center: Text((280 - _tweetController.text.length).toString()),
    );
  }
}
