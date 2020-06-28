import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  List<Widget> lines = [];

  void addLine(Widget line) {
    lines.add(line);
    notifyListeners();
  }

  void popLine() {
    lines.removeLast();
    notifyListeners();
  }
}
