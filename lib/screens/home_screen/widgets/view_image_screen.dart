import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

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
    // return Scaffold(
    //   backgroundColor: Colors.orange,
    //   body: SafeArea(
    //     child: Stack(
    //       children: [
    //         PhotoView(imageProvider: NetworkImage(widget.imageUrl)),
    //         Align(
    //           alignment: Alignment.topCenter,
    //           child: Container(
    //             height: MediaQuery.of(context).padding.top + AppBar().preferredSize.height,
    //             child: BackdropFilter(
    //               filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                 child: Row(
    //                   children: [
    //                     IconButton(
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                       icon: Icon(
    //                         Icons.arrow_back,
    //                         color: AppColors.verifiedBlue,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        brightness: Brightness.dark,
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                /// [Download Image] -- Functionality to be added and then show a SnackBar.
              })
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.imageUrl),
      ),
    );
  }
}
