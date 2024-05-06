// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/app/helpers/api/api_helper.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/app/routes/route.dart';
import 'package:viswals/app/routes/route.dart' as route;
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/country/country_local_provider.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/providers/user/user_local_provider.dart';
import 'package:viswals/domain/services/user/user_service.dart';
import 'package:viswals/ui/splashscreen/splahscreen_page.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_circle_state.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // State Manager
        ChangeNotifierProvider(create: (_) => ProgressCircleState()),

        // Persistence Providers
        Provider<UserProviderProtocol>(create: (_) => UserLocalProvider()),
        Provider<CountryProviderProtocol>(
            create: (_) => CountryLocalProvider()),
      ],
      child: RootViewStage(
          serviceUser: UserService(
        provider: UserLocalProvider(),
      )),
    );
  }
}

class RootViewStage extends StatefulWidget {
  final UserService serviceUser;
  const RootViewStage({
    super.key,
    required this.serviceUser,
  });

  @override
  State<RootViewStage> createState() => _RootViewStageState();
}

class _RootViewStageState extends State<RootViewStage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final app = MaterialApp(
      title: Env.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: SplashScreenPage(setUpInitialConfigurations: setUpConfiguration),
      themeMode: ThemeMode.system,
      onGenerateRoute: route.controller,
      navigatorKey: Routes.navigatorKey,
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        // FocusScope.of(context).requestFocus(FocusNode());
      },
      child: app,
    );
  }

  Future<ApiResponse<Routes>> setUpConfiguration() async {
    try {
      // Simulating a connection delay
      await Future.delayed(const Duration(seconds: 1));

      // Loading environment variables
      await setEnvronmentValues();

      // Check connection avalability
      await internetConnectionChecker();

      // Instantiate the Crashlytics
      await setUpFirebaseCrashlytics();

      // Starting the firebase remote config
      await setUpFirebaseRemoteConfig();

      // Setup the firebase notification
      await setUpFirebaseMessaging();

      // Device information
      await setUpDeviceInformation();

      // Setup the user
      await setUpUserSession();

      // If everything goes well, we will present our first page here
      return ApiResponse(
        success: true,
        object: Routes.documentDetailsHomePage,
      );
    } catch (e) {
      Log.e('[root.view]', error: e);

      String message = 'A generic error message here';
      if (e is ApiError) {
        message = e.message;
      }

      // If we got some error, we send the user to a friendly error page
      return ApiResponse(
        success: true,
        object: Routes.errorPage,
        message: message,
      );
    }
  }

  // Here I'm setting up all security indormation from env files
  // to avoid expose them in the codebase
  Future setEnvronmentValues() async {
    try {
      const env = kDebugMode ? 'env/dev.env' : 'env/prod.env';
      await dotenv.load(fileName: env);

      Env.baseUrl = dotenv.get('BASE_URL');
      Env.appName = dotenv.get('APP_NAME');

      Log.i('Environment values loaded!');
    } catch (e) {
      Log.e(e.toString(), error: e);
      return null;
    }
  }

  Future internetConnectionChecker() async {
    // Here we can check the device connectivity
  }

  Future setUpFirebaseCrashlytics() async {
    // Here we can set up the crashlytics
  }

  Future setUpFirebaseRemoteConfig() async {
    // Here we can set up firebase remote config
  }

  Future setUpFirebaseMessaging() async {
    // Here we can set up the firebase messaging
  }

  Future setUpDeviceInformation() async {
    // Here we can scan and storage all user device informations such as UDID,
    // Geo Localization, App Version, Operacional System name, etc...
  }

  Future setUpUserSession() async {
    // Here we can storage and update the user session with the backend

    await widget.serviceUser.setUpUserSession();
  }
}
