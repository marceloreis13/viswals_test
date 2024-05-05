import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_text_field_styles.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VWTextFieldSearchWidget extends StatelessWidget {
  final String? labelText;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const VWTextFieldSearchWidget({
    super.key,
    this.labelText,
    this.onTap,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return SizedBox(
      height: 48,
      child: TextFormField(
        keyboardType: keyboardType,
        onTap: onTap,
        onChanged: onChanged,
        style: VwTextStyles.bodySmallAlt,
        decoration: VwTextFieldStyles.primary.copyWith(
          labelText: labelText,
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
