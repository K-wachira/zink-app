import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zink/services/display/Homepage.dart';

class ImageCaptures extends StatefulWidget {
  createState() => _ImageCapturesState();
}

class _ImageCapturesState extends State<ImageCaptures> {

  File _ImageFile;

//  Select an image via gallery or camera
  Future<void> pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(
      source: source,
      maxHeight: 800,
      maxWidth: 500,
    );

    setState(() {
      _ImageFile = selected;
    });
  }

//  Remove image
  void _clear() {
    setState(() {
      _ImageFile = null;
    });
  }

  Future<void> _cropImage() async {
    File croped = await ImageCropper.cropImage(
      sourcePath: _ImageFile.path,
    );
    setState(() {
      _ImageFile = croped ?? _ImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (_ImageFile != null) ...[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.cancel),
                  onPressed: _clear,
                ),
              ],
            ),
          ]
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              tooltip: 'Caputure Images',
              onPressed: () => pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              tooltip: "Add photos from Gallery",
              onPressed: () => pickImage(ImageSource.gallery),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_ImageFile != null) ...[
            Image.file(_ImageFile),
            Uploader(
              file: _ImageFile,
            )
          ],
        ],
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  String ImgUrl;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://zink-project.appspot.com/");

  StorageUploadTask _uploadTask;

  void _startUpload() async {
    var filename = DateTime.now();
    String filePath = 'images/$filename.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });

    final String url =
        await (await _uploadTask.onComplete).ref.getDownloadURL();
    Firestore.instance.collection('Posts').document().setData({
      'ImageURL': url,
      'downvotes': 0,
      'upvotes': 0,
    });
  }

  //two function
  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshots) {
            var event = snapshots?.data?.snapshot;

            double ProgressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            print('${(ProgressPercent * 100).toStringAsFixed(2)}%');
            return Container();
          });
    } else {
      return Row(
        children: <Widget>[
          FlatButton.icon(
              color: Colors.red,
              onPressed: () {
                _startUpload();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              icon: Icon(Icons.file_upload),
              label: Text("Upload")),
        ],
      );
    }
  }
}
