import 'package:flutter/material.dart';
import 'package:viswals/app/helpers/api/api_helper.dart';
import 'package:viswals/app/helpers/debugger_helper.dart';
import 'package:viswals/app/routes/route.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class SplashScreenPage extends StatefulWidget {
  final Future<ApiResponse<Routes>> Function() setUpInitialConfigurations;
  const SplashScreenPage({
    super.key,
    required this.setUpInitialConfigurations,
  });

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void setUp(BuildContext context) {
    try {
      widget.setUpInitialConfigurations().then((response) {
        Routes? route = response.object;

        if (route != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(route.route, (route) => false);
        } else {
          // Goes to an alternative page, HomeView or LoginView for example
        }
      });
    } catch (e) {
      Log.e('Something went bad', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    setUp(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: VwColors.background, // Set background color
      body: const Center(
        child: Text(
          'Viswals', // Display "Viswals"
          style: VwTextStyles.headlineLarge,
        ),
      ),
    );
  }
}
