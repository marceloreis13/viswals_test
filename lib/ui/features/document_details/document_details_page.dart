import 'package:flutter/material.dart';
import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/domain/services/document_details/document_details_service.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/buttons/vw_button.dart';
import 'package:viswals/ui/widgets/scaffolds/scaffold_clean.dart';
import 'package:viswals/ui/widgets/progress_circle/progress_circle_widget.dart';

class DocumentDetailsPage extends StatelessWidget {
  const DocumentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentDetailsView(
      context: context,
      service: DocumentDetailsService(),
    );
  }
}

class DocumentDetailsView extends StatelessWidget {
  final BuildContext context;
  final DocumentDetailsService service;
  const DocumentDetailsView({
    super.key,
    required this.service,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldClean(
      titleText: 'User Profile',
      body: content,
    );
  }

  Widget get content {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Spacer(),
          progressCircle,
          title,
          subtitle,
          const Spacer(),
          startButton,
        ],
      ),
    );
  }

  Widget get progressCircle {
    return Column(
      children: [
        SizedBox(
          width: 192,
          height: 192,
          child: ProgressCircleWidget(
            steps: Constant.progressCircleSteps,
          ),
        ),
        const SizedBox(height: 73),
      ],
    );
  }

  Widget get title {
    return const Column(
      children: [
        Text(
          'Document Details',
          style: VwTextStyles.headlineMedium,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget get subtitle {
    return const Text(
      "Let’s create a user profile",
      style: VwTextStyles.bodySmall,
    );
  }

  Widget get startButton {
    int step = 1;
    return Column(
      children: [
        VWButtonWidget(
          title: 'START',
          onPressed: () {
            service.setStepAsActive(step, context);
            service.setStepAsCompleted(step, context);

            // Temporary code to allow show the Progress Circle element working
            step++;
            if ((step - 1) >= Constant.progressCircleSteps.length) {
              step = 0;
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
