import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userid = '';

  //  create user obj based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // register user using email and pass
  Future registerwithEmailandpass(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      userid = user.uid;
      print(user.uid);

      checkUserExist(user.uid).then((value) {
        if (!value) {
          Firestore.instance.document("Users/${user.uid}").setData({
            'userImage': null,
            'userName': null,
            'email': null,
            'joinedOn': 0,
            'Gender': 0,
            'upvotedPosts': [0],
            'downvotedPosts': [0],
            'commentedPosts': [0],
          });
        }
        return false;
      });

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // login registered users
  Future loginwithEmailandpass(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static void addUser(userid) {
    print('User id : $userid');
    var uid = userid;
    print('User id in: $uid');
    checkUserExist(uid).then((value) {
      if (!value) {
        Firestore.instance.document("Users/${uid}").setData({
          'userImage': null,
          'userName': null,
          'email': null,
          'joinedOn': 0,
          'Gender': 0,
          'upvotedPosts': [0],
          'downvotedPosts': [0],
          'commentedPosts': [0],
        });
      }
      return false;
    });
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("Users/$userId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
