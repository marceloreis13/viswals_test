import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/helpers/state_helper.dart';
import 'package:viswals/domain/services/service_protocol.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_model.dart';

class DocumentDetailsService extends ServiceProtocol {
  List<ProgressStepsModel>? steps = [];

  @override
  get object => steps;

  @override
  set object(value) {
    steps = value;
  }

  void setStepAsActive(int stepActive, BuildContext context) {
    if (stepActive < 1 || stepActive > Constant.progressCircleSteps.length) {
      return;
    }

    Constant.progressCircleSteps.asMap().forEach((index, step) {
      step.isActive = false;
      if ((stepActive - 1) == index) {
        step.isActive = true;
      }
    });

    context.read<ProgressCircleState>().refresh();
  }

  void setStepAsCompleted(int stepComplete, BuildContext context,
      {bool isCompleted = true}) {
    if (stepComplete < 1 ||
        stepComplete > Constant.progressCircleSteps.length) {
      return;
    }

    Constant.progressCircleSteps[stepComplete - 1].isCompleted = isCompleted;
    context.read<ProgressCircleState>().refresh();
  }
}
