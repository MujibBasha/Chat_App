import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth _auth;
  Authentication() {
    initFirebase();
  }
  initFirebase() async {
    // try {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    // } catch (e) {
    //   print(e);
    //   //show Screen
    // }
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

  signInWithGoogle() {}
}
