import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageItem extends StatefulWidget {
  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  final image =
      'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media';

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: HeroHeader(
              minExtent: 250,
              maxExtent: 450,
              image: image,
            ),
          ),


          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Comments"),
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  // comment section
//                  children: <Widget>[
//                    new Container(
//                      height: 40.0,
//                      width: 40.0,
//                      decoration: new BoxDecoration(
//                        shape: BoxShape.circle,
//                        image: new DecorationImage(
//                            fit: BoxFit.fill, image: new NetworkImage(image)),
//                      ),
//                    ),
//                    new SizedBox(
//                      width: 10.0,
//                    ),
//                    new Text(
//                      "#memehashtag",
//                      style: TextStyle(fontWeight: FontWeight.bold),
//                    ),
//                  ],
//                ),
//                new IconButton(
//                  icon: Icon(Icons.more_vert),
//                  onPressed: null,
//                )
//              ],
//            ),
//          ),
//          CachedNetworkImage(
//            placeholder: (context, url) =>
//                Image.asset('assets/images/loading.gif'),
//            placeholderFadeInDuration: Duration(milliseconds: 300),
//            imageUrl: image,
//          ),
//
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 16.0),
//            child: Text(
//              "Tags: #Screenshot #meme #dark humor",
//              style: TextStyle(
//                  fontWeight: FontWeight.bold, color: Colors.blueAccent),
//            ),
//          ),
//
//          // TODO have a stream builder for comments
//          ListView(
//            children: <Widget>[
//              SizedBox(height: 030,),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Name of commentor"),
//                subtitle: Text(" The comment"),
//                leading: Icon(Icons.perm_identity),
//              ),
//
//            ],
//
//          ),
//
//          // user add comment comment section
//
//          Padding(
//            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                new Container(
//                  height: 40.0,
//                  width: 40.0,
//                  decoration: new BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: new DecorationImage(
//                        fit: BoxFit.fill, image: new NetworkImage(image)),
//                  ),
//                ),
//                new SizedBox(
//                  width: 10.0,
//                ),
//                Expanded(
//                  child: new TextField(
//                    decoration: new InputDecoration(
//                      border: InputBorder.none,
//                      hintText: "Add a comment...",
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
  }
}



class HeroHeader implements SliverPersistentHeaderDelegate {
  HeroHeader({
    this.minExtent,
    this.maxExtent,
    this.image,
  });
  String image;
  double maxExtent;
  double minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          image,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 4.0,
          top: 4.0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.image),

            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Hero Image',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}
