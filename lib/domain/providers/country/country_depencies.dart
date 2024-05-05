import 'package:dio/dio.dart';

// Protocols
abstract class CountryProviderProtocol {
  Future<Response> getAll();
}
