import 'dart:io';
import 'dart:ui';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:el_meu_diec/src/widgets/search_bar_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'El meu DIEC',
          style: TextStyle(fontVariations: [FontVariation.weight(600)]),
        ),
        backgroundColor: theme.canvasColor,
        surfaceTintColor: theme.canvasColor,
        shadowColor: theme.canvasColor,
        actions: const [
          _BookmarksIconButton(),
        ],
      ),
      backgroundColor: theme.canvasColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              heightFactor: 4.5,
              child: SizedBox(
                height: 140,
                child: SvgPicture.asset(
                  'assets/images/el_meu_diec_logo_watermark.svg',
                ),
              ),
            ),
            const SearchBarResults(),
          ],
        ),
      ),
    );
  }
}

class _BookmarksIconButton extends StatelessWidget {
  const _BookmarksIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bookmark),
      tooltip: 'La meva coŀlecció',
      onPressed: () => (Platform.isAndroid
          ? showBarModalBottomSheet
          : showCupertinoModalBottomSheet)<void>(
        context: context,
        builder: (context) {
          final bookmarks = Provider.of<BookmarkCollection>(context).bookmarks;
          final wordCache = Provider.of<WordCache>(context);

          return Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final word = wordCache.wordFromId(
                    bookmarks.entries.elementAt(index).key,
                  )!;

                  return AutocompleteEntryCard(
                    query: word.word,
                    word: word,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
