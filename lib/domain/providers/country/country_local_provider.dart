import 'package:dio/dio.dart';
import 'package:viswals/app/helpers/api/api_helper.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';

class CountryLocalProvider implements CountryProviderProtocol {
  @override
  Future<Response> getAll() async {
    try {
      Response response = await CountryServices.all.http.get('/');

      return response;
    } catch (e) {
      Log.e('[provider]', error: e);
      rethrow;
    }
  }
}
