import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

List<PageViewModel> introPages = [
  PageViewModel(
    //ONE GROUP CHAT
    pageColor: const Color(0xc7007aff),
    iconImageAssetPath: null,
    iconColor: Colors.white,
    bubbleBackgroundColor: Colors.black26,
    body: Text(
      'All Users in one group as one community.',
      textAlign: TextAlign.center,
    ),
    title: Text(
      'ONE GROUP\nCHAT',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        fontFamily: "PTSerif",
      ),
    ),
    mainImage: Image.asset(
      'images/group.png',
      height: 200.0,
      width: 200.0,
      alignment: Alignment.center,
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  ),
  PageViewModel(
    //PRIVATE MESSAGES
    pageColor: const Color(0xff0096ed),
    iconImageAssetPath: null,
    iconColor: Colors.white,
    bubbleBackgroundColor: Colors.black26,
    body: Text(
      'Communicate With your friends via private messages.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Roboto",
      ),
    ),
    title: Text(
      'PRIVATE\nMESSAGES',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "PTSerif",
      ),
    ),
    mainImage: Image.asset(
      'images/secure.png',
      height: 200.0,
      width: 200.0,
      alignment: Alignment.center,
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  ),
  PageViewModel(
    // notifications
    pageColor: const Color(0xff00bed4),
    iconImageAssetPath: null,
    iconColor: Colors.white,
    bubbleBackgroundColor: Colors.black26,
    body: Text(
      ' Receive notifications when friends are looking\nfor you.',
      textAlign: TextAlign.center,
    ),
    title: Text(
      'GET\nNOTIFIED',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "PTSerif",
      ),
    ),
    mainImage: Image.asset(
      'images/notification.png',
      height: 200.0,
      width: 200.0,
      alignment: Alignment.center,
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  ),
  // PageViewModel(
  //   pageColor: const Color(0xff00db87),
  //   iconImageAssetPath: null,
  //   iconColor: Colors.white,
  //   bubbleBackgroundColor: Colors.black26,
  //   body: Text(
  //     'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
  //   ),
  //   title: Text(
  //     'Cabs',
  //     textAlign: TextAlign.center,
  //     style: TextStyle(
  //       fontFamily: "PTSerif",
  //     ),
  //   ),
  //   mainImage: Image.asset(
  //     'images/notification.png',
  //     height: 285.0,
  //     width: 285.0,
  //     alignment: Alignment.center,
  //     color: Colors.white,
  //   ),
  //   titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  //   bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
  // ),
];

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final pages = introPages;
  @override
  Widget build(BuildContext context) {
    return IntroViewsFlutter(
      pages,
      onTapDoneButton: () {
        Navigator.pushNamed(context, WelcomeScreen.id);
      },
      showSkipButton: true,
      pageButtonTextStyles: new TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: "Regular",
      ),
    );
  }
}
