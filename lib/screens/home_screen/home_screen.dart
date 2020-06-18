import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/models/post.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: AppColors.white,
        leading: Container(
          height: screenHeight * 0.005,
          width: screenHeight * 0.005,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border),
            onPressed: () {},
            color: AppColors.logoBlue,
            iconSize: 32.0,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: List.generate(
          dummy_posts.length,
          (index) => IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                          child: Image(
                              height: 60.0,
                              image: AssetImage(
                                  dummy_posts[index].user.user_imageUrl)),
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
                          dummy_posts[index].user.name,
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
                            dummy_posts[index].user.user_id,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "HelveticaNeue",
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0),
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(6.0),
                              height: 3.0,
                              width: 3.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            Text(
                              dummy_posts[index].timeStamp,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: "HelveticaNeue",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17.0),
                            ),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          dummy_posts[index].tweet,
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                        Container(
                          height: screenHeight * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.indigo
                          ),
                        ),
                        Divider(
                          thickness: 1.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FAB(screenHeight: screenHeight),
    );
  }
}

