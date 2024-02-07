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
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          icon: const Icon(Icons.close),
        ),
        actions: const [
          _AddCollectionButton(),
          SizedBox(width: 4),
        ],
      ),
      backgroundColor: theme.canvasColor,
      body: CollectionsList(collections: collections),
    );
  }
}

class _AddCollectionButton extends StatelessWidget {
  const _AddCollectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkCollections = Provider.of<BookmarkCollections>(context);

    final appLocalizations = AppLocalizations.of(context);

    return IconButton(
      tooltip: appLocalizations.newCollection,
      onPressed: () async {
        final collectionName = await showDialog<String>(
          context: context,
          builder: (context) {
            return const _AddCollectionDialog();
          },
        );

        if (collectionName == null) return;

        bookmarkCollections.addCollection(collectionName);
      },
      icon: const Icon(Icons.add),
    );
  }
}

class _AddCollectionDialog extends StatefulWidget {
  const _AddCollectionDialog({super.key});

  @override
  State<_AddCollectionDialog> createState() => _AddCollectionDialogState();
}

class _AddCollectionDialogState extends State<_AddCollectionDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(appLocalizations.newCollection),
        content: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(errorMaxLines: 2),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return appLocalizations.emptyCollectionValidation;
            }

            return null;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop<String>(_controller.text);
              }
            },
            child: Text(appLocalizations.ok),
          ),
        ],
      ),
    );
  }
}
