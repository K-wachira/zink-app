import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zink/services/user-modules/signup-signin/ui/loginSignup.dart';
import 'package:zink/services/user-modules/signup-signin/user-account/userProfile.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/auth.dart';




class userLoggedin extends StatefulWidget {
  @override
  _userLoggedinState createState() => _userLoggedinState();
}

class _userLoggedinState extends State<userLoggedin> {




  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.hasData) {
//TODO maybe use case switch here to navigate through the many pages and actions if user is logged in
            return UserProfile();
          } else {
            return loginandsignup();
          }
        }
      },
    );
  }
}

