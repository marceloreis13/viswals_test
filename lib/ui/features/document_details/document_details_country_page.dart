// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/app/routes/route.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/services/document_details/document_details_service.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/features/document_details/document_details_states.dart';
import 'package:viswals/ui/features/document_details/widgets/document_details_progress_widget.dart';
import 'package:viswals/ui/widgets/app_bars/vw_app_bar.dart';
import 'package:viswals/ui/widgets/buttons/vw_dropdown_button.dart';
import 'package:viswals/ui/widgets/buttons/vw_primary_button.dart';
import 'package:viswals/ui/widgets/buttons/vw_secondary_button.dart';
import 'package:viswals/ui/widgets/scaffolds/scaffold_clean.dart';
import 'package:viswals/ui/widgets/text_fields/vw_text_field.dart';

class DocumentDetailsCountryPage extends StatefulWidget {
  const DocumentDetailsCountryPage._();
  static Widget init() => MultiProvider(
        providers: [
          // State Manager
          ChangeNotifierProvider(
            lazy: false,
            create: (context) => DocumentDetailsCountryState(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (context) => DocumentDetailsService(
              userProvider: context.read<UserProviderProtocol>(),
              countryProvider: context.read<CountryProviderProtocol>(),
            ),
          ),
        ],
        child: const DocumentDetailsCountryPage._(),
      );

  @override
  State<DocumentDetailsCountryPage> createState() => DocumentDetailsViewState();
}

class DocumentDetailsViewState extends State<DocumentDetailsCountryPage> {
  late DocumentDetailsService service;
  late DocumentDetailsCountryState pageState;
  late FocusNode _focusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initialSetUp();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
          onPressed: () {
            service.userService.setAsPrevStep(context);
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: VwColors.primaryFont,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'skip',
              style: VwTextStyles.listItemText,
            ),
            onPressed: () {
              service.userService.setAsNextStep(context);
              // Navigator.of(context)
              //     .pushNamed(Routes.documentDetailsProfilePage.route);
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
          form,
          const Spacer(),
          actions,
        ],
      ),
    );
  }

  Widget get progressCircle =>
      const DocumentDetailsProgressWidget(axis: Axis.horizontal);

  Widget get form {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          numberField,
          const SizedBox(height: 16),
          countryField,
        ],
      ),
    );
  }

  Widget get numberField => VWTextFieldWidget(
        labelText: 'Number',
        focusNode: _focusNode,
        initialValue: service.userService.user.doc,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          service.onDocTextFieldChanged(value, context);
        },
      );

  Widget get countryField => Column(
        children: [
          Consumer<DocumentDetailsCountryState>(
            builder: (context, value, child) {
              return VWDropDownButtonWidget(
                title: 'Country',
                value: service.userService.user.country?.name,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(Routes.documentDetailsCountryListPage.route)
                      .then((value) {
                    setState(() {});
                  });
                },
              );
            },
          ),
        ],
      );

  Widget get actions {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: prevButton),
            const SizedBox(width: 16),
            Expanded(child: nextButton),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget get prevButton {
    return VWSecondaryButtonWidget(
      title: 'PREV',
      disabled: false,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget get nextButton {
    return Consumer<DocumentDetailsCountryState>(
        builder: (context, value, child) {
      return VWPrimaryButtonWidget(
        title: 'NEXT',
        disabled: !service.isDocAndCountryFilled(),
        onPressed: !service.isDocAndCountryFilled()
            ? null
            : () {
                print('HERE');
              },
      );
    });
  }
}

// Functions

extension DocumentDetailsFunctionsExt on DocumentDetailsViewState {
  void initialSetUp() {
    _focusNode = FocusNode();
    service = context.read<DocumentDetailsService>();
    pageState = context.read<DocumentDetailsCountryState>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      service.requestFocusIfNeeded(_focusNode);
      service.updateCountryPageProgress(context);
    });
  }
}
