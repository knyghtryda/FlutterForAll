import 'package:flutter/material.dart';

class MacosState extends ChangeNotifier {
  bool showTimeMachineWindow = false;
  double blurX = 0;
  double blurY = 0;

  void openTimeMachine() {
    showTimeMachineWindow = true;
    blurX = 50;
    blurY = 50;
    notifyListeners();
  }
}
