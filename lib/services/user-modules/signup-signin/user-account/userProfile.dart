import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:zink/services/mainScreens/Homepage.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/auth.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/model/user.dart';

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
      userid = user.uid;
      print(user.email);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    checkUserData();
    _db.settings(persistenceEnabled: true, cacheSizeBytes: 1048576);
  }

  static Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("Users/$userID").get().then((doc) {
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

  checkUserData() async {
    //TODO fix the logic here for user doc creation and reading
    await checkUserExist(userid).then((value) {
      print("Value $value");
      if (!value) {
        //data doesnt exist..create data
        Firestore.instance.collection("Users").document(user.uid).setData({
          "userImage": null,
          "Gender": null,
          "commentedPosts": [0],
          "downvotedPosts": [0],
          "email": user.email,
          "joinedOn": DateTime.now(),
          "upvotedPosts": [0],
          "userName": null,
          "phoneNo": 0,
        });
      }
    });
  }

  void _signOut() async {
    AuthService.signOut();
    Get.to(Homepage());
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
                    print(userid);
                    var userImage = userDoc["userImage"];
                    var Gender = userDoc["Gender"];
                    var commentedPosts = userDoc["commentedPosts"];
                    var downvotedPosts = userDoc["downvotedPosts"];
                    var email = userDoc["email"];
                    var joinedOn = userDoc["joinedOn"];
                    var upvotedPosts = userDoc["upvotedPosts"];
                    var userName = userDoc["userName"];

                    print(userName);

                    return Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Image.network(
                            userImage,
                            fit: BoxFit.cover,
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
                                                userImage),
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
