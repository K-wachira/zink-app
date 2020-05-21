import 'package:flutter/material.dart';
import 'package:zink/services/imageuploading/imagepick.dart';
import 'package:zink/services/display/displayimages.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:zink/services/imageuploading/imagepicker.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 1;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            ImageCaptures(),
            imageloader(),
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Upload Photos'), icon: Icon(Icons.add_a_photo)),
          BottomNavyBarItem(title: Text('Home Feed'), icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Text('Messages'), icon: Icon(Icons.chat_bubble)),
          BottomNavyBarItem(
              title: Text('Profile'), icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
