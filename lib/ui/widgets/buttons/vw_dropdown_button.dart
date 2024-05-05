import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_button_syles.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';

class VWDropDownButtonWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Function()? onPressed;

  const VWDropDownButtonWidget({
    super.key,
    this.value,
    this.onPressed,
    required this.title,
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
        onPressed: onPressed,
        style: VwButtonStyles.dropDownButton,
        child: value != null ? filledState : emptyState,
      ),
    );
  }

  Widget get emptyState {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: VwTextStyles.listItemText,
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: VwColors.thirth,
        ),
      ],
    );
  }

  Widget get filledState {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: VwTextStyles.listItemText.copyWith(fontSize: 9.0),
              ),
              Text(
                "$value",
                textAlign: TextAlign.left,
                style: VwTextStyles.bodySmallAlt,
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: VwColors.thirth,
        ),
      ],
    );
  }
}
