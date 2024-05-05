import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_button_syles.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/buttons/vw_button.dart';

class VWDefaultButtonWidget extends StatelessWidget {
  final String title;
  final bool disabled;
  final VoidCallback? onPressed;

  const VWDefaultButtonWidget({
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
      style: VwButtonStyles.defaultButton,
      textStyle: VwTextStyles.buttonText,
      onPressed: onPressed,
    );
  }
}
