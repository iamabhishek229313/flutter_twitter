import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/screens/home_screen/widgets/navigationbar_home.dart';
import 'package:twitter_clone/utils/bottom_button.dart';
import 'package:twitter_clone/utils/colors.dart';

class WritingPanel extends StatefulWidget {
  final FirebaseUser user;

  const WritingPanel({Key key, this.user}) : super(key: key);

  @override
  _WritingPanelState createState() => _WritingPanelState();
}

class _WritingPanelState extends State<WritingPanel> {
  TextEditingController _tweetController;

  @override
  void initState() {
    super.initState();
    _tweetController = TextEditingController();
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
              child: Text("Tweet",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () {},
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
                  child: TextField(
                    cursorColor: AppColors.logoBlue,
                    controller: _tweetController,
                    decoration: InputDecoration(
                      hintText: 'What\'s happening?',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    // maxLength: 280, : To hide the letter count .
                    inputFormatters: [LengthLimitingTextInputFormatter(280)],
                    maxLines: 99999,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'HelveticaNeue',
                        fontSize: 21.0,
                        fontWeight: FontWeight.w500),
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
                        child: Container(
                          child: NavigationBar(
                            icon1: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                            icon2: Icon(
                              Icons.gif,
                              color: Colors.grey,
                            ),
                            icon3: Icon(
                              Icons.poll,
                              color: Colors.grey,
                            ),
                            icon4: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                          ),
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
}
