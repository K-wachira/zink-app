import 'package:flutter/material.dart';
import 'package:zink/services/display/Homepage.dart';
import 'package:zink/services/display/displayimages.dart';
import 'package:zink/services/imageuploading/imagepick.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        buttonColor: Colors.deepPurple,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary
        )
      ),
      title: 'Zink',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: Homepage(),
    );

  }
}
