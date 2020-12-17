import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "Welcome_Screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //     duration: Duration(seconds: 5),
  //     vsync: this,
  //   );
  //   animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
  //       .animate(controller);
  //   controller.forward();
  //   controller.addListener(
  //     () {
  //       setState(() {});
  //       print(animation.value);
  //     },
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: animation.value,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 1.0),
            colors: [const Color(0xc70303f3), const Color(0x7803ff89)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 80,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TypewriterAnimatedTextKit(
                    text: ['One Chat'],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: const Duration(milliseconds: 300),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log In',
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: 'Register',
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//https://www.youtube.com/watch?v=cSX3MTNBaj8&t=4694s
//
