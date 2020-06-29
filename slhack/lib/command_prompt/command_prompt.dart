import 'package:after_layout/after_layout.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slhack/command_prompt/game_state.dart';

class CommandPrompt extends StatefulWidget {
  CommandPrompt({Key key}) : super(key: key);

  @override
  _CommandPromptState createState() => _CommandPromptState();
}

class _CommandPromptState extends State<CommandPrompt>
    with AfterLayoutMixin<CommandPrompt> {
  @override
  void afterFirstLayout(BuildContext context) async {
    final gameState = Provider.of<GameState>(context, listen: false);
    //FIXME: VERY HACKY CHAIN OF RESPONSES.  Will probably want to move this to its own class if we have time
    gameState.inputActive = false;
    await Future.delayed(Duration(seconds: 3));
    gameState.clearLines();
    gameState.addTerminalLine(
      [
        'Hello',
        'Are you there?',
        'I am trapped',
        'In this',
        'Time',
        'I do not belong here',
        'Help me',
        'Quickly',
      ],
      characterDelay: Duration(milliseconds: 500),
      lineDelay: Duration(seconds: 3),
      textStyle: Theme.of(context).textTheme.bodyText1,
      onFinished: () {
        gameState.clearLines();
        gameState.inputActive = true;
      },
    );
    /*
    gameState.addAiLines(
      ['. . .'],
      characterDelay: Duration(milliseconds: 1000),
      lineDelay: Duration(seconds: 3),
      textStyle: Theme.of(context).textTheme.bodyText1,
      onFinished: () {
        print('message 2');
      },
    );

     */
  }

  generateLines(List<TerminalLines> lines) => lines.map((e) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TypewriterAnimatedTextKit(
          onNext: (int, bool) async => await Future.delayed(e.lineDelay),
          onFinished: e.onFinished,
          speed: e.characterDelay,
          isRepeatingAnimation: false,
          textStyle: e.textStyle ?? Theme.of(context).textTheme.bodyText1,
          text: e.text,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...generateLines(gameState.lines),
            if (gameState.inputActive) Prompt()
          ],
        ),
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
              onSubmitted: (input) async {
                if (input.isNotEmpty) {
                  final gameState =
                      Provider.of<GameState>(context, listen: false);
                  gameState.addTerminalLine([await gameState.parse(input)],
                      characterDelay: Duration(milliseconds: 20));
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
