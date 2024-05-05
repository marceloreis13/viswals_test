import 'package:flutter/material.dart';
import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/app/helpers/api/responses/api_response.dart';
import 'package:viswals/domain/models/country/country_model.dart';
import 'package:viswals/domain/models/user/user_constants.dart';
import 'package:viswals/domain/models/user/user_model.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/services/user/user_service.dart';

class DocumentDetailsService extends ChangeNotifier {
  final UserProviderProtocol userProvider;
  final CountryProviderProtocol countryProvider;

  DocumentDetailsService({
    required this.userProvider,
    required this.countryProvider,
  });

  // User service
  UserService get userService => UserService(provider: userProvider);

  Future<ApiResponse> getAllCountries() async {
    try {
      final source = await countryProvider.getAll();
      final apiResponse = ApiResponse.fromJsonToMap(source.data);
      final items = apiResponse.list?.map((e) => Country.fromJson(e)).toList();

      // As I could not find a parameter "limit" in the restcountries documentation
      // I needed to split the source like that
      final splitedItems = (items ?? []).sublist(0, 40).toList();

      return ApiResponse(
        success: apiResponse.success,
        message: apiResponse.message,
        object: splitedItems,
      );
    } catch (e) {
      return ApiResponse.genericError(e);
    }
  }

  bool isFilled() {
    final isFilled = userService.user.docType != null;
    return isFilled;
  }

  Map<String, dynamic Function()> loadUserDocTypeOptions(
    BuildContext context,
    Function() completion,
  ) {
    final options = {
      'Passport': () {
        final user = Env.user.copyWith(docType: UserDocType.passport);
        userService.setUser(user);
        userService.setStepAsCompleted(docDetailTypeStep, context);
        completion();
      },
      'National Card': () {
        final user = Env.user.copyWith(docType: UserDocType.nationalCard);
        userService.setUser(user);
        userService.setStepAsCompleted(docDetailTypeStep, context);
        completion();
      },
    };

    return options;
  }

  void onDocTextFieldChanged(String value, BuildContext context) {
    User user = Env.user.copyWith(doc: value);

    // Force set null as value
    if (value.isEmpty) {
      user.doc = null;
    }

    userService.setUser(user);
    validateCountryPageProgress(context);
  }

  void onBtnCountryTapped(Country country, BuildContext context) {
    final user = Env.user.copyWith(country: country);
    userService.setUser(user);

    validateCountryPageProgress(context);
  }

  void validateCountryPageProgress(BuildContext context) {
    final isCompleted = Env.user.doc != null && Env.user.country != null;
    userService.setStepAsCompleted(
      docDetailCountryStep,
      context,
      isCompleted: isCompleted,
    );
  }
}
