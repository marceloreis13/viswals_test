import 'package:viswals/domain/models/user/user_model.dart';

class Env {
  static bool get debugMode {
    // return false;

    bool inDebugMode = false;
    assert(inDebugMode = true);

    return inDebugMode;
  }

  static String baseUrl = '';

  // ###### System Values
  static String appName = 'Viswals';
  static int connectionTimeout = 15;
  // ###### System Values

  // ###### Super Entities
  static User user = User();
  // ###### Super Entities
}
