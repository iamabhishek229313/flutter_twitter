import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/core/models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    stretch: true,
                    elevation: 0,
                    forceElevated: false,
                    expandedHeight: 300.0,
                    floating: true,
                    pinned: true,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: <StretchMode>[
                          StretchMode.zoomBackground,
                          StretchMode.blurBackground
                        ],
                        // title: Text("Collapsing Toolbar"),
                        background: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            SizedBox.expand(
                              child: Container(
                                //This is the inner most layer of the Flexible space bar.
                                padding: EdgeInsets.only(top: 50),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                color: Colors.white,
                              ),
                            ),

                            Container(
                                //Cover photo here.
                                height: 130,
                                //padding: EdgeInsets.only(top: 30),
                                child: Container(
                                  color: Color.lerp(AppColors.verifiedBlue,
                                      Colors.white, 0.25),
                                )),

                            //User avatar ,message ,profile following and followers button.

                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.1,
                              left: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                // alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    AnimatedContainer(
                                      duration: Duration(microseconds: 500),
                                      // padding:
                                      //     EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 5,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: user.user_imageUrl,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 90, right: 30),
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.blueAccent,
                                      height: 40,
                                    )
                                  ],
                                ))
                          ],
                        )),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        tabs: [
                          Tab(text: 'Tweets'),
                          Tab(text: 'Tweets & replies'),
                          Tab(text: 'Media'),
                          Tab(text: 'Likes'),
                        ],
                      ),
                    ),
                    pinned: true,
                  )
                ];
              },
              body: SafeArea(
                              child: Positioned(
                  top: kToolbarHeight + kTextTabBarHeight,
                  child: Container(
                    child: Text('Hello'),
                  ),
                ),
              ))),
      floatingActionButton: FAB(
        screenHeight: MediaQuery.of(context).size.height,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
