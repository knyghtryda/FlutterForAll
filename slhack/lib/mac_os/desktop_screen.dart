import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:slhack/mac_os/mac_dock.dart';
import 'package:slhack/mac_os/status_bar.dart';

class MacosDesktopScreen extends StatefulWidget {
  @override
  _MacosDesktopScreenState createState() => _MacosDesktopScreenState();
}

class _MacosDesktopScreenState extends State<MacosDesktopScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              child:
                  Image(image: AssetImage('images/macos-desk-background.jpg')),
              fit: BoxFit.fill,
            ),
            Column(children: [StatusBar()]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: MacDock(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
