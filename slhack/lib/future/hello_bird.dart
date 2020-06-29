import 'package:flutter/material.dart';
import 'package:slhack/future/object3d.dart';

class HelloBird extends StatefulWidget {
  HelloBird({Key key}) : super(key: key);

  @override
  _HelloBirdState createState() => _HelloBirdState();
}

class _HelloBirdState extends State<HelloBird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Object3D(
            size: Size(400.0, 400.0),
            zoom: 40.0,
            path: "assets/bird.obj",
          ),
          Text(
            'Hello bird',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
