import 'package:flutter/material.dart';



class ImageUploading extends StatefulWidget {
  final double Progress;
  ImageUploading({Key key, this.Progress}) : super(key: key);
  @override
  _ImageUploadingState createState() => _ImageUploadingState();
}

class _ImageUploadingState extends State<ImageUploading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(widget.Progress.toString(), style: TextStyle(
            fontSize: 40,
          ),)




        ],
      ),
    );
  }
}
