import 'package:after_layout/after_layout.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slhack/state/game_state.dart';

class CommandPrompt extends StatefulWidget {
  CommandPrompt({Key key}) : super(key: key);

  @override
  _CommandPromptState createState() => _CommandPromptState();
}

class _CommandPromptState extends State<CommandPrompt>
    with AfterLayoutMixin<CommandPrompt> {
  @override
  void afterFirstLayout(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.addAiLine(['Hello...', 'Are you there?'],
        textStyle: Theme.of(context).textTheme.bodyText1);
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...gameState.lines, if (gameState.inputActive) Prompt()],
        ),
      ),
    );
  }
}

class Prompt extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void addTerminalLine(BuildContext context, String text) {
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.addLine(Padding(
      padding: const EdgeInsets.all(16.0),
      child: TyperAnimatedTextKit(
        text: [text],
        speed: Duration(milliseconds: 20),
        textStyle: Theme.of(context).textTheme.bodyText1,
        isRepeatingAnimation: false,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              '>',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              style: Theme.of(context).textTheme.bodyText1,
              cursorColor: Colors.lightGreenAccent,
              cursorWidth: 10,
              maxLength: 128,
              maxLines: 1,
              autocorrect: false,
              decoration: null,
              showCursor: true,
              autofocus: true,
              onSubmitted: (input) {
                if (input.isNotEmpty) {
                  final gameState =
                      Provider.of<GameState>(context, listen: false);
                  addTerminalLine(context, gameState.parse(input));
                  controller.clear();
                  focusNode.requestFocus();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
