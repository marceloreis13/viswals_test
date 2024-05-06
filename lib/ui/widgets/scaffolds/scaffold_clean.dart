import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/app_bars/vw_app_bar.dart';

class ScaffoldClean extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? title;
  final String? titleText;
  final Widget body;
  final Color? backgroundColor;

  /// A reusable Scaffold widget intended for global use throughout the project.
  /// Any modifications made here will reflect globally across the application.
  ScaffoldClean({
    super.key,
    this.title,
    this.titleText,
    this.appBar,
    this.backgroundColor,
    required this.body,
  }) : super() {
    assert(appBar != null || title != null || titleText != null,
        'Either "title" or "titleText" should be informed');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return content(context);
  }

  Widget content(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar ?? defaultAppBar,
      backgroundColor: backgroundColor ?? VwColors.background,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          // FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(child: body),
      ),
    );
  }

  PreferredSizeWidget get defaultAppBar {
    Widget? titleWidget = title;
    titleWidget ??= Text(
      "$titleText",
      style: VwTextStyles.headlineSmall,
    );

    return VwAppBar(title: titleWidget);
  }
}
