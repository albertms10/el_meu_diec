import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AutocompleteEntryFutureCard extends StatelessWidget {
  final AutocompleteEntry autocompleteEntry;
  final String query;

  const AutocompleteEntryFutureCard({
    super.key,
    required this.autocompleteEntry,
    required this.query,
  });

  Future<Word> fetchWordFromCache(BuildContext context) async =>
      Provider.of<WordCache>(context, listen: false)
          .wordFromId(autocompleteEntry.id) ??
      autocompleteEntry.toWord(
        senses: await DefinitionEntrySenses.fetch(autocompleteEntry.id),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Word>(
      future: fetchWordFromCache(context),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return AutocompleteEntryCard(
              query: query,
              word: autocompleteEntry.toWord(),
              isLoading: true,
            );

          case ConnectionState.active:
          case ConnectionState.done:
            final word = snapshot.data!;
            Provider.of<WordCache>(context, listen: false).addWord(word);

            return AutocompleteEntryCard(query: query, word: word);
        }
      },
    );
  }
}
