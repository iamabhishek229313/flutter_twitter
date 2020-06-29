import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_clone/bloc/current_user/current_user_bloc.dart';
import 'package:twitter_clone/core/database_models/userModel.dart';
import 'package:twitter_clone/screens/home_screen/widgets/fab.dart';
import 'package:twitter_clone/utils/colors.dart';

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final User user = BlocProvider.of<CurrentUserBloc>(context).state;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: DefaultTabController(
//         length: 4,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverAppBar(
//                 backgroundColor: Colors.transparent,
//                 stretch: true,
//                 elevation: 0,
//                 forceElevated: false,
//                 expandedHeight: screenHeight * 0.5,
//                 floating: true,
//                 pinned: true,
//                 snap: false,
//                 flexibleSpace: FlexibleSpaceBar(
//                     stretchModes: <StretchMode>[
//                       StretchMode.zoomBackground,
//                       StretchMode.blurBackground
//                     ],
//                     // title: Text("Collapsing Toolbar"),
//                     background: Container(
//                       color: Colors.green,
//                       child: Stack(
//                         alignment: Alignment.topCenter,
//                         children: <Widget>[
//                           // SizedBox.expand(
//                           //   child: Container(
//                           //     //This is the inner most layer of the Flexible space bar.
//                           //     padding: EdgeInsets.only(top: 50),
//                           //     child: Column(
//                           //       mainAxisAlignment: MainAxisAlignment.center,
//                           //       crossAxisAlignment: CrossAxisAlignment.center,
//                           //       children: [
//                           //         Text(
//                           //           user.name,
//                           //           style: Theme.of(context).textTheme.headline5,
//                           //         ),
//                           //       ],
//                           //     ),
//                           //     color: Colors.white,
//                           //   ),
//                           // ),
//                           Container(
//                               //Cover photo here.
//                               height: screenHeight * 0.2,
//                               //padding: EdgeInsets.only(top: 30),
//                               child: Container(
//                                 color: Color.lerp(
//                                     AppColors.verifiedBlue, Colors.white, 0.25),
//                               )),

//                           //User avatar ,message ,profile following and followers button.

//                           Positioned(
//                             top: screenHeight * 0.2 -
//                                 ((screenHeight * 0.11) / 2),
//                             left: screenWidth * 0.03,
//                             child: Container(
//                               child: AnimatedContainer(
//                                 duration: Duration(microseconds: 500),
//                                 width: screenHeight * 0.11,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.white,
//                                     width: 5,
//                                   ),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100.0),
//                                   child: FadeInImage.memoryNetwork(
//                                     placeholder: kTransparentImage,
//                                     image: user.user_imageUrl,
//                                     fit: BoxFit.fitHeight,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               SliverPersistentHeader(
//                 delegate: _SliverAppBarDelegate(
//                   TabBar(
//                     tabs: [
//                       Tab(text: 'Tweets'),
//                       Tab(text: 'Tweets & replies'),
//                       Tab(text: 'Media'),
//                       Tab(text: 'Likes'),
//                     ],
//                   ),
//                 ),
//                 pinned: true,
//               )
//             ];
//           },
//           body: TabBarView(
//             children: [
//               ListView.builder(
//                 itemBuilder: (context, index) => Text('Tweet $index'),
//               ),
//               ListView.builder(
//                 itemBuilder: (context, index) => Text('Tweet $index'),
//               ),
//               ListView.builder(
//                 itemBuilder: (context, index) => Text('Tweet $index'),
//               ),
//               ListView.builder(
//                 itemBuilder: (context, index) => Text('Tweet $index'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FAB(
//         screenHeight: MediaQuery.of(context).size.height,
//       ),
//     );
//   }
// }

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

///// Abhihsek modifications.
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = BlocProvider.of<CurrentUserBloc>(context).state;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                color: Colors.black87,
              ),
              expandedHeight: screenHeight * 0.52,
              pinned: true,
              elevation: 0.0,
              stretch: true,
              actions: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black54),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                color: Colors.green,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          // Biggest container to give Stack some space.
                          // Should be untouched.
                          height:
                              (screenHeight * 0.2 + screenHeight * 0.14 / 2),
                        ),
                        Container(
                            height: screenHeight * 0.2,
                            width: screenWidth,
                            child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/mountain.jpg',
                                image: 'assets/images/mountain.jpg')),
                        Positioned(
                          top: screenHeight * 0.2 - ((screenHeight * 0.08) / 2),
                          left: screenWidth * 0.03,
                          child: Container(
                            child: AnimatedContainer(
                              duration: Duration(microseconds: 500),
                              width: screenHeight * 0.11,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: user.user_imageUrl,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: screenHeight * 0.2 + screenHeight * 0.005,
                          right: screenWidth * 0.03,
                          child: Container(
                            child: AnimatedContainer(
                              duration: Duration(microseconds: 500),
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.6,
                              decoration: BoxDecoration(
                                  color: AppColors.logoBlue,
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Info, Bio, Fllowing && Followers.
                    Expanded(
                        child: Container(
                      color: Colors.amber,
                    ))
                  ],
                ),
              )),
            ),
            SliverList(delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index <= 100) return Text("Tweet $index");
            }))
          ],
        ),
      ),
      floatingActionButton: FAB(
        screenHeight: MediaQuery.of(context).size.height,
      ),
    );
  }
}

// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//         body: CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           pinned: true,
//           expandedHeight: screenHeight * 0.5,
//           automaticallyImplyLeading: true,
//           flexibleSpace: FlexibleSpaceBar(
//             title: Text("Abhishek Rai"),
//             stretchModes: <StretchMode>[
//               StretchMode.zoomBackground,
//               StretchMode.blurBackground
//             ],
//           ),
//         )
//       ],
//     ));
//   }
// }
