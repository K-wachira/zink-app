import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class notYetImplimented extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: (Column(
        children: <Widget>[
          Image.asset("assets/images/ghost2.webp"),
          SizedBox(height: 100,),

          Text(" Woow!!! Such Emptiness", style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),)
        ],
      )),
    );
  }
}
