import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/service/auth.dart';
import 'package:flash_chat/service/database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login_Screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Authentication authentication = Authentication();
  DataBase dataBase = DataBase();
  final signInFormKey = GlobalKey<FormState>();
  var userInfo;

  isUser({String email}) async {
    userInfo = await dataBase.getUserByEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.elliptical(600, 100)),
                gradient: LinearGradient(
                  begin: Alignment(0.15, -0.56),
                  end: Alignment(-0.44, 0.9),
                  colors: [const Color(0x804f3ee3), const Color(0x80c5dcfe)],
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
                  end: Alignment(-0.44, 0.9),
                  colors: [const Color(0xff4f3ee3), const Color(0xffbfd4f3)],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: "logo",
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Form(
                      key: signInFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: (value) {
                              var newValue = value.trimLeft();

                              if (newValue.isEmpty) {
                                return "Please Provide a valid Email";
                              }
                              isUser(email: newValue);
                              return RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(newValue)
                                  ? userInfo != null
                                      ? null
                                      : "That email address doesn't exist"
                                  : "Please provide a valid Email";
                              //check if the current email is equal to any email inside of database
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              //Do something with the user input.
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
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            obscureText: true,
                            onChanged: (value) {
                              //Do something with the user input.
                            },
                            decoration: KTextFieldDecoration.copyWith(
                                hintText: 'Enter your password.'),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      onPressed: () async {
                        print(
                            "===========================================> ${emailController.text},${passwordController.text}");

                        setState(() {
                          isLoading = true;
                        });
                        if (signInFormKey.currentState.validate()) {
                          try {
                            final user = await authentication.signInUser(
                                email: emailController.text,
                                password: passwordController.text);

                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            print(
                                "+++++++++++++++++++++++++++++++++++++==> $e");
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
                      title: "Log In",
                      colour: Colors.lightBlueAccent,
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Text(
                      "Sign in With",
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
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(17.0, 821.0),
              child: Container(
                width: 55.0,
                height: 55.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  gradient: LinearGradient(
                    begin: Alignment(1.25, -1.76),
                    end: Alignment(-1.0, 1.29),
                    colors: [const Color(0xff0022ff), const Color(0x003c6b8b)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   Form(
//                 key: signInFormKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       validator: (value) {
//                         var newValue = value.trimLeft();
//
//                         if (newValue.isEmpty) {
//                           return "Please Provide a valid Email";
//                         }
//                         isUser(email: newValue);
//                         return RegExp(
//                                     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//                                 .hasMatch(newValue)
//                             ? userInfo != null
//                                 ? null
//                                 : "That email address doesn't exist"
//                             : "Please provide a valid Email";
//                         //check if the current email is equal to any email inside of database
//                       },
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       textAlign: TextAlign.center,
//                       onChanged: (value) {
//                         //Do something with the user input.
//                       },
//                       decoration: KTextFieldDecoration.copyWith(
//                           hintText: 'Enter your email'),
//                     ),
//                     SizedBox(
//                       height: 8.0,
//                     ),
//                     TextFormField(
//                       validator: (value) {
//                         var newValue = value.trimLeft();
//
//                         if (newValue.isEmpty) {
//                           return "Please provide password with +7 Character";
//                         }
//                         if (newValue.length >= 7) {
//                           return null;
//                         } else {
//                           return "Please provide password with +7 Character";
//                         }
//                       },
//                       controller: passwordController,
//                       textAlign: TextAlign.center,
//                       obscureText: true,
//                       onChanged: (value) {
//                         //Do something with the user input.
//                       },
//                       decoration: KTextFieldDecoration.copyWith(
//                           hintText: 'Enter your password.'),
//                     ),
//                     SizedBox(
//                       height: 24.0,
//                     ),
//                   ],
//                 ),
//               ),
