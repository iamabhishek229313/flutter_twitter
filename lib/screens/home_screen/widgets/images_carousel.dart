//Not being used now.

import 'package:flutter/material.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';

class ImagesCarousel extends StatefulWidget {
  final List<LocalImage> list;

  const ImagesCarousel({Key key, this.list}) : super(key: key);

  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width * 0.22,
              margin: EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Colors.blue,
                child: Image(
                  image: DeviceImage(widget.list[index]),
                ),
                // child: Center(
                //   child: Text(widget.list[index].,
                //       style: TextStyle(color: Colors.white, fontSize: 20.0)),
                // ),
              ),
            );
          }),
    );
  }
}
