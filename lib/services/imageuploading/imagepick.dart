import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/src/widgets/basic.dart';
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
          if(_ImageFile != null) ...[
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

            Uploader(file: _ImageFile,)

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
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
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
            return Column(
            );
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
