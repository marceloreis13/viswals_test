import 'package:viswals/app/helpers/debugger_helper.dart';

class ApiResponse<T> {
  late bool success;
  int? code;
  String? message;
  T? object;
  List<Map<String, dynamic>>? list = [];

  ApiResponse({
    this.success = false,
    this.code,
    this.message,
    this.object,
    this.list,
  });

  ApiResponse.fromJsonToMap(json) {
    if (json.isNotEmpty) {
      success = true;
      list = List<Map<String, dynamic>>.from(json);
    }
  }

  factory ApiResponse.genericError(dynamic error) {
    Log.e("Generic Error", error: error);
    return ApiResponse(
      success: false,
      message: 'Loc.tr.unexpectedError',
    );
  }

  factory ApiResponse.genericSuccess() {
    return ApiResponse(
      success: true,
      message: 'Loc.tr.allGoodEnjoy',
    );
  }

  ApiResponse<T> copyWith({
    bool? success,
    int? code,
    String? message,
    T? object,
    List<Map<String, dynamic>>? list,
  }) =>
      ApiResponse<T>(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        object: object ?? this.object,
        list: list ?? this.list,
      );
}
