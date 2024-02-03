import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/constants.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_future_card.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntriesListView extends StatelessWidget {
  final String query;

  const AutocompleteEntriesListView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.canvasColor,
      child: FutureBuilder(
        future: AutocompleteEntries.fetch(query),
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
                autocompleteEntries: snapshot.data!,
              );
          }
        },
      ),
    );
  }
}

class _EntriesList extends StatelessWidget {
  final List<AutocompleteEntry> autocompleteEntries;
  final String query;

  const _EntriesList({
    super.key,
    required this.autocompleteEntries,
    required this.query,
  });

  static const maxResults = 20;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scrollbar(
      child: ListView.builder(
        itemCount: autocompleteEntries.length + 1,
        semanticChildCount: autocompleteEntries.length,
        shrinkWrap: true,
        itemExtent: autocompleteEntryCardHeight,
        padding: const EdgeInsetsDirectional.only(bottom: 80),
        itemBuilder: (context, index) {
          if (index == autocompleteEntries.length) {
            final reachedMaxResults = autocompleteEntries.length >= maxResults;

            return Padding(
              padding: const EdgeInsetsDirectional.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${autocompleteEntries.length} resultats'
                    '${reachedMaxResults ? ' o més' : ''}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge,
                  ),
                  if (reachedMaxResults)
                    const IconButton(
                      onPressed: null,
                      iconSize: 16,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      padding: EdgeInsets.all(2),
                      tooltip: 'Es mostren els primers $maxResults '
                          'resultats de l’autocompletat.',
                      icon: Icon(Icons.question_mark),
                    ),
                ],
              ),
            );
          }

          return AutocompleteEntryFutureCard(
            autocompleteEntry: autocompleteEntries[index],
            query: query,
          );
        },
      ),
    );
  }
}
