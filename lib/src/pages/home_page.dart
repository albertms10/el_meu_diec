import 'dart:io';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/widgets/autocomplete_entry_card.dart';
import 'package:el_meu_diec/src/widgets/search_bar_results.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  static const backgroundColor = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('El meu DIEC'),
        backgroundColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        shadowColor: backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => (Platform.isAndroid
                ? showBarModalBottomSheet
                : showCupertinoModalBottomSheet)<void>(
              context: context,
              builder: (context) {
                final bookmarks =
                    Provider.of<BookmarkCollection>(context).bookmarks;
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
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: const SafeArea(
        child: SearchBarResults(),
      ),
    );
  }
}
