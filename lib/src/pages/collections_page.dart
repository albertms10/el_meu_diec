import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/collections_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CollectionsPage extends StatelessWidget {
  static const routeName = 'collections_page';

  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections =
        Provider.of<BookmarkCollections>(context).sortedCollections;

    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.myCollections,
          style: const TextStyle(fontVariations: [FontVariation.weight(600)]),
        ),
        backgroundColor: theme.canvasColor,
        surfaceTintColor: theme.canvasColor,
        shadowColor: theme.canvasColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      backgroundColor: theme.canvasColor,
      body: CollectionsList(collections: collections),
    );
  }
}
