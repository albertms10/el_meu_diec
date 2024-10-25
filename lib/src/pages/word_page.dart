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

    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
        topStart: Radius.circular(30),
        topEnd: Radius.circular(30),
      ),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 6,
          elevation: 2,
          title: SelectableText(
            word.word,
            maxLines: 1,
            style: theme.textTheme.displaySmall!.copyWith(
              fontSize: 32,
              // See https://github.com/flutter/flutter/issues/80434
              overflow: TextOverflow.fade,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton.filledTonal(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
          centerTitle: true,
          actions: [
            BookmarkButton(word: word, isTonalFilled: true),
            IconButton.filledTonal(
              onPressed: () {
                final box = context.findRenderObject() as RenderBox?;

                Share.shareUri(
                  const DIECRoutes().wordUri(word),
                  // See https://pub.dev/packages/share_plus#ipad
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                );
              },
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
      ),
    );
  }
}
