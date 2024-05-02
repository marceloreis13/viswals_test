import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/ui/widgets/progress_circle/elements/progress_chart.dart';
import 'dart:math' as math;

import 'package:viswals/ui/widgets/progress_circle/progress_model.dart';

class ProgressStepsWidget extends StatelessWidget {
  final List<ProgressStepsModel> steps;

  const ProgressStepsWidget({
    super.key,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ProgressStepsWidgetPainter(
        steps: steps,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: ProgressCircleChartWidget(steps: steps),
      ),
    );
  }
}

class ProgressStepsWidgetPainter extends CustomPainter {
  final List<ProgressStepsModel> steps;

  ProgressStepsWidgetPainter({
    required this.steps,
  });

  @override
  void paint(Canvas canvas, Size size) {
    steps.asMap().forEach((index, step) {
      buildStep(canvas, size, step, index);
    });
  }

  void buildStep(
    Canvas canvas,
    Size size,
    ProgressStepsModel step,
    int position,
  ) {
    const dividerWidth = 0.04;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    const strokeWidth = 16.0;

    const startAngleBase = -math.pi / 2;
    const sweepAngleDot = 0.001;
    final sweepAngle = (2 * math.pi) / steps.length;
    final startAngle = (startAngleBase + (sweepAngle * position));
    final startAngleDot = (startAngle + (sweepAngle / 2));

    if (step.isActive) {
      // Draw current position dots
      paintStep(
        canvas,
        center,
        radius + 25,
        VwColors.fourth,
        strokeWidth,
        startAngleDot,
        sweepAngleDot,
        hasRoundedCap: true,
      );

      // Draw current position borders
      paintStep(
        canvas,
        center,
        radius,
        VwColors.primary,
        strokeWidth * 1.2,
        startAngle - dividerWidth,
        sweepAngle + dividerWidth,
      );
    }

    // Draw background arc
    paintStep(
      canvas,
      center,
      radius,
      VwColors.secondary,
      strokeWidth * 0.4,
      startAngle,
      sweepAngle - dividerWidth,
    );

    if (step.isCompleted) {
      // Draw progress arc
      paintStep(
        canvas,
        center,
        radius,
        VwColors.fourth,
        strokeWidth * 0.4,
        startAngle,
        sweepAngle - dividerWidth,
      );
    }
  }

  void paintStep(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
    double strokeWidth,
    double startAngle,
    double sweepAngle, {
    bool hasRoundedCap = false,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    if (hasRoundedCap) {
      paint.strokeCap = StrokeCap.round;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
