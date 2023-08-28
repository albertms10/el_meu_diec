import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntriesListView extends StatelessWidget {
  final String? query;

  const AutocompleteEntriesListView({super.key, this.query});

  @override
  Widget build(BuildContext context) {
    if (query == null) return const SizedBox();

    return FutureBuilder<List<AutocompleteEntry>?>(
      future: AutocompleteEntries.fetch(query!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: const [
                EquippedCard(),
                EquippedCard(),
                EquippedCard(),
                EquippedCard(),
              ],
            );

          case ConnectionState.active:
          case ConnectionState.done:
            final autocompleteEntries = snapshot.data!;

            return ListView.builder(
              itemCount: autocompleteEntries.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 30),
              itemBuilder: (context, index) {
                final autocompleteEntry = autocompleteEntries[index];

                return AutocompleteEntryCard(
                  query: query!,
                  word: autocompleteEntry.word,
                  isFavorite: true,
                  visits: 1,
                );
              },
            );
        }
      },
    );
  }
}
