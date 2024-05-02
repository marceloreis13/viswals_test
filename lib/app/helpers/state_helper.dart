import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum StateManager {
  progressCircle,
}

extension StateManagerExtension on StateManager {
  StateHelper get state {
    switch (this) {
      case StateManager.progressCircle:
        return ProgressCircleState();
    }
  }
}

class StateHelper extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}

class ProgressCircleState extends StateHelper {}
