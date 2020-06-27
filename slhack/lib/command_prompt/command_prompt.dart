import 'package:flutter/material.dart';
import 'package:slhack/command_prompt/blinking_cursor.dart';

class CommandPrompt extends StatefulWidget {
  CommandPrompt({Key key}) : super(key: key);

  @override
  _CommandPromptState createState() => _CommandPromptState();
}

class _CommandPromptState extends State<CommandPrompt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlinkingCursor(),
        ),
      ),
    );
  }
}
