import 'dart:html';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter95/flutter95.dart';

class WinDesk extends StatefulWidget {
  @override
  _WinDeskState createState() => _WinDeskState();
}

class _WinDeskState extends State<WinDesk> {
  bool isShowList = false;
  bool showStartMenu = false;

  @override
  void initState() {
    // TODO: implement initState
    isShowList = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final buttonView = Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            isShowList = true;
          });
        },
        child: const Text('', style: TextStyle(fontSize: 20)),
        color: Colors.transparent,
        textColor: Colors.white,
        elevation: 5,
      ),
    );

    final startupView = Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {
          setState(() {
            isShowList = false;
          });
        },
        child: Image.asset(
          "assets/listview.png",
          fit: BoxFit.contain,
        ),
        color: Colors.transparent,
        elevation: 5,
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF008080),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WinIcon(
                      Image.asset(
                        'images/my_computer.ico',
                        scale: 0.5,
                        filterQuality: FilterQuality.none,
                      ),
                      'My Computer'),
                  SizedBox(height: 25),
                  WinIcon(
                      Image.asset(
                        'images/recycle_bin.ico',
                        scale: 0.5,
                      ),
                      'Recycle Bin')
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Elevation95(
              child: Container(
                height: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showStartMenu) StartMenu(),
                  Button95(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'images/start_menu.ico',
                          filterQuality: FilterQuality.none,
                        ),
                        SizedBox(width: 10),
                        Text('Start'),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        showStartMenu = !showStartMenu;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: RaisedButton(
        onPressed: () {},
        child: const Text('', style: TextStyle(fontSize: 20)),
        color: Colors.transparent,
        textColor: Colors.white,
        elevation: 5,
      ),
    );
  }
}

class StartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Elevation95(
      child: Container(
        width: 250,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 400,
              width: 50,
              color: Colors.grey[600],
              child: RotatedBox(
                quarterTurns: -1,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Windows 95',
                    style: TextStyle(fontSize: 40, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                StartMenuButton(
                    image: Image.asset('images/shutdown.ico'),
                    text: 'Shutdown'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StartMenuButton extends StatelessWidget {
  final Widget image;
  final String text;
  StartMenuButton({this.image, this.text});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          image,
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}

class WinIcon extends StatelessWidget {
  final Image image;
  final String text;
  WinIcon(this.image, this.text);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          image,
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 13, color: Color(0xFFFAFAFA), shadows: [
              Shadow(
                  color: Colors.grey[900],
                  offset: Offset.fromDirection(pi / 4, 2))
            ]),
          )
        ],
      ),
    );
  }
}
