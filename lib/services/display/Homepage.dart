import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zink/services/imageuploading/imagepick.dart';
import 'package:zink/services/imageuploading/imagepick.dart';
import 'package:zink/services/imageuploading/imagepick.dart';

import 'displayimages.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ImageCaptures()),
                    )),
          ],
        ),
      ),
      body: imageloader(),
    );
  }
}
