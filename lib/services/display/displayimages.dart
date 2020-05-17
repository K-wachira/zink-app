import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';

class imageloader extends StatelessWidget {
  var dbconn = Firestore.instance;

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
                    "#memehastag",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              new IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: null,
              )
            ],
          ),
        ),

//         Main picture
        Flexible(
            fit: FlexFit.loose,
            child: FadeInImage.assetNetwork(
              
              placeholder: 'assets/images/loading.gif',
              image: document['ImageURL'],
              fit: BoxFit.cover,
            )),

//          handles like an save comment and share
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
                        document.reference
                            .updateData({'upvotes': document['upvotes'] + 1});
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
                        document.reference.updateData(
                            {'downvotes': document['downvotes'] + 1});
                      }),
                  SizedBox(
                    width: 15,
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(FontAwesomeIcons.share),
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder(
          stream: dbconn.collection("Posts").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("loading....");
            print("Snapshot data : ${snapshot.data.toString()}");
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.documents[index]),
            );
          }),
    );
  }
}

//
//children: <Widget>[
//ListTile(
//title: Row(
//children: <Widget>[
//Expanded(
//child: Text(
//document['ImageURL'].toString(),
//),
//),
//Container(
//child: Text(
//document["Likes"].toString(),
//style: TextStyle(color: Colors.red),
//),
//)
//],
//),
//),
//],
