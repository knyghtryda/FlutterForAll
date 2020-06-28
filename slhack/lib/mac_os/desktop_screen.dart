import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:slhack/mac_os/mac_dock.dart';
import 'package:slhack/mac_os/status_bar.dart';

class MacosDesktopScreen extends StatefulWidget {
  @override
  _MacosDesktopScreenState createState() => _MacosDesktopScreenState();
}

class _MacosDesktopScreenState extends State<MacosDesktopScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            child: Image(image: AssetImage('images/macos-desk-background.jpg')),
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: StatusBar(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 80),
              child: Column(
                children: [
                  Image(
                    image: AssetImage('images/machd.png'),
                    width: 46,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Macintosh\nHDD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MacDock(),
          )
        ],
      ),
    );
  }
}
