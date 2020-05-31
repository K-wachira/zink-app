import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import 'package:zink/services/user-modules/signup-signin/businessLogic/loggedinusers.dart';
import 'package:zink/services/mainScreens/PostDisplay/PostDialog.dart';
import 'package:zink/services/mainScreens/PostDisplay/ItemPost.dart';
import 'package:zink/services/user-modules/signup-signin/ui/loginSignup.dart';
import 'package:zink/shared-widgets/MorePopUpMenu.dart';


//This file  is responsible for displaying  images fetched from firestore using a stream builder


class imageloader extends StatefulWidget {
//  this are the parameters that we are getting from the home page to determine if user is logged in
  final bool isloggedin;
  final String UserId;

  imageloader({Key key, this.isloggedin, this.UserId}) : super(key: key);

  @override
  _imageloaderState createState() => _imageloaderState();
}

class _imageloaderState extends State<imageloader> {


//  Gets an instance of firestore
  var dbconn = Firestore.instance;



//  checks if user is logged in and returns true if user is logged in and vice versa:::: not sure we are usin it tho
  Future<bool> LoggedIn() async {
    print("userid :");
    FirebaseUser userdata = await FirebaseAuth.instance.currentUser();

    var userid = userdata.uid;
    print("userid : $userid");

    print(userdata.uid);
    if ((userdata.uid).length > 4) {
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("Zink"),
        actions: <Widget>[
          RaisedButton.icon(
              onPressed: () {
                if (widget.isloggedin) {
                  //TODO signup snack bar to prompt if they should sign up and it should be shared
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => userLoggedin()),
                  );
                } else {
                  //TODO implement a snack bar to show why they have to be logged in to <action perform> on click take them to loggin page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginandsignup()),
                  );
                }
              },
              icon: Icon(Icons.person),
              label: Text('Profile')),
          SizedBox(
            width: 20,
          )
        ],
        elevation: 1.0,
      ),
      body: StreamBuilder(
          stream: dbconn.collection("Posts").orderBy('uploadedOn' ,descending :true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            print("Snapshot data : ${snapshot.data.toString()}");

            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }),
    );
  }



//Widgets gives an instagram feel .....
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //          user info
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                // comment section
                children: <Widget>[
                  new Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(document['ImageURL'])),
                    ),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Text(
                    "#memehashtag",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              new IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => MorePopUpMenu(),
                ),
              )
            ],
          ),
        ),

//         Main picture
        GestureDetector(
//              brings up the image to focus on long press

          onLongPress: () => showDialog(
              context: context,
              builder: (context) => dialogbuilder(image: document['ImageURL'])),

//      Up voted the image on double tap TODO add animation on double tap
          onDoubleTap: () {
            print("Double tap value :");
            print(widget.isloggedin);
            print((widget.UserId).length);
            print("value above this is the result:");

            if (widget.isloggedin) {
              print(widget.isloggedin);

              document.reference
                  .updateData({'upvotes': document['upvotes'] + 1});
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(
                elevation: 2.0,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                backgroundColor: Colors.grey,
                content: FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Login/SignUp"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => loginandsignup()),
                    );
                  },
                ),
              ));
              //TODO beautify the snack bar
            }
          },

//      On tap opened the image comment section and gives the user chance to comment

          onTap: () {
            print("(_buildItem(context, document))");
            // pushing image id though this and use it to generate image document
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImageItem(image: document['ImageURL'], imagetag:  "#memehashtag")));
          },
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            height: 600,
            placeholder: (context, url) =>
                Image.asset('assets/images/loading.gif'),
            placeholderFadeInDuration: Duration(milliseconds: 300),
            imageUrl: document['ImageURL'],
          ),
        ),

//      handles like an save comment and share
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton.icon(
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                      ),
                      label: Text(
                        document["upvotes"].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (widget.isloggedin) {
                          document.reference
                              .updateData({'upvotes': document['upvotes'] + 1});
                        } else {
                          //TODO implement a snack bar to show why they have to be logged in to <action perform> on click take them to loggin page
                          Scaffold.of(context).showSnackBar(SnackBar(
                            elevation: 2.0,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            backgroundColor: Colors.grey,
                            content: FlatButton.icon(
                              icon: Icon(Icons.person),
                              label: Text("Login/SignUp"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginandsignup()),
                                );
                              },
                            ),
                          ));
                          //TODO beautify the snack bar
                        }
                      }),
                  FlatButton.icon(
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.black,
                      ),
                      label: Text(
                        document["downvotes"].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (widget.isloggedin) {
                          document.reference.updateData(
                              {'downvotes': document['downvotes'] + 1});
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            elevation: 2.0,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30))),
                            backgroundColor: Colors.grey,
                            content: FlatButton.icon(
                              icon: Icon(Icons.person),
                              label: Text("Login/SignUp"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginandsignup()),
                                );
                              },
                            ),
                          ));
                          //TODO beautify the snack bar
                        }
                      }),
                  SizedBox(
                    width: 15,
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  GestureDetector(
                    onTap: () =>
                        print("Share button clicked on displayimages.dart"),
                    child: new Icon(
                      FontAwesomeIcons.share,
                    ),
                  ),
                ],
              ),
              new Icon(FontAwesomeIcons.bookmark)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Tags: #Screenshot #meme #dark humor",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
        ),

        //  comment section

        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 40.0,
                width: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(document['ImageURL'])),
                ),
              ),
              new SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: new TextField(
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add a comment...",
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.black12,
          thickness: 1.2,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }




}
