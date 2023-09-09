import 'package:el_meu_diec/model.dart';
import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/definition_entry_sense_line.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntryCard extends StatelessWidget {
  final String query;
  final String word;
  final bool isFavorite;
  final int visits;
  final List<DefinitionEntrySense>? senses;
  final bool isLoading;

  const AutocompleteEntryCard({
    super.key,
    required this.query,
    required this.word,
    this.isFavorite = false,
    this.visits = 0,
    this.senses,
    this.isLoading = false,
  });

  bool get isIncomplete => word.length > query.length;

  String get highlightedText =>
      isIncomplete ? word.substring(0, query.length) : word;

  @override
  Widget build(BuildContext context) {
    return EquippedCard(
      height: 200,
      isLoading: isLoading,
      visits: visits,
      isFavorite: isFavorite,
      title: Text.rich(
        TextSpan(
          text: highlightedText,
          style: playfairDisplayTextTheme,
          children: [
            if (isIncomplete)
              TextSpan(
                text: word.substring(query.length),
                style: TextStyle(
                  color: playfairDisplayTextTheme.color!.withOpacity(0.4),
                ),
              ),
          ],
        ),
      ),
      child: senses == null
          ? null
          : SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < senses!.length; i++)
                    DefinitionEntrySenseLine(
                      sense: senses![i],
                      interactive: false,
                      isFirstNumber:
                          i == 0 || senses![i - 1].number != senses![i].number,
                    ),
                ],
              ),
            ),
    );
  }
}
