import 'dart:async';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entries_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarResults extends StatefulWidget {
  const SearchBarResults({super.key});

  @override
  State<SearchBarResults> createState() => _SearchBarResultsState();
}

class _SearchBarResultsState extends State<SearchBarResults> {
  final ValueNotifier<String> _query = ValueNotifier<String>('');
  final ValueNotifier<SearchCondition> _searchCondition =
      ValueNotifier<SearchCondition>(SearchCondition.defaultCondition);

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _query.value = value.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<String>(
            valueListenable: _query,
            builder: (context, query, child) {
              return ValueListenableBuilder<SearchCondition>(
                valueListenable: _searchCondition,
                builder: (context, searchCondition, child) {
                  return AutocompleteEntriesListView(
                    query: query,
                    searchCondition: searchCondition,
                  );
                },
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80,
                child: ValueListenableBuilder<SearchCondition>(
                  valueListenable: _searchCondition,
                  builder: (context, searchCondition, child) {
                    return ListView.separated(
                      itemCount: SearchCondition.values.length,
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 16),
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8);
                      },
                      itemBuilder: (context, index) {
                        final searchCondition = SearchCondition.values[index];

                        return ChoiceChip.elevated(
                          label: Text(searchCondition.translate()),
                          selected: _searchCondition.value == searchCondition,
                          onSelected: (value) {
                            _searchCondition.value = searchCondition;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  start: 16,
                  end: 16,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  borderRadius: inputBorderRadius,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: 2,
                      color: Color(0x40000000),
                    ),
                  ],
                ),
                child: TextFormField(
                  autocorrect: false,
                  autofocus: true,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: appLocalizations.search,
                    suffixIcon: const Padding(
                      padding: EdgeInsetsDirectional.only(end: 8),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                  onChanged: _onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
