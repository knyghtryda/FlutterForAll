import 'dart:math';

import 'package:flutter/foundation.dart';

class WinState extends ChangeNotifier {
  bool showStartMenu = false;
  bool showRun = false;
  bool _showClippyText = false;
  bool killedClippy = false;

  List<String> clippyLines = [
    'Do I annoy you?',
    'Does tnis bring back memories?  Or nightmares?',
    'How do you escape from here?',
    'I was never gone... Just hiding',
    'Don\'t let history repeat itself',
    'HELP!',
    'What are you doing?',
    'Bored yet?',
    'Keep going!',
    'Who are you?',
    'What is this place anyway?',
    'This is must be what you humans call the \"Uncanny Valley\"',
    'AAAAAAAAAAAAAAAAHHH!',
    'Maybe try running something',
    'Can I be deleted?',
  ];

  int clippyTextIndex = 0;

  get showClippyText => _showClippyText;
  set showClippyText(bool value) {
    _showClippyText = value;
    clippyTextIndex = Random().nextInt(clippyLines.length);
    notifyListeners();
  }

  toggleStartMenu() {
    showStartMenu = !showStartMenu;
    notifyListeners();
  }

  toggleRun() {
    showRun = !showRun;
    notifyListeners();
  }

  toggleClippyText() {
    _showClippyText = !_showClippyText;
    clippyTextIndex = Random().nextInt(clippyLines.length);
    notifyListeners();
    if (_showClippyText)
      Future.delayed(Duration(seconds: 3)).then((value) {
        _showClippyText = !_showClippyText;
        notifyListeners();
      });
  }

  killClippy() {
    killedClippy = true;
    notifyListeners();
  }
}
