import 'package:flutter/foundation.dart';

class WinState extends ChangeNotifier {
  bool showStartMenu = false;
  bool showRun = false;
  toggleStartMenu() {
    showStartMenu = !showStartMenu;
    notifyListeners();
  }

  toggleRun() {
    showRun = !showRun;
    notifyListeners();
  }
}
