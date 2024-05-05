import 'package:viswals/app/helpers/api/responses/api_response.dart';
import 'package:viswals/domain/models/user/user_model.dart';

// Protocols
abstract class UserProviderProtocol {
  Future<ApiResponse> getUser();
  Future<ApiResponse> setUser(User newUser);
}
