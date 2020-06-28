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
      height: 25,
      color: Colors.grey[50],
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
        SizedBox(width: 20),
        Image(image: AssetImage('images/company.png'), width: 16),
        SizedBox(width: 15),
        _macosTextSelectedMenu('Finder'),
        SizedBox(width: 15),
        _macosTextMenu('File'),
        SizedBox(width: 15),
        _macosTextMenu('Edit'),
      ];

  List<Widget> _rightMenus() => <Widget>[
        Image(image: AssetImage('images/wifi.png'), width: 16),
        SizedBox(width: 10),
        Image(image: AssetImage('images/clock.png'), width: 16),
        SizedBox(width: 10),
        Image(image: AssetImage('images/speaker.png'), width: 16),
        SizedBox(width: 10),
        Image(image: AssetImage('images/bateries.png'), width: 16),
        SizedBox(width: 20),
      ];

  Widget _macosTextMenu(String data) => Text(
        data,
        style: TextStyle(fontSize: 12),
      );

  Widget _macosTextSelectedMenu(String data) => Text(
        data,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      );
}
