import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_button_syles.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/buttons/vw_button.dart';

class VWOptionsButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const VWOptionsButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return VWButtonWidget(
      title: title,
      style: VwButtonStyles.optionButton,
      textStyle: VwTextStyles.bodySmallAlt,
      onPressed: onPressed,
    );
  }
}
