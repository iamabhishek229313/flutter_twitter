import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                        title: Text("Collapsing Toolbar"),
                        background: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            SizedBox.expand(
                              child: Container(                   //This is the inner most layer of the Flexible space bar.
                                padding: EdgeInsets.only(top: 50),
                                height: 30,
                                color: Colors.red,  
                              ),
                            ),

                            

                            Container(          //Cover photo here.
                                height: 130,
                                //padding: EdgeInsets.only(top: 30),
                                child: Container(
                                  color: Colors.amber,
                                )
                            ),

                            //User avatar ,message ,profile following and followers button.

                            Container(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    AnimatedContainer(
                                      duration: Duration(microseconds: 500),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 5),
                                          shape: BoxShape.circle),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                                Container(
                                  margin: EdgeInsets.only(top:90, right: 30),
                                  child: Row(
                                    children: [
                                      Container(color: Colors.blueAccent,height: 40,)
                                    ],
                                  )
                                )
                          ],
                        )),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Tweets',
                            ),
                          ),
                          Tab(text: 'Tweets & replies'),
                          Tab(text: 'Media'),
                          Tab(
                            text: 'Likes',
                          )
                        ],
                      ),
                    ),
                    pinned: true,
                  )
                ];
              },
              body: Container(
                child: Text('Hello'),
              ))),
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
