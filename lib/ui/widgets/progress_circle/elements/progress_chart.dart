import 'package:flutter/material.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'dart:math' as math;
import 'package:viswals/ui/widgets/progress_circle/progress_model.dart';

class ProgressCircleChartWidget extends StatefulWidget {
  final List<ProgressStepsModel> steps;

  const ProgressCircleChartWidget({
    super.key,
    required this.steps,
  });

  @override
  State<ProgressCircleChartWidget> createState() =>
      _ProgressCircleChartWidgetState();
}

class _ProgressCircleChartWidgetState extends State<ProgressCircleChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    setUpProgressCircle();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return content;
      },
    );
  }

  Widget get content {
    final stepsFilledCount =
        widget.steps.where((step) => step.isCompleted).length;
    final stepsCount = widget.steps.length;
    double progress = 0.0;

    if (stepsFilledCount > 0) {
      progress = stepsFilledCount / stepsCount;
    }

    _controller.animateTo(progress);

    return CustomPaint(
      painter: ProgressPainter(progress: _animation.value),
      child: Center(
        child: Text(
          '${(_animation.value * 100).toInt()}%',
          style: VwTextStyles.headlineLarge,
        ),
      ),
    );
  }

  void setUpProgressCircle() {
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    // Start the animation
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);
    const strokeWidth = 30.0;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = VwColors.thirth
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = VwColors.fourth
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
