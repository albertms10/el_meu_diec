import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkCollectionPage extends StatelessWidget {
  final BookmarkCollection collection;

  const BookmarkCollectionPage({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final wordCache = Provider.of<WordCache>(context);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          collection.name,
          style: const TextStyle(
            fontVariations: [FontVariation.weight(600)],
          ),
        ),
        backgroundColor: theme.canvasColor,
        surfaceTintColor: theme.canvasColor,
        shadowColor: theme.canvasColor,
      ),
      backgroundColor: theme.canvasColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
          itemCount: collection.bookmarks.length,
          itemBuilder: (context, index) {
            final word = wordCache.wordFromId(
              collection.bookmarks.entries.elementAt(index).key,
            )!;

            return AutocompleteEntryCard(query: word.word, word: word);
          },
        ),
      ),
    );
  }
}
