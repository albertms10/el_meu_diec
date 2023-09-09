import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntryFutureCard extends StatelessWidget {
  final String id;
  final String query;
  final String word;

  const AutocompleteEntryFutureCard({
    super.key,
    required this.id,
    required this.query,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefinitionEntrySenses.fetch(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return AutocompleteEntryCard(
              query: query,
              word: word,
              isLoading: true,
            );

          case ConnectionState.active:
          case ConnectionState.done:
            final senses = DefinitionEntrySenses.parseHtml(snapshot.data!);

            return AutocompleteEntryCard(
              query: query,
              word: word,
              isFavorite: true,
              senses: senses,
            );
        }
      },
    );
  }
}
