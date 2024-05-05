import 'package:viswals/app/helpers/debugger_helper.dart';

class Model {
  /// Converts an enum value to its string representation.
  ///
  /// Takes an [item] of type Enum and returns its string representation in uppercase.
  ///
  /// If [item] is null, returns an empty string.
  String enumToString(Enum? item) {
    return item.toString().split('.').last.toUpperCase();
  }

  /// Populates data from a JSON object or list into the completion function.
  ///
  /// The [json] parameter can be either a Map or a List.
  /// For each element in the list or each key-value pair in the map, the [completion]
  /// function is called with the element or the key-value pair as an argument.
  /// If the element is a string, it is wrapped in a map with the key '_id' before being passed to the [completion] function.
  ///
  /// If [json] is null, empty, or not a Map or List, the function does nothing.
  ///
  /// Any errors that occur during processing are logged and rethrown.
  static void populate(dynamic json, Function(dynamic) completion) {
    try {
      if (json != null && json != '') {
        if (json is List) {
          for (var v in json) {
            if (v is String) {
              completion({'_id': v});
            } else {
              completion(v);
            }
          }
        } else if (json is Map) {
          if (json.isNotEmpty) {
            completion(json);
          }
        }
      }
    } catch (err) {
      Log.d('[model] - ${err.toString()} - $json');
      rethrow;
    }
  }
}
