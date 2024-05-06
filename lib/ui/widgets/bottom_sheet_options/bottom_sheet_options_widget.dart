import 'package:flutter/material.dart';
import 'package:viswals/domain/models/user/user_constants.dart';
import 'package:viswals/ui/widgets/buttons/vw_options_button.dart';

class BottomSheetOptionsWidget extends StatelessWidget {
  final Map<UserDocType, Function()> options;
  const BottomSheetOptionsWidget({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return content(context);
  }

  Widget content(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildOptions(context),
        ),
      ),
    );
  }

  List<Widget> buildOptions(BuildContext context) {
    List<Widget> optionWidgets = [];

    options.forEach((item, onPressed) {
      final widget = Column(
        children: [
          VWOptionsButtonWidget(
            title: item.title,
            onPressed: () {
              onPressed();
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 10),
        ],
      );
      optionWidgets.add(widget);
    });

    final cancelButton = Column(
      children: [
        VWOptionsButtonWidget(
          title: 'CANCEL',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: 16),
      ],
    );

    optionWidgets.add(cancelButton);

    return optionWidgets;
  }
}
