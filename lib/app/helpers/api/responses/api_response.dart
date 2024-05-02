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

  ApiResponse.fromJsonToMap(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    code = json['code'];
    message = json['message'];
    object = json['object'];
    if (json['data'].isNotEmpty) {
      list = List<Map<String, dynamic>>.from(json['data']);
    }
  }

  ApiResponse.fromJsonToObject(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    object = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    data['data'] = object;
    data['list'] = object;
    return data;
  }

  factory ApiResponse.genericError(dynamic error) {
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
