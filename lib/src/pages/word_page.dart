import 'package:el_meu_diec/src/routes/diec_routes.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:el_meu_diec/src/widgets/bookmark_button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../model/word.dart';

class WordPage extends StatelessWidget {
  final Word word;

  const WordPage({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          word.word,
          style: theme.textTheme.displaySmall!.copyWith(fontSize: 32),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton.filledTonal(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        centerTitle: true,
        actions: [
          BookmarkButton(word: word, isTonalFilled: true),
          IconButton.filledTonal(
            onPressed: () => Share.shareUri(const DIECRoutes().wordUri(word)),
            icon: const Icon(Icons.ios_share_rounded),
          ),
          const SizedBox(width: 4),
        ],
        toolbarHeight: 72,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(20),
          child: DefinitionEntrySenses(word: word),
        ),
      ),
    );
  }
}
