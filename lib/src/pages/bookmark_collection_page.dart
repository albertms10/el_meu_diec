import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkCollectionPage extends StatelessWidget {
  static const routeName = 'bookmark_collection_page';

  final BookmarkCollection collection;

  const BookmarkCollectionPage({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    final wordCache = Provider.of<WordCache>(context);

    final theme = Theme.of(context);

    final bookmarks = collection.sortedBookmarks;

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
      body: ListView.builder(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          bottom: 32,
        ),
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final word = wordCache.wordFromId(
            bookmarks.entries.elementAt(index).key,
          )!;

          return AutocompleteEntryCard(query: word.word, word: word);
        },
      ),
    );
  }
}
