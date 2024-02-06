import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/pages/bookmark_collection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections =
        Provider.of<BookmarkCollections>(context).sortedCollections;
    final wordCache = Provider.of<WordCache>(context);

    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.myCollections,
          style: const TextStyle(
            fontVariations: [FontVariation.weight(600)],
          ),
        ),
        backgroundColor: theme.canvasColor,
        surfaceTintColor: theme.canvasColor,
        shadowColor: theme.canvasColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: theme.canvasColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final collection = collections.elementAt(index);
            final lastWordIds = collection.bookmarks.keys.take(3);

            return ListTile(
              title: Text(collection.name),
              subtitle:
                  Text(appLocalizations.nWords(collection.bookmarks.length)),
              visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
              leading: Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: collection.bookmarks.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final wordId in lastWordIds)
                            Text(
                              wordCache.wordFromId(wordId)?.word ?? '',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(
                                fontSize: 16,
                                letterSpacing: -0.5,
                                height: 1.15,
                              ),
                            ),
                        ],
                      ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) {
                      return BookmarkCollectionPage(collection: collection);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
