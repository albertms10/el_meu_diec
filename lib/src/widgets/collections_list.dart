import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/pages/bookmark_collection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CollectionsList extends StatelessWidget {
  final Set<BookmarkCollection> collections;

  const CollectionsList({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    final wordCache = Provider.of<WordCache>(context);

    final appLocalizations = AppLocalizations.of(context);

    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final collection = collections.elementAt(index);
        final bookmarks = collection.sortedBookmarks;
        final lastWords =
            bookmarks.keys.take(3).map(wordCache.wordFromId).toList();

        return ListTile(
          title: Text(collection.name),
          subtitle: Text(appLocalizations.nWords(bookmarks.length)),
          visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
          leading: _CollectionAvatar(words: lastWords),
          onTap: () async {
            await Navigator.of(context).pushNamed(
              BookmarkCollectionPage.routeName,
              arguments: collection,
            );
          },
        );
      },
    );
  }
}

class _CollectionAvatar extends StatelessWidget {
  final List<Word?> words;

  const _CollectionAvatar({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const wordTextStyle =
        TextStyle(fontSize: 16, letterSpacing: -0.5, height: 1.15);

    return Container(
      width: 72,
      height: 72,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final word in words)
            Text(
              word?.word ?? '',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: wordTextStyle,
            ),
        ],
      ),
    );
  }
}
