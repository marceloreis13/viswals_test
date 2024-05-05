import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VwTextFieldStyles {
  VwTextFieldStyles._();

  static InputDecoration primary = InputDecoration(
    fillColor: Colors.white,
    labelStyle: VwTextStyles.bodySmallAlt,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: VwColors.fourth.withOpacity(0.7),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: VwColors.fourth.withOpacity(0.7),
      ),
    ),
  );
}
