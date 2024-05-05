import 'package:viswals/app/helpers/api/responses/api_response.dart';
import 'package:dio/dio.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';

// Exports all responses
export 'package:viswals/app/helpers/api/responses/api_response.dart';

enum ApiError {
  timeout,
  noConnection,
  badResponse,
  generic,
  userSessionFailured,
}

extension ApiErrorExtension on ApiError {
  ApiResponse handler({String? customMessage}) {
    return ApiResponse(
      success: false,
      message: customMessage ?? message,
    );
  }

  String get message {
    switch (this) {
      case ApiError.timeout:
        return 'Service is down';
      case ApiError.noConnection:
        return 'You have no connection';
      case ApiError.badResponse:
        return 'Bad Request';
      case ApiError.userSessionFailured:
        return 'Session Failure';
      default:
        return 'Some error';
    }
  }
}

enum CountryServices {
  all,
}

extension CountryServicesExtension on CountryServices {
  Dio get http {
    return Api.url(this);
  }

  String get absoluteUrl {
    String endpoint = toString().split('.').last;
    return "${Env.baseUrl}/$endpoint";
  }

  Map<String, String> get headers {
    final header = {
      // Some important informations here
      '': '',
    };

    final log = "HEADER\n${header.toString()}";
    Log.i(log);

    return header;
  }
}

class Api {
  static String idempotencyKey = '';

  static Dio url(CountryServices key) {
    BaseOptions options = BaseOptions(
      contentType: 'application/json',
      baseUrl: key.absoluteUrl,
      connectTimeout: Duration(seconds: Env.connectionTimeout),
      receiveTimeout: Duration(seconds: Env.connectionTimeout),
      // headers: key.headers,
    );
    Dio dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          final log =
              "API REQUEST\n${options.method}: ${options.baseUrl}${options.path}\nDATA SENT:${options.data.toString()}";
          Log.i(log);

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
