import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_future_card.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntriesListView extends StatelessWidget {
  final String query;

  const AutocompleteEntriesListView({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    return FutureBuilder(
      future: AutocompleteEntries.fetch(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const SizedBox();

          case ConnectionState.waiting:
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: const [
                EquippedCard(isLoading: true),
                EquippedCard(isLoading: true),
                EquippedCard(isLoading: true),
                EquippedCard(isLoading: true),
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
                return AutocompleteEntryFutureCard(
                  autocompleteEntry: autocompleteEntries[index],
                  query: query,
                );
              },
            );
        }
      },
    );
  }
}
