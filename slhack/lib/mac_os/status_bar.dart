import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.grey[300],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: _leftMenus()),
          Row(children: _rightMenus()),
        ],
      ),
    );
  }

  List<Widget> _leftMenus() => <Widget>[
        Icon(Icons.touch_app),
        SizedBox(width: 10),
        _macosTextMenu('Finder'),
        SizedBox(width: 10),
        _macosTextMenu('File'),
        SizedBox(width: 10),
        _macosTextMenu('Finder'),
      ];

  List<Widget> _rightMenus() => <Widget>[
        Icon(Icons.touch_app),
        SizedBox(width: 10),
        Icon(Icons.face),
        SizedBox(width: 10),
        Icon(Icons.format_color_reset),
      ];

  Widget _macosTextMenu(String data) => Text(
        data,
        style: TextStyle(fontSize: 12),
      );
}
