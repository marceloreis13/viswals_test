import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/routes/route.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/services/document_details/document_details_service.dart';
import 'package:viswals/ui/features/document_details/widgets/document_details_progress_widget.dart';
import 'package:viswals/ui/widgets/buttons/vw_default_button.dart';
import 'package:viswals/ui/widgets/scaffolds/scaffold_clean.dart';

class DocumentDetailsHomePage extends StatelessWidget {
  const DocumentDetailsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentDetailsView(
      context: context,
      service: DocumentDetailsService(
        userProvider: context.read<UserProviderProtocol>(),
        countryProvider: context.read<CountryProviderProtocol>(),
      ),
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
    initialSetUp();

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
          const Spacer(),
          startButton,
        ],
      ),
    );
  }

  Widget get progressCircle =>
      const DocumentDetailsProgressWidget(axis: Axis.vertical);

  Widget get startButton {
    // int step = 1;
    return Column(
      children: [
        VWDefaultButtonWidget(
          title: 'START',
          onPressed: () {
            service.userService.setAsNextStep(context);
            Navigator.of(context)
                .pushNamed(Routes.documentDetailsTypePage.route);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void initialSetUp() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      service.userService.setAsFirstStep();
    });
  }
}
