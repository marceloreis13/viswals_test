import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum StateManager {
  form,
  progressCircle,
}

class StateHelper extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

class FormState extends StateHelper {}
