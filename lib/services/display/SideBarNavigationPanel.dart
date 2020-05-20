import 'package:flutter/material.dart';

import 'package:zink/services/display/displayimages.dart';

import 'package:zink/services/display/SideBar.dart';

class MainLayOut extends StatefulWidget {
  @override
  _MainLayOutState createState() => _MainLayOutState();
}

class _MainLayOutState extends State<MainLayOut> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        imageloader(),
        SideBar(),

      ],
    );
  }
}
