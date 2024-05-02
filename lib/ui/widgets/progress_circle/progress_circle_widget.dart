import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/helpers/state_helper.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_model.dart';
import 'package:viswals/ui/widgets/progress_circle/elements/progress_steps.dart';

class ProgressCircleWidget extends StatefulWidget {
  final List<ProgressStepsModel> steps;

  const ProgressCircleWidget({
    super.key,
    required this.steps,
  });

  @override
  State<ProgressCircleWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressCircleWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressCircleState>(
      builder: (context, value, child) {
        return ProgressStepsWidget(
          steps: widget.steps,
        );
      },
    );
  }
}
