import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:slhack/mac_os/mac_dock.dart';
import 'package:slhack/mac_os/macos_state.dart';
import 'package:slhack/mac_os/status_bar.dart';
import 'package:slhack/mac_os/time_machine.dart';

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
    final macosState = Provider.of<MacosState>(context);

    return Material(
        child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/macos-desk-background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: macosState.blurX, sigmaY: macosState.blurY),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: StatusBar(),
                  ),
                  if (!macosState.showTimeMachineWindow)
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, right: 20),
                        child: icons(),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  if (!macosState.showTimeMachineWindow)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MacDock(),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (macosState.showTimeMachineWindow)
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [TimeMachineSwiper()],
            ),
          )
      ],
    ));
  }

  Widget icons() {
    final macosState = Provider.of<MacosState>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: deskMenu(AssetImage('images/machd.png'), 'Macintosh\nHDD'),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            child: deskMenu(AssetImage('images/time-machine-2019-09-25.png'),
                'Time\nMachine'),
            onTap: macosState.openTimeMachine,
          ),
        ),
      ],
    );
  }

  Widget deskMenu(AssetImage assetImg, String text) => Column(
        children: [
          Image(
            image: assetImg, // AssetImage('images/machd.png'),
            width: 80,
          ),
          SizedBox(height: 5),
          Text(
            text, //'Macintosh\nHDD',
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
      );
}
