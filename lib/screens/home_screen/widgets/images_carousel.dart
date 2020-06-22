import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImagesCarousel extends StatefulWidget {
  @override
  _ImagesCarouselState createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        enableInfiniteScroll: false,
        aspectRatio: 16/9,
        scrollDirection: Axis.horizontal),
      items: [1, 2, 3, 4, 5].map((e) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20)
                //image: Image.file(file)
                ),
              child: RaisedButton(
                onPressed: () => {},
                              child: Text(
                  '$e',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
