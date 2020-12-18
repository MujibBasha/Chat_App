import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBase {
  FirebaseFirestore _fireStore;
  DataBase() {
    initialFirebase();
  }
  initialFirebase() async {
    // try {
    await Firebase.initializeApp();
    _fireStore = FirebaseFirestore.instance;
    // } catch (e) {
    //   print(e);
    //   //show Screen
    // }
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

  addUserInfo({userInfoMap}) {
    _fireStore.collection("users").add(userInfoMap);
  }

  Future getUserByEmail({String email}) {
    return _fireStore
        .collection("users")
        .where("email", isEqualTo: email)
        // ignore: deprecated_member_use
        .getDocuments();
  }
}
