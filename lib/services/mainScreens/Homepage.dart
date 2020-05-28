import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zink/services/JokesAPI/notYetImplemented.dart';
import 'package:zink/services/mainScreens/PostDisplay/displayimages.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:zink/services/imageuploading/imagepicker.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/loggedinusers.dart';
import 'package:zink/services/user-modules/signup-signin/ui/loginSignup.dart';

import 'SideBar.dart';

class Homepages extends StatefulWidget {
  @override
  _HomepagesState createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  bool isloggedin = false;
  int _currentIndex = 0;
  FirebaseUser user;
  var userobject;
  String userName;
  String UserID;
  Firestore _db = Firestore.instance;
  PageController _pageController;

  Future<void> getCurrentUser() async {
    FirebaseUser userdata = await FirebaseAuth.instance.currentUser();

    if (((userdata.uid).length) > 5) {
      setState(() {
        print(userdata.uid);
        UserID = userdata.uid;
        isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db.settings(persistenceEnabled: true, cacheSizeBytes: 1048576);
    _pageController = PageController();

    getCurrentUser();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            imageloader(isloggedin: isloggedin, UserId: UserID),
            ImageCaptures(isloggedin: isloggedin, UserId: UserID),
            StatusWheelView(),
            loginandsignup(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Home Feed'), icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Text('Upload Photos'), icon: Icon(Icons.add_a_photo)),
          BottomNavyBarItem(
              title: Text('Messages'), icon: Icon(Icons.chat_bubble)),
          BottomNavyBarItem(
              title: Text('Activity'), icon: Icon(Icons.track_changes)),
        ],
      ),
    );
  }
}
