import 'package:flutter/material.dart';

class StatusWheelView extends StatefulWidget {
  @override
  _StatusWheelViewState createState() => _StatusWheelViewState();
}

class _StatusWheelViewState extends State<StatusWheelView> {


  Widget creation() {
    int number = 45;

    while (number < 45){
      return Container(height: 340,width: 450,);
    }

  }





  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(itemExtent: 50, diameterRatio: 1.9, children: [
      creation()
      
    ]);
  }
}
