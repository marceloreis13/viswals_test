import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';

class VwTextStyles {
  VwTextStyles._();

  static const TextStyle headlineSmall = TextStyle(
    color: VwColors.primaryFont,
    fontSize: 13.0,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle headlineMedium = TextStyle(
    color: VwColors.primaryFont,
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle headlineLarge = TextStyle(
    color: VwColors.primaryFont,
    fontSize: 32.0,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle bodySmall = TextStyle(
    color: VwColors.fourth,
    fontSize: 13.0,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );

  static TextStyle buttonText = headlineSmall.copyWith(
    color: VwColors.primary,
  );
}
