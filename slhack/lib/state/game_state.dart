import 'package:flutter/material.dart';
import 'package:slhack/amazon_lex/amazon_lex.dart';

class GameState extends ChangeNotifier {
  List<TerminalLines> lines = [];
  Map<String, Function> _commands;
  bool _inputActive;
  bool get inputActive => _inputActive;
  set inputActive(bool value) {
    _inputActive = value;
    notifyListeners();
  }

  AmazonLex lex = AmazonLex();
  //flags
  bool _infoChecked;

  void init() {
    _inputActive = false;
    _commands = {
      'help': (args) => _usage,
      'info': info,
      'devices': (args) => _devices,
      'connect': connect,
      'clear': clear
    };
  }

  void addLine(TerminalLines l) {
    lines.add(l);
    notifyListeners();
  }

  void popLine() {
    lines.removeLast();
    notifyListeners();
  }

  void clearLines() {
    lines.clear();
    notifyListeners();
  }

  void addTerminalLine(
    List<String> text, {
    TextStyle textStyle,
    Duration characterDelay = const Duration(milliseconds: 600),
    Duration lineDelay = const Duration(seconds: 5),
    Function onFinished,
  }) {
    if (text != null)
      addLine(TerminalLines(text,
          textStyle: textStyle,
          characterDelay: characterDelay,
          lineDelay: lineDelay,
          onFinished: onFinished));
  }

  void addAiLines(
    List<String> text, {
    TextStyle textStyle,
    Duration characterDelay = const Duration(milliseconds: 600),
    Duration lineDelay = const Duration(seconds: 5),
    Function onFinished,
  }) {
    print('adding ai lines');
    clearLines();
    addLine(TerminalLines(text,
        textStyle: textStyle,
        characterDelay: characterDelay,
        lineDelay: lineDelay,
        onFinished: onFinished));
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
  clear
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

  String info(List<String> args) {
    clearLines();
    return _info;
  }

  connect(List<String> args) {
    addAiLines(['Connecting...'], onFinished: () {
      if (args.first == '1.1.1.1') addAiLines(['Connection Successful']);
    });
    return 'connecting...';
  }

  clear(List<String> args) {
    clearLines();
  }

  Future<String> parse(String input) async {
    if (input == null) return null;
    var args = input.split(' ');
    if (_commands[args.first] != null)
      return _commands[args.first](args.sublist(1));
    var response = (await lex.postResponse(input)).message;
    return response;
  }
}

class TerminalLines {
  final List<String> text;
  final TextStyle textStyle;
  final Duration characterDelay;
  final Duration lineDelay;
  final Function onFinished;
  TerminalLines(
    this.text, {
    this.textStyle,
    this.characterDelay = const Duration(milliseconds: 600),
    this.lineDelay = const Duration(seconds: 5),
    this.onFinished,
  });
}
