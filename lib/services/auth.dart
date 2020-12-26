// import 'package:brew_crew/models/users.dart';
// import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phonetheft/services/models/user.dart';

class AuthServices {
  final FirebaseAuth _auths = FirebaseAuth.instance;

  // CREATE USER MOODEL FROM FIREBASE USER
  User _createCustomUser(user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  // CREATE CURRENT USER AUTH STATE CHANGE STREAM
  Stream<User> get user {
    return _auths.onAuthStateChanged.map(_createCustomUser);
  }

  // ANNONYMOUS SIGN IN
  Future signInAnum() async {
    try {
      AuthResult result = await _auths.signInAnonymously();
      FirebaseUser user = result.user;
      return _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // EMAIL SIGNIN
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auths.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // USER REGISTRATION
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auths.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // await DatabaseServices(uid: user.uid)
          // .updateUserData('0', 'New crew member', 100);
      return _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUser () async {
    dynamic user = _auths.currentUser();
    return user;
  }

  // SIGN OUT
  Future signOut() async {
    try {
      await _auths.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
