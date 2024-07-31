import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/collections_list.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
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
          style: const TextStyle(
            fontVariations: [FontVariation.weight(600)],
            overflow: TextOverflow.fade,
          ),
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
        final result = await showDialog<(String, Color)>(
          context: context,
          builder: (context) {
            return const _AddCollectionDialog();
          },
        );

        if (result == null) return;
        final (name, color) = result;

        bookmarkCollections
            .addCollection(BookmarkCollection(name: name, color: color, {}));
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

  Color _color = Colors.blue;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collections = Provider.of<BookmarkCollections>(context).collections;

    final appLocalizations = AppLocalizations.of(context);

    final colorSwatch =
        ColorScheme.fromSeed(seedColor: _color, primary: _color);

    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(appLocalizations.newCollection),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                fillColor: colorSwatch.inversePrimary.withOpacity(0.1),
                contentPadding: const EdgeInsetsDirectional.all(20),
                enabledBorder: defaultInputBorder.copyWith(
                  borderSide: BorderSide(color: colorSwatch.primary, width: 2),
                ),
                focusedBorder: defaultInputBorder.copyWith(
                  borderSide: BorderSide(color: colorSwatch.primary, width: 3),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return appLocalizations.emptyCollectionValidation;
                }
                if (collections.containsKey(value.trim())) {
                  return appLocalizations.collectionNameAlreadyInUseValidation;
                }

                return null;
              },
            ),
            Flexible(
              child: SingleChildScrollView(
                child: ColorPicker(
                  color: _color,
                  borderRadius: 20,
                  enableShadesSelection: false,
                  pickersEnabled: const {
                    ColorPickerType.both: true,
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                  },
                  onColorChanged: (color) {
                    setState(() {
                      _color = color;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              Navigator.of(context)
                  .pop<(String, Color)>((_controller.text.trim(), _color));
            },
            child: Text(appLocalizations.ok),
          ),
        ],
      ),
    );
  }
}
