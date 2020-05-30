import 'package:flutter/material.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';

// just a  common shared widget
class loadingwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(

        child: SpinKitDoubleBounce(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );
  }

}