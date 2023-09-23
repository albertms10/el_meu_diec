import 'dart:io';

import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/constants.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/definition_entry_sense_line.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AutocompleteEntryCard extends StatelessWidget {
  final String query;
  final Word word;
  final bool isLoading;

  const AutocompleteEntryCard({
    super.key,
    required this.query,
    required this.word,
    this.isLoading = false,
  });

  bool get isIncomplete => word.word.length > query.length;

  String get highlightedText =>
      isIncomplete ? word.word.substring(0, query.length) : word.word;

  @override
  Widget build(BuildContext context) {
    return EquippedCard(
      height: autocompleteEntryCardHeight,
      isLoading: isLoading,
      onTap: () => (Platform.isAndroid
          ? showBarModalBottomSheet
          : showCupertinoModalBottomSheet)<void>(
        context: context,
        builder: (context) {
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(20),
                child: Column(
                  children: [
                    Text(word.word),
                    _DefinitionEntrySenses(word: word),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: highlightedText,
                  style: playfairDisplayTextTheme,
                  children: [
                    if (isIncomplete)
                      TextSpan(
                        text: word.word.substring(query.length),
                        style: TextStyle(
                          color:
                              playfairDisplayTextTheme.color!.withOpacity(0.4),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(width: 4),
              _BookmarkButton(word: word),
            ],
          ),
          if (word.senses != null) _DefinitionEntrySenses(word: word),
        ],
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  final Word word;

  const _BookmarkButton({super.key, required this.word});

  void _onPressed(BuildContext context) {
    final bookmarked = Provider.of<BookmarkCollection>(context, listen: false)
        .toggleBookmark(word.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: bookmarked ? 'S’ha afegit ' : 'S’ha eliminat ',
              ),
              TextSpan(
                text: word.word,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: bookmarked ? ' als marcadors.' : ' dels marcadors.',
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBookmarked =
        Provider.of<BookmarkCollection>(context).isBookmarked(word.id);

    return IconButton(
      color: theme.colorScheme.primary,
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
      ),
      enableFeedback: true,
      tooltip:
          isBookmarked ? 'Elimina dels marcadors' : 'Afegeix als marcadors',
      onPressed: () => _onPressed(context),
    );
  }
}

class _DefinitionEntrySenses extends StatelessWidget {
  final Word word;

  const _DefinitionEntrySenses({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < word.senses!.length; i++)
          DefinitionEntrySenseLine(
            sense: word.senses![i],
            interactive: false,
            isFirstNumber:
                i == 0 || word.senses![i - 1].number != word.senses![i].number,
          ),
      ],
    );
  }
}
