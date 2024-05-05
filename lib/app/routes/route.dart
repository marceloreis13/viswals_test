import 'package:flutter/material.dart';
import 'package:viswals/ui/features/document_details/document_details_country_list_page.dart';
import 'package:viswals/ui/features/document_details/document_details_country_page.dart';

// Available routes
import 'package:viswals/ui/features/document_details/document_details_home_page.dart';
import 'package:viswals/ui/features/document_details/document_details_type_page.dart';

// variable for our route names
enum Routes {
  goTo,
  documentDetailsHomePage,
  documentDetailsTypePage,
  documentDetailsCountryPage,
  documentDetailsCountryListPage,
  errorPage;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Routes currentPage = Routes.documentDetailsHomePage;
}

extension RoutesExt on Routes {
  String get route {
    String key = toString().split('.').last;
    if (key.isEmpty || key == 'null') {
      return '';
    }

    return key.toLowerCase();
  }
}

Routes parseRoute(dynamic name) {
  if (name != null) {
    final entity = (name as String).toUpperCase();
    final isValid = Routes.values
        .where((e) => e.toString().split('.').last.toUpperCase() == entity)
        .isNotEmpty;
    if (isValid) {
      return Routes.values.firstWhere(
          (e) => e.toString().split('.').last.toUpperCase() == entity);
    }
  }

  return Routes.currentPage;
}

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  Routes route = parseRoute(settings.name);
  // final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;

  switch (route) {
    // Onboarding View
    case Routes.documentDetailsHomePage:
      return MaterialPageRoute(
          builder: (context) => const DocumentDetailsHomePage());
    case Routes.documentDetailsTypePage:
      return MaterialPageRoute(
          builder: (context) => DocumentDetailsTypePage.init());
    case Routes.documentDetailsCountryPage:
      return MaterialPageRoute(
          builder: (context) => DocumentDetailsCountryPage.init());
    case Routes.documentDetailsCountryListPage:
      return MaterialPageRoute(
        builder: (context) => DocumentDetailsCountryListPage.init(),
        fullscreenDialog: true,
      );
    default:
      throw ('this route name does not exist');
  }
}
