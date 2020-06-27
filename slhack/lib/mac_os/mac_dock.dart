import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MacDock extends StatefulWidget {
  @override
  _MacDockState createState() => _MacDockState();
}

class _MacDockState extends State<MacDock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.grey[300],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: _centerMenus()),
        ],
      ),
    );
  }

  List<Widget> _centerMenus() => <Widget>[
        Icon(Icons.touch_app),
        SizedBox(width: 15),
        Icon(Icons.face),
        SizedBox(width: 15),
        Icon(Icons.format_color_reset),
        SizedBox(width: 15),
        Icon(Icons.format_color_reset),
        SizedBox(width: 15),
        Icon(Icons.format_color_reset),
      ];
}
