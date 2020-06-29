import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter95/flutter95.dart';
import 'package:provider/provider.dart';
import 'package:slhack/mac_os/desktop_screen.dart';
import 'package:slhack/mac_os/macos_state.dart';
import 'package:slhack/win95/win_state.dart';

class WinDesk extends StatefulWidget {
  @override
  _WinDeskState createState() => _WinDeskState();
}

class _WinDeskState extends State<WinDesk> {
  @override
  Widget build(BuildContext context) {
    final winState = Provider.of<WinState>(context);

    return Scaffold(
      backgroundColor: Color(0xFF008080),
      body: Stack(
        children: [
          if (winState.showRun)
            Align(
              alignment: Alignment.center,
              child: RunWindow(),
            ),
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
                  if (winState.showStartMenu) StartMenu(),
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
                      winState.toggleStartMenu();
                    },
                  ),
                ],
              ),
            ),
          ),
          if (winState.killedClippy)
            Container(
              color: Colors.black,
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(seconds: 2),
                  child: Clippy()),
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

class StartMenu extends StatefulWidget {
  @override
  _StartMenuState createState() => _StartMenuState();
}

class _StartMenuState extends State<StartMenu> {
  @override
  Widget build(BuildContext context) {
    WinState winState = Provider.of<WinState>(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                StartMenuButton(
                    image: Image.asset('images/shutdown.ico', scale: 0.75),
                    text: 'Shutdown'),
                StartMenuButton(
                  image: Image.asset('images/run.ico', scale: 0.75),
                  text: 'Run',
                  onPressed: () {
                    winState.toggleRun();
                  },
                )
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
  final Function onPressed;
  StartMenuButton({@required this.image, @required this.text, this.onPressed});
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
      onPressed: onPressed,
    );
  }
}

class WinIcon extends StatelessWidget {
  final Image image;
  final String text;
  final Function onPressed;
  WinIcon(this.image, this.text, {this.onPressed});
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
      onPressed: onPressed,
    );
  }
}

class WindowsWindow extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final String title;
  WindowsWindow(
      {@required this.width,
      @required this.height,
      @required this.child,
      this.title = 'My Window'});
  @override
  Widget build(BuildContext context) {
    return Elevation95(
      child: Container(
        width: width,
        height: height,
        child: Scaffold95(
          title: title,
          body: child,
        ),
      ),
    );
  }
}

class RunWindow extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WinState winState = Provider.of<WinState>(context);
    controller.addListener(() {
      if (controller.value.text == 'Delete Clippy') {
        print('you deleted clippy!');
      }
    });
    return WindowsWindow(
      width: 400,
      height: 200,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Image.asset('images/run.ico', scale: 0.75),
                  SizedBox(width: 10),
                  Text('Type the name of a program'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Open:'),
                  SizedBox(width: 10),
                  Expanded(child: TextField95(controller: controller)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button95(
                    child: Text('OK'),
                    onTap: () {
                      if (controller.value.text.toLowerCase() ==
                              'delete clippy' ||
                          controller.value.text.toLowerCase() ==
                              'kill clippy') {
                        print('you deleted clippy!');
                        winState.killClippy();
                        Future.delayed(Duration(seconds: 5)).then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (context) => MacosState(),
                                  child: MacosDesktopScreen()),
                            ),
                          ),
                        );
                      } else {
                        winState.toggleRun();
                      }
                    },
                  ),
                  SizedBox(width: 15),
                  Button95(
                    child: Text('Cancel'),
                    onTap: () => winState.toggleRun(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      title: 'Run',
    );
  }
}

class Clippy extends StatefulWidget {
  @override
  _ClippyState createState() => _ClippyState();
}

class _ClippyState extends State<Clippy> {
  @override
  Widget build(BuildContext context) {
    final winState = Provider.of<WinState>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (winState.showClippyText)
          AnimatedOpacity(
            opacity: winState.showClippyText ? 1.0 : 0,
            duration: Duration(milliseconds: 500),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFCC),
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TyperAnimatedTextKit(
                  text: [winState.clippyLines[winState.clippyTextIndex]],
                  isRepeatingAnimation: false,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        FlatButton(
          child: Image.asset(
            'images/clippy.png',
            width: 200,
          ),
          onPressed: () => winState.toggleClippyText(),
        ),
      ],
    );
  }
}
