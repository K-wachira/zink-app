import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zink/services/mainScreens/Homepage.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/auth.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseUser user;
  String userid;
  var userobject;
  String userName;
  Firestore _db = Firestore.instance;

  Future<void> getCurrentUser() async {
    FirebaseUser userdata = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userdata;
      print(user.uid);
      print(1);
      userid = user.uid;
      print(user.email);
    });
  }

  void username() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _db.settings(persistenceEnabled: true, cacheSizeBytes: 1048576);

      getCurrentUser();
  }

  static Future<bool> checkUserExist(String userid) async {
    bool exists = false;
    try {
      await Firestore.instance.document("Users/$userid").get().then((doc) {
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


  void _signOut() async {
    AuthService.signOut();
    Get.to(Homepages());
  }

  final image =
      'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: _db.collection("Users").document(userid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SpinKitDoubleBounce(
                        color: Colors.blue,
                      );
                    }

                    var userDoc = snapshot.data;
                    print("uid $userid");
                    var Gender = userDoc["Gender"];
                    var commentedPosts = userDoc["commentedPosts"];
                    var downvotedPosts = userDoc["downvotedPosts"];
                    var email = userDoc["email"];
                    var joinedOn = userDoc["joinedOn"];
                    var upvotedPosts = userDoc["upvotedPosts"];
                    var userName = userDoc["userName"];

                    print(" name $userName");
                    print(joinedOn);

                    return Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child :CachedNetworkImage(
                            placeholder: (context, url) =>
                                Image.asset('assets/images/loading.gif'),
                            placeholderFadeInDuration: Duration(milliseconds: 300),
                            imageUrl: userDoc["userImage"],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16.0),
                                    margin: EdgeInsets.only(top: 16.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 96.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "User Name: $userName",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .title,
                                              ),
                                              ListTile(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                title: Text("Karmas: </>"),
                                                subtitle: Text(
                                                    "Joined on: $joinedOn "),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("$upvotedPosts"),
                                                  Text("Upvotes")
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("$downvotedPosts"),
                                                  Text("Down votes")
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text("$commentedPosts"),
                                                  Text("Comments")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                userDoc["userImage"]),
                                            fit: BoxFit.cover)),
                                    margin: EdgeInsets.only(left: 16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("User information"),
                                    ),
                                    Divider(),
                                    ListTile(
                                      title: Text("User name"),
                                      subtitle: Text("$userName"),
                                      leading: Icon(Icons.phone),
                                    ),
                                    ListTile(
                                      title: Text("Email"),
                                      subtitle: Text(' $email'),
                                      leading: Icon(Icons.email),
                                    ),
//                                  /
                                    ListTile(
                                      title: Text("Phone"),
                                      subtitle: Text("+977-9815225566"),
                                      leading: Icon(Icons.phone),
                                    ),
                                    ListTile(
                                      title: Text("Joined Date"),
                                      subtitle: Text("$joinedOn"),
                                      leading: Icon(Icons.calendar_view_day),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.exit_to_app),
                                      onPressed: _signOut,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 325.0),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(Icons.settings),
                                    Text("Terms and Conditions"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ],
                    );
                  })
            ],
          ),
        ));
  }
}
