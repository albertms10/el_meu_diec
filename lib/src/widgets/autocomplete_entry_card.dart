import 'package:el_meu_diec/src/theme.dart';
import 'package:el_meu_diec/src/widgets/equipped_card.dart';
import 'package:flutter/material.dart';

class AutocompleteEntryCard extends StatelessWidget {
  final String query;
  final String word;
  final bool isFavorite;
  final int visits;

  const AutocompleteEntryCard({
    super.key,
    required this.query,
    required this.word,
    this.isFavorite = false,
    this.visits = 0,
  });

  bool get isIncomplete => word.length > query.length;

  String get highlightedText =>
      isIncomplete ? word.substring(0, query.length) : word;

  @override
  Widget build(BuildContext context) {
    return EquippedCard(
      title: RichText(
        text: TextSpan(
          text: highlightedText,
          style: playfairDisplayTextTheme,
          children: [
            if (isIncomplete)
              TextSpan(
                text: word.substring(query.length),
                style: playfairDisplayTextTheme.copyWith(
                  color: playfairDisplayTextTheme.color!.withOpacity(0.4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
