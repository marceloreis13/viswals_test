import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_text_field_styles.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VWTextFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const VWTextFieldWidget({
    super.key,
    this.labelText,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.initialValue,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return SizedBox(
      height: 48,
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onTap: onTap,
        onChanged: onChanged,
        style: VwTextStyles.bodySmallAlt,
        decoration: VwTextFieldStyles.primary.copyWith(
          labelText: labelText,
        ),
      ),
    );
  }
}
