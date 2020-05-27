import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dialogbuilder extends StatefulWidget {
  final String image;
  dialogbuilder({Key key, this.image}) : super(key: key);

  @override
  _dialogbuilderState createState() => _dialogbuilderState();
}

class _dialogbuilderState extends State<dialogbuilder> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.grey.shade300,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        CachedNetworkImage(
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              Image.asset('assets/images/loading.gif'),
          placeholderFadeInDuration: Duration(milliseconds: 300),
          imageUrl: widget.image,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(FontAwesomeIcons.share),
                ],
              ),
              new Icon(FontAwesomeIcons.bookmark)
            ],
          ),
        ),
      ],
    );
  }
}
