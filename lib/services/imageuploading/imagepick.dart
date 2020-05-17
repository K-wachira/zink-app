import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCaptures extends StatefulWidget {
  createState() => _ImageCapturesState();
}

class _ImageCapturesState extends State<ImageCaptures> {
  File _ImageFile;

//  Select an image via gallery or camera
  Future<void> pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => pickImage(ImageSource.gallery),
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_ImageFile != null) ...[
            Image.file(_ImageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
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
  final FirebaseStorage storage;
  final File file;

  Uploader({Key key, this.file, this.storage}) : super(key: key);

  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  String ImgUrl;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://zink-project.appspot.com/");

  //upload image to firestore
  StorageUploadTask _uploadTask;
  String ImageURL;



  void _startUpload() async {
    var filename = DateTime.now();
    String filePath = 'images/$filename.png';



    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);

    });

    final String url = await(await _uploadTask.onComplete).ref.getDownloadURL();
    Firestore.instance.collection('Posts').document().setData({
      'ImageURL': url,
      'downvotes': 0,
      'upvotes': 0,
    });


    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }
  }
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
            return Column();
          });
    } else {
      return Row(
        children: <Widget>[
          FlatButton.icon(
              color: Colors.red,
              onPressed: _startUpload,
              icon: Icon(Icons.file_upload),
              label: Text("Upload")),
        ],
      );
    }
  }
}




