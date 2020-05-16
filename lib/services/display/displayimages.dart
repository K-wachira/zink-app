import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class imageloader extends StatelessWidget {
  var dbconn = Firestore.instance;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Column(
      children: <Widget>[

        cd
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