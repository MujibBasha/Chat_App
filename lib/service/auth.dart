import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authentication {
  FirebaseAuth _auth;
  Authentication() {
    initFirebase();
  }
  initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
  }

  Future signUpNewUser({String email, String password}) async {
    await Firebase.initializeApp();

    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future getCurrentUser() async {
    FirebaseAuth _authRef = FirebaseAuth.instance;
    return _authRef.currentUser;
  }

  Future signInUser({String email, String password}) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  signOut() {
    _auth.signOut();
  }
}
