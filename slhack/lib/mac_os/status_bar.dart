import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE4E4E4), Color(0xFFA4A4A4)],
        ),
      ),
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

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("H:m:s").format(now);
  }

  List<Widget> _rightMenus() => <Widget>[
        Image(image: AssetImage('images/wifi.png'), width: 16),
        SizedBox(width: 10),
        TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
          return Text(
            "${getSystemTime()}",
          );
        }),
        SizedBox(width: 10),
        Image(image: AssetImage('images/speaker.png'), width: 16),
        SizedBox(width: 10),
        Image(image: AssetImage('images/bateries.png'), width: 16),
        SizedBox(width: 20),
      ];

  Widget _macosTextMenu(String data) => Text(
        data,
        style: TextStyle(fontSize: 14),
      );

  Widget _macosTextSelectedMenu(String data) => Text(
        data,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      );
}
