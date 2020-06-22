import 'package:flutter/widgets.dart';

class AppIcon {
  static final int fabTweet = 0xf029;
  static final int messageEmpty = 0xf187;
  static final int messageFill = 0xf554;
  static final int search = 0xf058;
  static final int searchFill = 0xf558;
  static final int notification = 0xf055;
  static final int notificationFill = 0xf019;
  static final int messageFab = 0xf053;
  static final int home = 0xf053;
  static final int homeFill = 0xF553;
  static final int heartEmpty = 0xf148;
  static final int heartFill = 0xf015;
  static final int settings = 0xf059;
  static final int adTheRate = 0xf064;
  static final int reply = 0xf151;
  static final int retweet = 0xf152;
  static final int image = 0xf109;
  static final int camera = 0xf110;
  static final int arrowDown = 0xf196;
  static final int blueTick = 0xf099;

  static final int link = 0xf098;
  static final int unFollow = 0xf097;
  static final int mute = 0xf101;
  static final int viewHidden = 0xf156;
  static final int block = 0xe609;
  static final int report = 0xf038;
  static final int pin = 0xf088;
  static final int delete = 0xf154;

  static final int profile = 0xf056;
  static final int lists = 0xf094;
  static final int bookmark = 0xf155;
  static final int moments = 0xf160;
  static final int twitterAds = 0xf504;
  static final int bulb = 0xf567;
  static final int newMessage = 0xf035;

  static final int sadFace = 0xf430;
  static final int bulbOn = 0xf066;
  static final int bulbOff = 0xf567;
  static final int follow = 0xf175;
  static final int thumbpinFill = 0xf003;
  static final int calender = 0xf203;
  static final int locationPin = 0xf031;
  static final int edit = 0xf112;
}

IconData CustomIconData(int codePoint){
  return IconData(codePoint , fontFamily: 'TwitterIcon', fontPackage: null);
}

class CustomIcon extends StatelessWidget {
  final int codePoint;

  const CustomIcon(this.codePoint, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(IconData(codePoint, fontFamily: 'TwitterIcon'));
  }
}