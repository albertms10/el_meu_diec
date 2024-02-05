import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/constants.dart';
import 'package:el_meu_diec/src/pages/word_page.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/bookmark_button.dart';
import 'package:el_meu_diec/src/widgets/definition_entry_sense_line.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntryCard extends StatelessWidget {
  final String query;
  final Word word;
  final SearchCondition searchCondition;
  final bool isLoading;

  const AutocompleteEntryCard({
    super.key,
    required this.query,
    required this.word,
    this.searchCondition = SearchCondition.defaultCondition,
    this.isLoading = false,
  });

  bool get isIncomplete => word.word.length > query.length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headlineTextStyle = theme.textTheme.headlineTextStyle;

    final (start, end) = searchCondition.highlightedRange(word.word, query) ??
        (0, word.word.length);
    final isIncompleteStart = start > 0;
    final isIncompleteEnd = end < word.word.length;

    return EquippedCard(
      height: autocompleteEntryCardHeight,
      isLoading: isLoading,
      onTap: () => showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return WordPage(word: word);
        },
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    if (isIncompleteStart)
                      TextSpan(
                        text: word.word.substring(0, start),
                        style: headlineTextStyle.copyWith(
                          color: headlineTextStyle.color!.withOpacity(0.4),
                        ),
                      ),
                    TextSpan(
                      text: word.word.substring(start, end),
                      style: headlineTextStyle,
                    ),
                    if (isIncompleteEnd)
                      TextSpan(
                        text: word.word.substring(end),
                        style: headlineTextStyle.copyWith(
                          color: headlineTextStyle.color!.withOpacity(0.4),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(width: 4),
              BookmarkButton(word: word),
            ],
          ),
          if (word.senses != null)
            DefinitionEntrySenses(word: word, isInteractive: false),
        ],
      ),
    );
  }
}

class DefinitionEntrySenses extends StatelessWidget {
  final Word word;
  final bool isInteractive;

  const DefinitionEntrySenses({
    super.key,
    required this.word,
    this.isInteractive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < word.senses!.length; i++)
          DefinitionEntrySenseLine(
            sense: word.senses![i],
            isInteractive: isInteractive,
            isFirstNumber:
                i == 0 || word.senses![i - 1].number != word.senses![i].number,
          ),
      ],
    );
  }
}
