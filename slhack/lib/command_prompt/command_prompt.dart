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
  bool promptActive = false;

  @override
  void afterFirstLayout(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.addLine(Padding(
      padding: const EdgeInsets.all(16.0),
      child: TypewriterAnimatedTextKit(
        onNext: (int, bool) async => await Future.delayed(Duration(seconds: 5)),
        onFinished: () {
          setState(() {
            promptActive = true;
          });
        },
        speed: Duration(milliseconds: 600),
        isRepeatingAnimation: false,
        textStyle: Theme.of(context).textTheme.bodyText1,
        text: ['Hello...', 'Are you there?'],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...gameState.lines, if (promptActive) Prompt()],
      ),
    );
  }
}

class Prompt extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
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
                final gameState =
                    Provider.of<GameState>(context, listen: false);
                gameState.addLine(Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      Text(input, style: Theme.of(context).textTheme.bodyText1),
                ));
                controller.clear();
                focusNode.requestFocus();
                print(input);
              },
            ),
          ),
        ],
      ),
    );
  }
}
