//import 'dart:html';
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//
//
//
//
//
//class Uploader extends StatefulWidget {
//  final File file;
//
//  Uploader({Key key, this.file}) : super(key: key);
//
//  _UploaderState createState() => _UploaderState();
//}
//
//class _UploaderState extends State<Uploader> {
//  String ImgUrl;
//  final FirebaseStorage _storage =
//  FirebaseStorage(storageBucket: "gs://zink-project.appspot.com/");
//
//  StorageUploadTask _uploadTask;
//
//  void _startUpload() async {
//    var filename = DateTime.now();
//    String filePath = 'images/$filename.png';
//    setState(() {
//      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
//    });
//
//    final String url =
//    await (await _uploadTask.onComplete).ref.getDownloadURL();
//    Firestore.instance.collection('Posts').document().setData({
//      'ImageURL': url,
//      'downvotes': 0,
//      'upvotes': 0,
//    });
//  }
//
//  Widget functionds() {
//    if (_uploadTask != null) {
//      return StreamBuilder<StorageTaskEvent>(
//          stream: _uploadTask.events,
//          builder: (context, snapshots) {
//            var event = snapshots?.data?.snapshot;
//
//            double ProgressPercent = event != null
//                ? event.bytesTransferred / event.totalByteCount
//                : 0;
//            print('${(ProgressPercent * 100).toStringAsFixed(2)}%');
//            return Container();
//          });
//    }
//  }
//
//  //two function
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      floatingActionButton: FloatingActionButton(
//        onPressed: _startUpload,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//      body: functionds(),
//    );
////
//  }
//}
