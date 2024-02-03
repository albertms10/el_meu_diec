import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/constants.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_future_card.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AutocompleteEntriesListView extends StatelessWidget {
  final String query;
  final SearchCondition searchCondition;

  const AutocompleteEntriesListView({
    super.key,
    required this.query,
    this.searchCondition = SearchCondition.defaultCondition,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    return FutureBuilder(
      future:
          AutocompleteEntries.fetch(query, searchCondition: searchCondition),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return ListView(
              padding: const EdgeInsets.only(bottom: 60),
              itemExtent: autocompleteEntryCardHeight,
              children: const [
                EquippedCard(
                  height: autocompleteEntryCardHeight,
                  isLoading: true,
                ),
                EquippedCard(
                  height: autocompleteEntryCardHeight,
                  isLoading: true,
                ),
                EquippedCard(
                  height: autocompleteEntryCardHeight,
                  isLoading: true,
                ),
                EquippedCard(
                  height: autocompleteEntryCardHeight,
                  isLoading: true,
                ),
              ],
            );

          case ConnectionState.active:
          case ConnectionState.done:
            return _EntriesList(
              query: query,
              searchCondition: searchCondition,
              autocompleteEntries: snapshot.data!,
            );
        }
      },
    );
  }
}

class _EntriesList extends StatelessWidget {
  final String query;
  final SearchCondition searchCondition;
  final List<AutocompleteEntry> autocompleteEntries;

  const _EntriesList({
    super.key,
    required this.query,
    required this.autocompleteEntries,
    this.searchCondition = SearchCondition.defaultCondition,
  });

  static const maxResults = 20;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ListView.builder(
      itemCount: autocompleteEntries.length + 1,
      semanticChildCount: autocompleteEntries.length,
      shrinkWrap: true,
      itemExtent: autocompleteEntryCardHeight,
      padding: const EdgeInsetsDirectional.only(bottom: 150),
      itemBuilder: (context, index) {
        if (index == autocompleteEntries.length) {
          final reachedMaxResults = autocompleteEntries.length >= maxResults;

          return Padding(
            padding: const EdgeInsetsDirectional.all(32),
            child: TextButton(
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.nResults(autocompleteEntries.length) +
                        (reachedMaxResults
                            ? ' ${appLocalizations.orMore}'
                            : ''),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge,
                  ),
                  if (reachedMaxResults)
                    IconButton(
                      onPressed: null,
                      iconSize: 16,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      padding: const EdgeInsets.all(2),
                      tooltip:
                          appLocalizations.firstNResultsAreShown(maxResults),
                      icon: const Icon(Icons.question_mark),
                    ),
                ],
              ),
            ),
          );
        }

        return ColoredBox(
          color: theme.canvasColor,
          child: AutocompleteEntryFutureCard(
            query: query,
            searchCondition: searchCondition,
            autocompleteEntry: autocompleteEntries[index],
          ),
        );
      },
    );
  }
}
