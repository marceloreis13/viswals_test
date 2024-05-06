import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_button_syles.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/buttons/vw_button.dart';

class VWSecondaryButtonWidget extends StatelessWidget {
  final String title;
  final bool disabled;
  final VoidCallback? onPressed;

  const VWSecondaryButtonWidget({
    super.key,
    this.onPressed,
    this.disabled = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return VWButtonWidget(
      title: title,
      style: style,
      textStyle: VwTextStyles.primaryButtonText,
      onPressed: onPressed,
    );
  }

  ButtonStyle get style {
    return !disabled
        ? VwButtonStyles.secondaryButton
        : VwButtonStyles.secondaryButtonDisabled;
  }
}
