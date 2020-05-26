import 'package:flutter/material.dart';

class MorePopUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.grey.shade300,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: 30,),

        SimpleDialogOption(
          child: Text("Report"),
        ),
        SizedBox(height: 10,),
        SimpleDialogOption(

          child: Text("Share to"),
        ),
        SizedBox(height: 10,),

        SimpleDialogOption(
          child: Text("Follow"),
        ),
        SizedBox(height: 10,),

        SimpleDialogOption(
          child: Text("Copy link"),
        ),
        SizedBox(height: 30,),


      ],
    );
  }
}
