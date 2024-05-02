import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VWButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const VWButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: VwTextStyles.buttonText,
        ),
      ),
    );
  }
}
