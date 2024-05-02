import 'package:flutter/material.dart';

// Available routes
import 'package:viswals/ui/features/document_details/document_details_page.dart';

// variable for our route names
enum Routes {
  goTo,
  onboardingPage,
  errorPage;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Routes currentPage = Routes.onboardingPage;
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
    case Routes.onboardingPage:
      return MaterialPageRoute(
          builder: (context) => const DocumentDetailsPage());

    default:
      throw ('this route name does not exist');
  }
}
