import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/constants/constant.dart';
import 'package:viswals/app/routes/route.dart';
import 'package:viswals/domain/models/user/user_constants.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/services/document_details/document_details_service.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/features/document_details/document_details_states.dart';
import 'package:viswals/ui/features/document_details/widgets/document_details_progress_widget.dart';
import 'package:viswals/ui/widgets/app_bars/vw_app_bar.dart';
import 'package:viswals/ui/widgets/bottom_sheet_options/bottom_sheet_options_widget.dart';
import 'package:viswals/ui/widgets/buttons/vw_dropdown_button.dart';
import 'package:viswals/ui/widgets/buttons/vw_primary_button.dart';
import 'package:viswals/ui/widgets/scaffolds/scaffold_clean.dart';

class DocumentDetailsTypePage extends StatefulWidget {
  const DocumentDetailsTypePage._();
  static Widget init() => MultiProvider(
        providers: [
          // State Manager
          ChangeNotifierProvider(
            lazy: false,
            create: (context) => DocumentDetailsTypeState(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (context) => DocumentDetailsService(
              userProvider: context.read<UserProviderProtocol>(),
              countryProvider: context.read<CountryProviderProtocol>(),
            ),
          ),
        ],
        child: const DocumentDetailsTypePage._(),
      );

  @override
  State<DocumentDetailsTypePage> createState() => DocumentDetailsViewState();
}

class DocumentDetailsViewState extends State<DocumentDetailsTypePage> {
  late DocumentDetailsService service;
  late DocumentDetailsTypeState pageState;

  @override
  void initState() {
    super.initState();
    initialSetUp();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldClean(
      appBar: VwAppBar(
        title: const Text(
          'Information',
          style: VwTextStyles.headlineSmall,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: VwColors.primaryFont,
          ),
          onPressed: () {
            service.userService.setAsFirstStep();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'skip',
              style: VwTextStyles.listItemText,
            ),
            onPressed: () {
              service.userService.setAsNextStep(context);
              Navigator.of(context)
                  .pushNamed(Routes.documentDetailsCountryPage.route);
            },
          )
        ],
      ),
      body: content,
    );
  }
}

// Widgets

extension DocumentDetailsWidgetsExt on DocumentDetailsViewState {
  Widget get content {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 32),
          progressCircle,
          const SizedBox(height: 48),
          typeButton,
          const Spacer(),
          nextButton,
        ],
      ),
    );
  }

  Widget get progressCircle =>
      const DocumentDetailsProgressWidget(axis: Axis.horizontal);

  Widget get typeButton {
    return Column(
      children: [
        Consumer<DocumentDetailsTypeState>(
          builder: (context, value, child) {
            return VWDropDownButtonWidget(
              title: 'Type',
              value: service.userService.user.docType?.title,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return BottomSheetOptionsWidget(
                      options: service.loadUserDocTypeOptions(context, () {
                        pageState.refresh();
                      }),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget get nextButton {
    return Column(
      children: [
        Consumer<DocumentDetailsTypeState>(builder: (context, value, child) {
          return VWPrimaryButtonWidget(
            title: 'NEXT',
            disabled: !service.isDocTypeFilled(),
            onPressed: !service.isDocTypeFilled()
                ? null
                : () {
                    service.userService.setAsNextStep(context);
                    Navigator.of(context)
                        .pushNamed(Routes.documentDetailsCountryPage.route);
                  },
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Functions

extension DocumentDetailsFunctionsExt on DocumentDetailsViewState {
  void initialSetUp() {
    service = context.read<DocumentDetailsService>();
    pageState = context.read<DocumentDetailsTypeState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      service.userService.setStepAsActive(docDetailTypeStep, context);
    });
  }
}
