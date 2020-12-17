import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/service/auth.dart';
import 'package:flash_chat/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen_Screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController sendMessageController = TextEditingController();
  Authentication authentication = Authentication();
  DataBase dataBase = DataBase();
  // ignore: deprecated_member_use
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getMessageStream();
  }

  getCurrentUser() async {
    try {
      final User user = await authentication.getCurrentUser();
      if (user != null) {
        loggedInUser = user;
        print(">>>>>>>>>>>>>>>>>>>>>>> >>>>>>>>>>>>> ${loggedInUser.email}");
      }
    } catch (e) {
      print(e);
    }
  }

  getMessageStream() async {
    var snapShots = dataBase.getChatMessageStream();
    await for (QuerySnapshot snapshot in snapShots) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  // getMessages() async {
  //   QuerySnapshot messages = await dataBase.getChatMessages();
  //
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  //
  // get() async {
  //   return await ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // getMessageStream();
                try {
                  authentication.signOut();
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        //⚡️Chat
        title: Row(
          children: [
            Image.asset(
              "images/logo.png",
              height: 50,
              width: 50,
            ),
            Text('️Chat'),
          ],
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStreamState(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: sendMessageController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      if (sendMessageController.text.isNotEmpty) {
                        //Implement send functionality.
                        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${loggedInUser.email},${sendMessageController.text}");
                        Map<String, dynamic> messageMap = {
                          "text": sendMessageController.text,
                          "sender": loggedInUser.email == null
                              ? "No One"
                              : loggedInUser.email,
                          "time": DateTime.now().millisecondsSinceEpoch,
                        };
                        sendMessageController.clear();
                        await dataBase.createChatRooms(messageMap: messageMap);
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  MessageBubble({this.sender, this.text, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 1.5,
          ),
          Material(
            color: isMe ? Colors.blue : Colors.white,
            elevation: 5.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text ?? "",
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamState extends StatefulWidget {
  @override
  _MessageStreamStateState createState() => _MessageStreamStateState();
}

class _MessageStreamStateState extends State<MessageStreamState> {
  DataBase dataBase = DataBase();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dataBase.getChatMessageStream(),
      builder: (context, snapshot) {
        //https://www.youtube.com/watch?v=sD0sOoqUJpY
        if (!snapshot.hasData) {
          return Expanded(
            child: Container(
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              )),
            ),
          );
        }
        // final messages = ;
        List<Widget> messageBubbles = [];
        for (DocumentSnapshot message in snapshot.data.documents.reversed) {
          final messageText = message.get('text');
          print("))))))))))))))))))))))))))))))))))))))))))))))  $messageText");
          final messageSender = message.get("sender");
          print(
              "))))))))))))))))))))))))))))))))))))))))))))))  $messageSender");
          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            isMe: currentUser == messageSender,
            sender: messageSender,
            text: messageText,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
