import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/pages/bookmark_collection_page.dart';
import 'package:el_meu_diec/src/widgets/collection_avatar.dart';
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
      padding: const EdgeInsetsDirectional.only(bottom: 16),
      itemBuilder: (context, index) {
        final collection = collections.elementAt(index);
        final bookmarks = collection.sortedBookmarks;
        final lastWords =
            bookmarks.keys.take(6).map(wordCache.wordFromId).toList();

        return ListTile(
          title: Text(collection.name),
          subtitle: Text(appLocalizations.nWords(bookmarks.length)),
          visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
          leading: Theme(
            data: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: collection.color,
                primary: collection.color,
              ),
            ),
            child: CollectionAvatar(words: lastWords),
          ),
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
