import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CommandPrompt extends StatefulWidget {
  CommandPrompt({Key key}) : super(key: key);

  @override
  _CommandPromptState createState() => _CommandPromptState();
}

class _CommandPromptState extends State<CommandPrompt> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.dark,
          canvasColor: Colors.black,
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.lightGreenAccent,
                  fontSize: 16,
                  shadows: [
                    Shadow(color: Colors.lightGreen[200], blurRadius: 10)
                  ],
                  fontFamily: 'VT323'))),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TypewriterAnimatedTextKit(
            onNext: (int, bool) async =>
                await Future.delayed(Duration(seconds: 3)),
            speed: Duration(milliseconds: 500),
            isRepeatingAnimation: false,
            textStyle: TextStyle(
                fontFamily: 'VT323',
                fontSize: 32,
                color: Colors.lightGreenAccent,
                shadows: [
                  Shadow(color: Colors.lightGreen[200], blurRadius: 15)
                ]),
            text: ['Hello...', 'Are you there?'],
          ),
        ),
      ),
    );
  }
}
