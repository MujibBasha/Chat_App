import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/service/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "Registration_Screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth.instance;
  final signUpFormKey = GlobalKey<FormState>();
  String email;
  String password;
  bool isLoading = false;
  Authentication authentication = Authentication();
  DataBase dataBase = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.elliptical(600, 100)),
              gradient: LinearGradient(
                begin: Alignment(0.15, -0.56),
                end: Alignment(-0.51, 0.83),
                colors: [const Color(0x804f3ee3), const Color(0x1e00ffa8)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              //:
              //BorderRadius.o(Radius.elliptical(9999.0, 9999.0)),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(9999.0, 5000.0)),
              gradient: LinearGradient(
                begin: Alignment(0.34, -0.94),
                end: Alignment(-0.24, 0.55),
                colors: [const Color(0xff4f3ee3), const Color(0xff88ffe7)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: "logo",
                      child: Container(
                        height: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'images/logo.png',
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: TypewriterAnimatedTextKit(
                                text: ["welcome"],
                                textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                                speed: const Duration(milliseconds: 300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(children: [
                      SizedBox(
                        height: 48.0,
                      ),
                      Form(
                          key: signUpFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  var newValue = value.trimLeft();
                                  if (newValue.isEmpty) {
                                    return "Please Provide a valid Email";
                                  }

                                  return RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(newValue)
                                      ? null
                                      : "Please provide a valid Email";
                                },
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  //Do something with the user input.
                                  email = value;
                                },
                                decoration: KTextFieldDecoration.copyWith(
                                    hintText: 'Enter your email'),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                validator: (value) {
                                  var newValue = value.trimLeft();

                                  if (newValue.isEmpty) {
                                    return "Please provide password with +7 Character";
                                  }
                                  if (newValue.length >= 7) {
                                    return null;
                                  } else {
                                    return "Please provide password with +7 Character";
                                  }
                                },
                                textAlign: TextAlign.center,
                                obscureText: true,
                                onChanged: (value) {
                                  //Do something with the user input.
                                  password = value;
                                },
                                decoration: KTextFieldDecoration.copyWith(
                                    hintText: 'Enter your password'),
                              ),
                              SizedBox(
                                height: 24.0,
                              ),
                            ],
                          )),
                      Column(children: [
                        RoundedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            if (signUpFormKey.currentState.validate()) {
                              try {
                                final newUser =
                                    await authentication.signUpNewUser(
                                        email: email, password: password);

                                if (newUser != null) {
                                  Map<String, String> userInfoMap = {
                                    "email": "$email",
                                    "name": "null",
                                    "password": "$password",
                                  };
                                  await dataBase.addUserInfo(
                                      userInfoMap: userInfoMap);
                                  Navigator.pushNamed(context, ChatScreen.id);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              } catch (e) {
                                print(
                                    "+++++++++++++++++++++++++++++++++++++++++++>$e");
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          title: "Register",
                          colour: Colors.blueAccent,
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        Text(
                          "Sign up With",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                child: FloatingActionButton(
                                  heroTag: "facebook",
                                  child: Image.asset('images/facebook.png'),
                                  onPressed: () {
                                    print("clicked on facebook button");
                                  },
                                ),
                              ),
                              SizedBox(width: 25),
                              Container(
                                width: 45,
                                height: 45,
                                child: FloatingActionButton(
                                  heroTag: "google",
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset('images/google.png'),
                                  onPressed: () {
                                    print("clicked on facebook button");
                                  },
                                ),
                              ),
                            ]),
                      ]),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
