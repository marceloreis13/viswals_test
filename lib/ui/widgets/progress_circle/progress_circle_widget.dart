import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/domain/models/user/user_progress_model.dart';
import 'package:viswals/ui/widgets/progress_circle/elements/progress_steps.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_circle_state.dart';

class ProgressCircleWidget extends StatefulWidget {
  final List<UserProgressStepsModel> steps;

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
