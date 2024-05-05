import 'package:flutter/material.dart';
import 'package:viswals/app/constants/env.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_circle_widget.dart';

class DocumentDetailsProgressWidget extends StatelessWidget {
  final Axis axis;
  const DocumentDetailsProgressWidget({
    super.key,
    required this.axis,
  });

  @override
  Widget build(BuildContext context) {
    return content;
  }

  Widget get content {
    return axis == Axis.vertical ? vertical : horizontal;
  }

  Widget get vertical {
    return Column(
      children: [
        progressCircle,
        const SizedBox(height: 73),
        title,
        const SizedBox(height: 16),
        subtitle,
      ],
    );
  }

  Widget get horizontal {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: title,
            ),
            progressCircle,
          ],
        ),
      ],
    );
  }

  Widget get title {
    return const Text(
      'Document Details',
      style: VwTextStyles.headlineMedium,
    );
  }

  Widget get subtitle {
    return const Text(
      "Let’s create a user profile",
      style: VwTextStyles.bodySmall,
    );
  }

  Widget get progressCircle {
    return Column(
      children: [
        SizedBox(
          width: 192,
          height: 192,
          child: ProgressCircleWidget(
            steps: Env.user.onboardingProgress,
          ),
        ),
      ],
    );
  }
}
