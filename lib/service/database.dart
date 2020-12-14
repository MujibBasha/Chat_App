import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBase {
  FirebaseFirestore _fireStore;
  DataBase() {
    initialFirebase();
  }
  initialFirebase() async {
    await Firebase.initializeApp();
    _fireStore = FirebaseFirestore.instance;
  }

  createChatRooms({Map messageMap}) {
    _fireStore.collection("messages").add(messageMap);
  }

  // Future getChatMessages() {
  //   // ignore: deprecated_member_use
  //   return _fireStore.collection("messages").getDocuments();
  // }

  getChatMessageStream() async* {
    yield* _fireStore.collection("messages").orderBy('time').snapshots();
  }

  getCurrentSender() {}
}
