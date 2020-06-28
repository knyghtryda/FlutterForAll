import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  List<Widget> lines = [];
  Map<String, Function> _commands;
  bool _inputActive;
  bool get inputActive => _inputActive;
  set inputActive(bool value) {
    _inputActive = value;
    notifyListeners();
  }

  //flags
  bool _infoChecked;

  void init() {
    _inputActive = false;
    _commands = {'help': () => _usage, 'info': info, 'devices': () => _devices};
  }

  void addLine(Widget line) {
    lines.add(line);
    notifyListeners();
  }

  void popLine() {
    lines.removeLast();
    notifyListeners();
  }

  void addAiLines(List<String> text,
      {TextStyle textStyle,
      Duration characterDelay = const Duration(milliseconds: 600),
      Duration lineDelay = const Duration(seconds: 5)}) {
    lines.clear();
    addLine(Padding(
      padding: const EdgeInsets.all(16.0),
      child: TypewriterAnimatedTextKit(
        onNext: (int, bool) async => await Future.delayed(lineDelay),
        onFinished: () {
          inputActive = true;
        },
        speed: characterDelay,
        isRepeatingAnimation: false,
        textStyle: textStyle,
        text: text,
      ),
    ));
  }

  static const String _unknown = '''
  ERROR: Unknown Command
  Type 'help' for a list of valid commands
  ''';
  static const String _usage = '''
  Available Commands:
  help
  info
  status
  devices
  ''';
  static const String _info = '''
  Hosaka Armitage-11    Version 1.42 29-Jun-1982
  ROM: 64kB   RAM: 128kB  
  ''';

  static const String _devices = '''
  Modem:         CaseTech-AC 300bps
  Terminal:      MAX-Z 8020 Portable Terminal
  Serial Bus 0:  <Disconnected>
  Serial Bus 1:  UNKNOWN
  ''';

  info() {
    lines.clear();
    return _info;
  }

  String parse(String input) {
    if (input == null) return null;
    var args = input.split(' ');
    if (_commands[args.first] != null) return _commands[args.first]();
    return _unknown;
  }
}
