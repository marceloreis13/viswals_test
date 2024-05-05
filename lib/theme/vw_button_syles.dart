import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';

class VwButtonStyles {
  VwButtonStyles._();

  static MaterialStateProperty<OutlinedBorder?> get squaredShape {
    return MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  static ButtonStyle defaultButton = ButtonStyle(
    shape: squaredShape,
    backgroundColor:
        MaterialStateProperty.all(VwColors.defaultButtonBackground),
  );

  static ButtonStyle primaryButton = ButtonStyle(
    shape: squaredShape,
    backgroundColor: MaterialStateProperty.all(VwColors.fourth),
  );

  static ButtonStyle primaryButtonDisabled = ButtonStyle(
    shape: squaredShape,
    backgroundColor:
        MaterialStateProperty.all(VwColors.fourth.withOpacity(0.3)),
  );

  static ButtonStyle optionButton = ButtonStyle(
    shape: squaredShape,
    backgroundColor: MaterialStateProperty.all(VwColors.optionButtonBackground),
    side: MaterialStateProperty.all(
      const BorderSide(
        color: VwColors.secondary,
        width: 1.0,
      ),
    ),
  );

  static ButtonStyle dropDownButton = ButtonStyle(
    shape: squaredShape,
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    side: MaterialStateProperty.all(
      BorderSide(
        color: VwColors.fourth.withOpacity(0.7),
        width: 1.0,
      ),
    ),
  );
}
