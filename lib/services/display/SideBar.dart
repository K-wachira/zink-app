import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final bool isSideBarOpen = false;
  final _animationDuration = const Duration(microseconds: 2500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationstatus = _animationController.status;
    final isAnimationCompleted = animationstatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);

      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwitdh = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
        initialData: false,
        stream: isSideBarOpenedStream,
        builder: (context, isSidebarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
//            first value is distance fro9m left which original distance second is the width of the bar clue
            left: isSidebarOpenedAsync.data
                ? screenwitdh - 150
                : screenwitdh - 45,
            right: isSidebarOpenedAsync.data ? -screenwitdh : -screenwitdh,
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment(0, 0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 90,
                        color: Colors.blueAccent,
                        alignment: Alignment.centerRight,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.arrow_menu,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                      DisplayCommunitiess(),
                      Text("#memes"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget DisplayCommunities() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            Icons.perm_identity,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(height: 5),
      ],
    );
  }

  Widget DisplayCommunitiess() {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.perm_identity,
          color: Colors.white,
        ),
        radius: 40,
      ),
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();

    path.moveTo(width, 25);
    path.lineTo(34, 25);
    path.lineTo(33, 25);
    path.lineTo(32, 25);
    path.lineTo(31, 25);
    path.lineTo(30, 25);
    path.lineTo(29, 25);
    path.lineTo(28, 25);
    path.lineTo(27, 25);
    path.lineTo(26, 25);
    path.lineTo(25, 26);
    path.lineTo(24, 26);
    path.lineTo(23, 27);
    path.lineTo(22, 27);
    path.lineTo(21, 28);
    path.lineTo(20, 28);
    path.lineTo(19, 29);
    path.lineTo(18, 29);
    path.lineTo(17, 30);
    path.lineTo(16, 30);
    path.lineTo(15, 31);
    path.lineTo(14, 31);
    path.lineTo(13, 32);
    path.lineTo(12, 32);
    path.lineTo(11, 33);
    path.lineTo(10, 33);

    path.lineTo(9, 34);
    path.lineTo(9, 34);
    path.lineTo(9, 35);
    path.lineTo(9, 36);
    path.lineTo(9, 36);
    path.lineTo(9, 37);
    path.lineTo(9, 37);
    path.lineTo(9, 38);
    path.lineTo(9, 39);
    path.lineTo(9, 40);
    path.lineTo(9, 41);
    path.lineTo(9, 42);
    path.lineTo(9, 43);
    path.lineTo(9, 44);
    path.lineTo(9, 45);
    path.lineTo(9, 46);
    path.lineTo(9, 47);
    path.lineTo(9, 48);
    path.lineTo(9, 49);
    path.lineTo(9, 50);
    path.lineTo(9, 51);
    path.lineTo(9, 52);

    path.lineTo(10, 52);
    path.lineTo(11, 53);
    path.lineTo(12, 53);
    path.lineTo(13, 54);
    path.lineTo(14, 55);
    path.lineTo(15, 55);
    path.lineTo(16, 56);
    path.lineTo(17, 56);
    path.lineTo(18, 57);
    path.lineTo(19, 57);
    path.lineTo(20, 58);
    path.lineTo(21, 58);
    path.lineTo(22, 59);
    path.lineTo(23, 59);
    path.lineTo(24, 60);
    path.lineTo(25, 60);
    path.lineTo(26, 61);
    path.lineTo(27, 61);
    path.lineTo(28, 62);
    path.lineTo(29, 62);
    path.lineTo(30, 63);
    path.lineTo(31, 66);
    path.lineTo(32, 67);
    path.lineTo(33, 69);
    path.lineTo(34, 72);
    path.lineTo(35, 75);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
