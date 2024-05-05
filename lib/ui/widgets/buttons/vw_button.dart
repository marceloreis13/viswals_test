import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VWButtonWidget extends StatelessWidget {
  final String title;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  const VWButtonWidget({
    super.key,
    this.onPressed,
    this.style,
    required this.title,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(
          title,
          style: textStyle ?? VwTextStyles.buttonText,
        ),
      ),
    );
  }
}
