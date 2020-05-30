import 'package:flutter/material.dart';
import 'package:zink/services/mainScreens//Homepage.dart';
import 'package:zink/services/mainScreens/SideBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        buttonColor: Colors.deepPurple,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary
        )
      ),
      title: 'Zink',
      theme: ThemeData(
      ),
      // Redirects to home page
      home: Homepages()
    );

  }
}
