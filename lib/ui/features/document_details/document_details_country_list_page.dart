// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viswals/domain/models/country/country_model.dart';
import 'package:viswals/domain/providers/country/country_depencies.dart';
import 'package:viswals/domain/providers/user/user_dependencies.dart';
import 'package:viswals/domain/services/document_details/document_details_service.dart';
import 'package:viswals/theme/vw_colors.dart';
import 'package:viswals/theme/vw_text_styles.dart';
import 'package:viswals/ui/widgets/buttons/vw_default_button.dart';
import 'package:viswals/ui/widgets/text_fields/vw_text_field_search.dart';

enum SearchState {
  none,
  success,
  loading,
  empty,
}

class DocumentDetailsCountryListPage extends StatefulWidget {
  const DocumentDetailsCountryListPage._();
  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => DocumentDetailsService(
          userProvider: context.read<UserProviderProtocol>(),
          countryProvider: context.read<CountryProviderProtocol>(),
        ),
        child: const DocumentDetailsCountryListPage._(),
      );

  @override
  State<DocumentDetailsCountryListPage> createState() =>
      DocumentDetailsCountryListPageState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class DocumentDetailsCountryListPageState
    extends State<DocumentDetailsCountryListPage> {
  late SearchState searchState = SearchState.none;
  late DocumentDetailsService service;
  final _debouncer = Debouncer();

  List<Country> countrylist = [];
  List<Country> filteredLists = [];

  @override
  void initState() {
    super.initState();
    initialSetUp();
  }

  //Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content,
    );
  }
}

// Widgets

extension DocumentDetailsCountryListWidgetExt
    on DocumentDetailsCountryListPageState {
  Widget get content {
    return Container(
      color: VwColors.background.withOpacity(0.9),
      padding: const EdgeInsets.only(
        top: 52.0,
        left: 20,
        right: 20.0,
        bottom: 16.0,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: VwColors.background,
                border: Border.all(
                  width: 1,
                  color: VwColors.secondaryFont,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: header),
                  const SizedBox(height: 16),
                  searchField,
                  const SizedBox(height: 25),
                  subtitle,
                  const SizedBox(height: 32),
                  countryList,
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          VWDefaultButtonWidget(
            title: 'CANCEL',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget get header {
    return const Text(
      'Country',
      style: VwTextStyles.displaySmall,
    );
  }

  Widget get searchField {
    return VWTextFieldSearchWidget(
      labelText: 'Search',
      onChanged: (string) {
        _debouncer.run(() {
          setState(() {
            filteredLists = countrylist
                .where(
                  (country) => ("${country.name}".toLowerCase().contains(
                        string.toLowerCase(),
                      )),
                )
                .toList();

            searchState =
                filteredLists.isEmpty ? SearchState.empty : SearchState.success;
          });
        });
      },
    );
  }

  Widget get subtitle {
    return const Text(
      "Countries",
      textAlign: TextAlign.start,
      style: VwTextStyles.headlineSmall,
    );
  }

  Widget get countryList {
    switch (searchState) {
      case SearchState.none:
      case SearchState.loading:
        return loadingState;
      case SearchState.empty:
        return emptyState;
      case SearchState.success:
        return successState;
    }
  }

  Widget get loadingState {
    return const Center(
      child: Text(
        'Loading...',
        style: VwTextStyles.headlineSmall,
      ),
    );
  }

  Widget get emptyState {
    return const Center(
      child: Text(
        'No Country Found',
        style: VwTextStyles.headlineSmall,
      ),
    );
  }

  Widget get successState {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: filteredLists.length,
        itemBuilder: (BuildContext context, int index) {
          final country = filteredLists[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: InkWell(
              onTap: () {
                service.onBtnCountryTapped(country, context);
                Navigator.of(context).pop();
              },
              child: Text(
                "${country.name}",
                style: VwTextStyles.listItemText,
              ),
            ),
          );
        },
      ),
    );
  }
}

extension DocumentDetailsCountryListFunctionsExt
    on DocumentDetailsCountryListPageState {
  void initialSetUp() {
    service = context.read<DocumentDetailsService>();
    fetchCountries();
  }

  Future fetchCountries() async {
    service.getAllCountries().then((response) {
      if (response.success) {
        setState(() {
          countrylist = response.object;
          filteredLists = response.object;
          searchState =
              countrylist.isEmpty ? SearchState.empty : SearchState.success;
        });
      }
    });
  }
}
