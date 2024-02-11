import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_future_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AutocompleteEntriesListView extends StatelessWidget {
  final GlobalKey<AnimatedListState>? listKey;
  final List<AutocompleteEntry> entries;
  final String query;
  final SearchCondition searchCondition;
  final bool isLoading;

  const AutocompleteEntriesListView({
    super.key,
    this.listKey,
    required this.query,
    this.searchCondition = SearchCondition.defaultCondition,
    required this.entries,
    this.isLoading = false,
  });

  static const maxResults = 20;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return AnimatedList(
      key: listKey,
      initialItemCount: entries.length + 1,
      shrinkWrap: true,
      padding: const EdgeInsetsDirectional.only(bottom: 150),
      itemBuilder: (context, index, animation) {
        if (index == entries.length) {
          final reachedMaxResults = entries.length >= maxResults;

          return Padding(
            padding: const EdgeInsetsDirectional.all(32),
            child: TextButton(
              onPressed: null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.nResults(entries.length) +
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

        return SlideTransition(
          position: CurvedAnimation(
            curve: Curves.easeOut,
            parent: animation,
          ).drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
          child: ColoredBox(
            color: theme.canvasColor,
            child: AutocompleteEntryFutureCard(
              query: query,
              searchCondition: searchCondition,
              autocompleteEntry: entries[index],
            ),
          ),
        );
      },
    );
  }
}
